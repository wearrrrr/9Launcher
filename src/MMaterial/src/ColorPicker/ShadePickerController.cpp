#include "ShadePickerController.h"

#include <QPainter>

namespace {
constexpr qreal ONETURN {360.0};
}

ShadePickerController::ShadePickerController(QQuickItem *parent)
	: QQuickPaintedItem(parent)
	, m_quadHit {UpDown::UP}
	, m_hitMode {HitPosition::IDLE}
	, m_color {Qt::red}
	, m_indicatorSize {0}{

	setAcceptedMouseButtons(Qt::AllButtons);
	setAcceptHoverEvents(true);

	connect(this, &ShadePickerController::colorChanged, this, [&] {update();});
}

void ShadePickerController::paint(QPainter *painter) {

	painter->translate(width() / 2, height() / 2);
	painter->setRenderHints(QPainter::Antialiasing, true);
	painter->setPen(Qt::NoPen);

	// Chooser
	QLinearGradient colorGradientSaturation {QPointF(0, 0), QPointF(1, 0)};
	colorGradientSaturation.setCoordinateMode(QGradient::ObjectMode);
	colorGradientSaturation.setColorAt(0, QColor::fromHsvF(m_color.hueF(), 0.0, 1.0, 1.0));
	colorGradientSaturation.setColorAt(1, QColor::fromHsvF(m_color.hueF(), 1.0, 1.0, 1.0));

	QLinearGradient colorGradientValue {QPointF(0, 0), QPointF(0, 1)};
	colorGradientValue.setCoordinateMode(QGradient::ObjectMode);
	colorGradientValue.setColorAt(0, Qt::transparent);
	colorGradientValue.setColorAt(1, Qt::black);

	const qreal localChooserWidth {m_chooserSize.width()};
	const qreal localChooserHeight {m_chooserSize.height()};

	const QPointF translateChooser {-(localChooserWidth / 2.0), -(localChooserHeight / 2.0)};

	painter->setBrush(colorGradientSaturation);
	painter->drawRoundedRect(QRectF(translateChooser, QSizeF(localChooserWidth, localChooserHeight)), 8 , 8);

	painter->setBrush(colorGradientValue);
	painter->drawRoundedRect(QRectF(translateChooser, QSizeF(localChooserWidth, localChooserHeight)), 8 , 8);

	// Draw chooser indicator
	const QPointF indicatorPosition = saturationValueFromColor(m_color);

	painter->setBrush(m_color);
	painter->setPen(QPen(Qt::white, 2, Qt::SolidLine));
	painter->drawEllipse(indicatorPosition, m_indicatorSize - 5.0, m_indicatorSize - 5.0);
}

const QColor &ShadePickerController::color() const {
	return m_color;
}

void ShadePickerController::setColor(const QColor &newColor) {
	if (m_color == newColor) {
		return;
	}

	m_color = newColor;
	emit colorChanged();
}

void ShadePickerController::setHue(qreal value) {
	setColor(QColor::fromHsvF(static_cast<float>(value), m_color.saturationF(), m_color.valueF(), m_color.alphaF()));
}

bool ShadePickerController::isHitMode() noexcept {


	if (m_chooserSize.contains(static_cast<qreal>(m_mouseVector.x()), static_cast<qreal>(m_mouseVector.y()))) {

		m_hitMode = HitPosition::CHOOSER;

		return true;
	}

	return false;
}

QColor ShadePickerController::hueAt(const QVector2D in_mouseVec) noexcept {

	const QVector2D vec {1.0, 0.0};
	qreal angle = qRadiansToDegrees(std::acos(QVector2D::dotProduct(vec, in_mouseVec) / (in_mouseVec.length()  *vec.length())));

	m_quadHit
		= getQuadrant(QPoint(static_cast<int>(mapFromGlobal(QCursor::pos()).x()), static_cast<int>(mapFromGlobal(QCursor::pos()).y())));

	if (m_quadHit == UpDown::DOWN) {
		angle = ONETURN - angle;
	}

	return QColor::fromHsvF(static_cast<float>(angle / ONETURN), m_color.hsvSaturationF(), m_color.valueF(), m_color.alphaF());
}

QColor ShadePickerController::saturationValuePositionLimit(const QVector2D position) noexcept {

	qreal x {static_cast<qreal>(position.x())};
	qreal y {static_cast<qreal>(-position.y())};

	if (m_hitMode == HitPosition::CHOOSER) {
		x = std::clamp(x, m_chooserSize.left(), m_chooserSize.right());
		y = std::clamp(y, m_chooserSize.top(), m_chooserSize.bottom());
	}

	const float m_sat = static_cast<float>(x / m_chooserSize.width()) + 0.5F;
	const float m_val = static_cast<float>(y / m_chooserSize.height()) + 0.5F;

	return QColor::fromHsvF(m_color.hsvHueF(), m_sat, m_val, m_color.alphaF());
}

QPointF ShadePickerController::saturationValueFromColor(const QColor &color) noexcept {
	return {static_cast<float>(m_chooserSize.width()  *(color.saturationF() - 0.5F)),
			 static_cast<float>(-m_chooserSize.height()  *(color.valueF() - 0.5F))};
}

ShadePickerController::UpDown ShadePickerController::getQuadrant(const QPoint position) noexcept {
	return (position.y() <= static_cast<int>(height() / 2)) ? UpDown::UP : UpDown::DOWN;
}

void ShadePickerController::updateMousePosition(const QPoint position) {
	m_mouseVector = QVector2D(static_cast<float>(position.x() - width() / 2.0F), static_cast<float>(position.y() - height() / 2.0F));
}

void ShadePickerController::mousePressEvent(QMouseEvent *event) {

	if (event->buttons() != Qt::LeftButton) {
		return;
	}

	updateMousePosition(event->pos());

	if (!isHitMode()) {
		return;
	}

	switch (m_hitMode) {
		case HitPosition::WHEEL:
			setColor(hueAt(m_mouseVector));
			setCursor(Qt::ClosedHandCursor);
			break;
		case HitPosition::CHOOSER:
			setColor(saturationValuePositionLimit(m_mouseVector));
			setCursor(Qt::BlankCursor);
			break;
		default:
			break;
	}
}

void ShadePickerController::mouseMoveEvent(QMouseEvent *event) {

	if (event->buttons() != Qt::LeftButton) {
		return;
	}

	if (m_hitMode == HitPosition::IDLE) {
		return;
	}

	updateMousePosition(event->pos());

	switch (m_hitMode) {
		case HitPosition::WHEEL:
			setColor(hueAt(m_mouseVector));
			break;

		case HitPosition::CHOOSER:
			setColor(saturationValuePositionLimit(m_mouseVector));
			break;

		default:
			break;
	}
}

void ShadePickerController::mouseReleaseEvent(QMouseEvent */*event*/) {

	if (m_hitMode != HitPosition::IDLE) {
		emit editFinished();
	}

	m_hitMode = HitPosition::IDLE;
	setCursor(Qt::ArrowCursor);
}

void ShadePickerController::geometryChange(const QRectF &newGeometry, const QRectF &/*oldGeometry*/) {

	const qreal side = std::fmin(newGeometry.width(), newGeometry.height())  *0.7;

	// Calculate chooser indicator size
	m_indicatorSize = side  *0.05;
	if (m_indicatorSize < 1.0) {
		m_indicatorSize = 1.0;
	}

	// Calculate the size for chooser
	const double diagonal = std::cos(qDegreesToRadians(45.0))  *side;
	const double gap = 0;

	const double diagonalMin = -diagonal + gap;
	const double diagonalMax = diagonal - gap;

	// Setup the rect size for color sampler
	m_chooserSize.setTopLeft(QPointF(diagonalMin, diagonalMin));
	m_chooserSize.setBottomRight(QPointF(diagonalMax, diagonalMax));
}

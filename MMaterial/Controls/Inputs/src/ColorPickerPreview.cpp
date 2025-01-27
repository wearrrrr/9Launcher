#include "ColorPickerPreview.h"

#include <QPainter>
#include <QPainterPath>
#include <QGuiApplication>
#include <QScreen>
#include <QCursor>

ColorPickerPreview::ColorPickerPreview()
	: m_previewSize {151}
	, m_size {10}
	, m_mousePosition {0, 0}
{
	setAcceptHoverEvents(true);
}

void ColorPickerPreview::paint(QPainter *painter) {
	if (!m_currentWindow) {
		return;
	}

	QCursor currentCursor = QGuiApplication::overrideCursor() ? *QGuiApplication::overrideCursor() : QCursor();
	QPixmap cursorPixmap = currentCursor.pixmap();

	// Adjust the coordiates so it's in the middle of the cursor
	if (!cursorPixmap.isNull()) {
		QSize cursorSize = cursorPixmap.size();
		m_mousePosition = {m_mousePosition.x() - cursorSize.width() / 2, m_mousePosition.y() - cursorSize.height() / 2};
	}

	const auto screen = m_currentWindow->screen();
	QPoint globalMousePos = m_currentWindow->mapToGlobal(m_mousePosition.toPoint());
	// Convert global mouse position to the local coordinates of the target window
	QPoint localMousePos = m_currentWindow->mapFromGlobal(globalMousePos);

	const auto windowSize {screen->availableSize()};
	const bool flipX {localMousePos.x() > (windowSize.width() - m_previewSize)};
	const bool flipY {localMousePos.y() > (windowSize.height() - m_previewSize)};

	const double sizeHalf = (m_size - 1) / 2.0;
	const double sizePreviewHalf = (m_previewSize - 1) / 2.0;

	const auto pixmap = QGuiApplication::screenAt(globalMousePos)->grabWindow(
			0, localMousePos.x() - sizeHalf, localMousePos.y() - sizeHalf, m_size, m_size);

	painter->setRenderHints(QPainter::Antialiasing, true);
	painter->setPen(QPen(QBrush(Qt::black), 4.0, Qt::SolidLine));

	const QPointF coord(flipX ? localMousePos.x() - m_size - m_previewSize : localMousePos.x() + m_size,
						 flipY ? localMousePos.y() - m_size - m_previewSize : localMousePos.y() + m_size);

	QPainterPath path;
	path.addEllipse(coord.x(), coord.y(), m_previewSize, m_previewSize);
	painter->setClipPath(path);
	painter->drawPixmap(coord.x(), coord.y(), m_previewSize, m_previewSize, pixmap);
	painter->drawEllipse(coord.x(), coord.y(), m_previewSize, m_previewSize);

	// Center Point
	const auto fSize = m_previewSize / m_size;
	painter->setPen(Qt::white);
	painter->drawRect(coord.x() + sizePreviewHalf - (fSize / 2), coord.y() + sizePreviewHalf - (fSize / 2), fSize, fSize);
}


qreal ColorPickerPreview::previewSize() const {
	return m_previewSize;
}

void ColorPickerPreview::setPreviewSize(qreal newPreviewSize) {
	if (qFuzzyCompare(m_previewSize, newPreviewSize)) {
		return;
	}
	const auto tmp {2  *((int)(newPreviewSize / 2.0F)) + 1};
	m_previewSize = tmp;
	emit previewSizeChanged();
}

qreal ColorPickerPreview::size() const {
	return m_size;
}

void ColorPickerPreview::setSize(qreal newSize) {
	if (qFuzzyCompare(m_size, newSize)) {
		return;
	}

	const auto tmp {2  *((int)(newSize / 2.0F)) + 1};
	m_size = std::clamp(tmp, 3, 15);
	emit sizeChanged();
}

QPointF ColorPickerPreview::mousePosition() const {
	return m_mousePosition;
}

void ColorPickerPreview::setMousePosition(QPointF newMousePosition) {
	if (m_mousePosition == newMousePosition) {
		return;
	}
	m_mousePosition = newMousePosition;
	emit mousePositionChanged();
}

QQuickWindow* ColorPickerPreview::currentWindow() const
{
	return m_currentWindow;
}

void ColorPickerPreview::setCurrentWindow(QQuickWindow* newCurrentWindow)
{
	if (m_currentWindow == newCurrentWindow)
		return;
	m_currentWindow = newCurrentWindow;
	emit currentWindowChanged();
}

void ColorPickerPreview::setScreen(QScreen* screen, QQuickWindow* window)
{
	setCurrentWindow(window);
	window->setScreen(screen);
}

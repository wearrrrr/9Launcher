#include "ColorPickerController.h"

#include <QGuiApplication>
#include <QScreen>
#include <QImage>
#include <QPixmap>

ColorPickerController::ColorPickerController(QObject *parent)
	: QObject {parent}
	, m_color {Qt::red}
	, m_picking {false}{}

const QColor &ColorPickerController::color() const {
	return m_color;
}

void ColorPickerController::setColor(const QColor &newColor) {
	if (m_color == newColor) {
		return;
	}
	m_color = newColor;
	emit colorChanged();
}

void ColorPickerController::eyedrop(const QPointF mousePosition) {

	const auto pixmap
		= QGuiApplication::primaryScreen()->grabWindow(0, static_cast<int>(mousePosition.x()), static_cast<int>(mousePosition.y()), 1, 1);
	const QImage img = pixmap.toImage();
	m_color = QColor(img.pixel(0, 0));
	emit colorChanged();
}

bool ColorPickerController::picking() const {
	return m_picking;
}

void ColorPickerController::setPicking(bool newPicking) {
	if (m_picking == newPicking) {
		return;
	}
	m_picking = newPicking;
	emit pickingChanged();
}

const QColor &ColorPickerController::oldColor() const {

	return m_oldColor;
}

void ColorPickerController::setOldColor(const QColor &newOldColor) {
	if (m_oldColor == newOldColor) {
		return;
	}
	m_oldColor = newOldColor;
	emit oldColorChanged();
}

void ColorPickerController::startPicking() {
	m_oldColor = m_color;
}

void ColorPickerController::revertPicking() {
	setColor(m_oldColor);
}

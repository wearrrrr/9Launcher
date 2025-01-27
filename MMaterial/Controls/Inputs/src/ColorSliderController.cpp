#include "ColorSliderController.h"

ColorSliderController::ColorSliderController(QObject *parent)
	: QObject {parent}
	, value_ {0.0}{}

qreal ColorSliderController::value() const {
	return value_;
}

void ColorSliderController::setValue(qreal newValue) {
	if (qFuzzyCompare(value_, newValue)) {
		return;
	}
	value_ = newValue;
	emit valueChanged();
}

void ColorSliderController::increase(const qreal stepSize) {
	const auto tmp = value_ + stepSize;
	value_ = std::clamp(tmp, 0.0, 1.0);
	emit valueChanged();
}

void ColorSliderController::decrease(qreal stepSize) {
	const auto tmp = value_ - stepSize;
	value_ = std::clamp(tmp, 0.0, 1.0);
	emit valueChanged();
}

#include "ColorUtils.h"
#include <QColor>

bool ColorUtils::isSimilar(const QColor &color1, const QColor &color2, double threshold)
{
	if (color1.red() == color2.red() && color1.green() == color2.green() && color1.blue() == color2.blue())
		return true;

	return colorDistance(color1, color2) < threshold;
}

double ColorUtils::colorDistance(const QColor &color1, const QColor &color2)
{
	const double rDiff = color1.redF() - color2.redF();
	const double gDiff = color1.greenF() - color2.greenF();
	const double bDiff = color1.blueF() - color2.blueF();

	return std::sqrt(rDiff*rDiff + gDiff*gDiff + bDiff*bDiff);
}

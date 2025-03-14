#pragma once

#include <QObject>
#include <QtQmlIntegration>


class QColor;
class ColorUtils : public QObject
{
	Q_OBJECT
	QML_ELEMENT

public:
	Q_INVOKABLE static bool isSimilar(const QColor &color1, const QColor &color2, double threshold = 0.05);

private:
	static double colorDistance(const QColor &color1, const QColor &color2);

};

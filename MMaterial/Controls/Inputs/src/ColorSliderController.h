#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>

class ColorSliderController : public QObject
{
	Q_OBJECT
	QML_ELEMENT

	Q_PROPERTY(qreal value READ value WRITE setValue NOTIFY valueChanged)

public:
	explicit ColorSliderController(QObject *parent = nullptr);

	qreal value() const;
	void setValue(qreal newValue);

	Q_INVOKABLE void increase(qreal stepSize);
	Q_INVOKABLE void decrease(qreal stepSize);

private:
	qreal value_;

signals:
	void valueChanged();

};

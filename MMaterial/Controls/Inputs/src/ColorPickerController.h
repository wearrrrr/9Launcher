#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>
#include <QPointF>

class ColorPickerController : public QObject
{
	Q_OBJECT
	QML_ELEMENT

	Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
	Q_PROPERTY(QColor oldColor READ oldColor WRITE setOldColor NOTIFY oldColorChanged)
	Q_PROPERTY(bool picking READ picking WRITE setPicking NOTIFY pickingChanged)

public:
	explicit ColorPickerController(QObject *parent = nullptr);

	const QColor &color() const;
	void setColor(const QColor &newColor);

	Q_INVOKABLE void eyedrop(QPointF mousePosition);

	bool picking() const;
	void setPicking(bool newPicking);

	const QColor &oldColor() const;
	void setOldColor(const QColor &newOldColor);

	Q_INVOKABLE void startPicking();
	Q_INVOKABLE void revertPicking();

private:
	QColor m_color;
	bool m_picking;
	QColor m_oldColor;

signals:
	void colorChanged();
	void pickingChanged();
	void oldColorChanged();
};

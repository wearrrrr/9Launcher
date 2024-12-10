#pragma once

#include <QtQuick>

class ShadePickerController : public QQuickPaintedItem
{

	Q_OBJECT
	QML_NAMED_ELEMENT(ShadeChooser)

	Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)

public:
	explicit ShadePickerController(QQuickItem *parent = nullptr);

	void paint(QPainter *painter) override;

	const QColor &color() const;
	void setColor(const QColor &newColor);

	Q_INVOKABLE void setHue(qreal value);

private:
	enum class HitPosition { IDLE, WHEEL, CHOOSER };
	enum class UpDown { UP, DOWN };

	bool isHitMode() noexcept;
	QColor hueAt(QVector2D in_mouseVec) noexcept;
	QColor saturationValuePositionLimit(QVector2D position) noexcept;
	QPointF saturationValueFromColor(const QColor &color) noexcept;
	UpDown getQuadrant(QPoint position) noexcept;
	void updateMousePosition(QPoint position);

	UpDown m_quadHit;
	HitPosition m_hitMode;
	QColor m_color;
	QRectF m_chooserSize;
	QVector2D m_mouseVector;
	qreal m_indicatorSize;

protected:
	void mousePressEvent(QMouseEvent *event) override;
	void mouseMoveEvent(QMouseEvent *event) override;
	void mouseReleaseEvent(QMouseEvent *event) override;
	void geometryChange(const QRectF &newGeometry, const QRectF &oldGeometry) override;

Q_SIGNALS:
	void colorChanged();
	void editFinished();
};

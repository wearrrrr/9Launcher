#pragma once

#include <QQuickPaintedItem>
#include <QPointF>
#include <QQuickWindow>

class ColorPickerPreview : public QQuickPaintedItem
{
	Q_OBJECT
	QML_ELEMENT

	Q_PROPERTY(qreal previewSize READ previewSize WRITE setPreviewSize NOTIFY previewSizeChanged)
	Q_PROPERTY(qreal size READ size WRITE setSize NOTIFY sizeChanged)
	Q_PROPERTY(QPointF mousePosition READ mousePosition WRITE setMousePosition NOTIFY mousePositionChanged)
	Q_PROPERTY(QQuickWindow* currentWindow READ currentWindow WRITE setCurrentWindow NOTIFY currentWindowChanged FINAL)

public:
	ColorPickerPreview();

	void paint(QPainter *painter) override;

	qreal previewSize() const;
	void setPreviewSize(qreal newPreviewSize);

	qreal size() const;
	void setSize(qreal newSize);

	QPointF mousePosition() const;
	void setMousePosition(QPointF newMousePosition);

	QQuickWindow* currentWindow() const;
	void setCurrentWindow(QQuickWindow* newCurrentWindow);

	Q_INVOKABLE void setScreen(QScreen* screen, QQuickWindow* window);

private:
	qreal m_previewSize;
	qreal m_size;
	QPointF m_mousePosition;
	QQuickWindow* m_currentWindow = nullptr;

signals:
	void previewSizeChanged();
	void sizeChanged();
	void mousePositionChanged();
	void currentWindowChanged();
};

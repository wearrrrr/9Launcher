#pragma once

#include <QAbstractListModel>
#include <qqmlintegration.h>
#include <QColor>

class ColorHistoryModel : public QAbstractListModel
{
	Q_OBJECT
	QML_ELEMENT
	QML_SINGLETON

	Q_PROPERTY(int historySize READ historySize WRITE setHistorySize NOTIFY historySizeChanged)

public:
	enum ColorHistoryRoles { Color = Qt::UserRole + 1 };
	explicit ColorHistoryModel(QObject *parent = nullptr);

	int rowCount(const QModelIndex &parent) const override;
	QVariant data(const QModelIndex &index, int role) const override;
	bool setData(const QModelIndex &index, const QVariant &value, int role) override;
	QHash<int, QByteArray> roleNames() const override;
	Qt::ItemFlags flags(const QModelIndex &index) const override;

	Q_INVOKABLE QColor at(int row);
	Q_INVOKABLE void append(const QColor &newColor);
	Q_INVOKABLE void clear();
	Q_INVOKABLE void removeAt(int row);

	int historySize() const;
	void setHistorySize(int newHistorySize);

private:
	QList<QColor> m_colors;
	int m_historySize;

signals:
	void historySizeChanged();
};

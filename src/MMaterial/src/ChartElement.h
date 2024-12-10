#pragma once

#include <QObject>
#include <QAbstractListModel>
#include <QQmlListProperty>
#include <qqmlintegration.h>

class ChartElementBar : public QObject
{
	Q_OBJECT
	QML_ELEMENT

	Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
	Q_PROPERTY(double value READ value WRITE setValue NOTIFY valueChanged FINAL)
	Q_PROPERTY(QString color READ color WRITE setColor NOTIFY colorChanged FINAL)
	Q_PROPERTY(bool selected READ selected WRITE setSelected NOTIFY selectedChanged FINAL)

public:
	ChartElementBar(QObject* parent = nullptr);

	QString name() const;
	void setName(const QString& newName);

	double value() const;
	void setValue(double newValue);

	QString color() const;
	void setColor(const QString& newColor);

	bool selected() const;
	void setSelected(bool newSelected);

signals:
	void nameChanged();
	void valueChanged();
	void colorChanged();
	void selectedChanged();

private:
	QString m_name;
	double m_value = 1;
	QString m_color;
	bool m_selected = false;
};

class ChartElement : public QAbstractListModel
{
	Q_OBJECT
	QML_ELEMENT

	Q_PROPERTY(QQmlListProperty<ChartElementBar> bars READ model)
	Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
	Q_PROPERTY(double peak READ peak NOTIFY peakChanged FINAL)
	Q_PROPERTY(double trough READ trough NOTIFY troughChanged FINAL)

public:
	ChartElement(QObject* parent = nullptr);

	enum RoleNames
	{
		NameRole = Qt::UserRole + 1,
		BarNameRole,
		BarValueRole,
		BarColorRole,
		BarSelectedRole,
		BarObjectRole
	};

	int rowCount(const QModelIndex& parent) const override;
	QVariant data(const QModelIndex& index, int role) const override;
	bool setData(const QModelIndex& index, const QVariant& value, int role) override;
	QHash<int, QByteArray> roleNames() const override;

	Q_INVOKABLE void insert(int index, ChartElementBar* bar);
	Q_INVOKABLE void insertEmpty(int index);
	Q_INVOKABLE void remove(int index);
	Q_INVOKABLE ChartElementBar* createEmpty();
	Q_INVOKABLE ChartElementBar* at(int index);

	QList<ChartElementBar*> bars() const;
	void setBars(const QList<ChartElementBar*>& newBars);

	QQmlListProperty<ChartElementBar> model();

	QString name() const;
	void setName(const QString& newName);

	Q_INVOKABLE double getMaxValue() const;
	Q_INVOKABLE void refreshExtremas();

	double peak() const;
	double trough() const;

Q_SIGNALS:
	void nameChanged();
	void peakChanged();
	void troughChanged();

private:
	QList<ChartElementBar*> m_bars;
	QString m_name;

	double m_peak = 0;
	double m_trough = 0;
};

class ChartModel : public QAbstractListModel
{
	Q_OBJECT
	QML_ELEMENT
	Q_PROPERTY(QQmlListProperty<ChartElement> model READ model)
	Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
	ChartModel(QObject* parent = nullptr);

	enum RoleNames {
		ElementRole = Qt::UserRole + 1,
		NameRole
	};

	int count();
	int rowCount(const QModelIndex& parent) const override;
	QVariant data(const QModelIndex& index, int role) const override;
	bool setData(const QModelIndex &index, const QVariant &value, int role) override;

	QHash<int, QByteArray> roleNames() const override;

	QList<ChartElement*> elements() const;
	void setElements(const QList<ChartElement*>& newElements);

	Q_INVOKABLE void insert(int index, ChartElement* bar);
	Q_INVOKABLE void insertEmpty(int index);
	Q_INVOKABLE void remove(int index);

	Q_INVOKABLE double getMinValue() const;
	Q_INVOKABLE double getMaxValue() const;

	QQmlListProperty<ChartElement> model();

Q_SIGNALS:
	void countChanged();

private:
	QList<ChartElement*> m_elements;

};

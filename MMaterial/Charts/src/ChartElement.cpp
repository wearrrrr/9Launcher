#include "ChartElement.h"

ChartElementBar::ChartElementBar(QObject* parent)
	: QObject(parent)
{

}

QString ChartElementBar::name() const
{
	return m_name;
}

void ChartElementBar::setName(const QString& newName)
{
	if (m_name == newName)
		return;
	m_name = newName;
	emit nameChanged();
}

double ChartElementBar::value() const
{
	return m_value;
}

void ChartElementBar::setValue(double newValue)
{
	if (m_value == newValue)
		return;
	m_value = newValue;
	emit valueChanged();
}

QString ChartElementBar::color() const
{
	return m_color;
}

void ChartElementBar::setColor(const QString& newColor)
{
	if (m_color == newColor)
		return;
	m_color = newColor;
	emit colorChanged();
}

bool ChartElementBar::selected() const
{
	return m_selected;
}

void ChartElementBar::setSelected(bool newSelected)
{
	if (m_selected == newSelected)
		return;
	m_selected = newSelected;
	emit selectedChanged();
}

ChartElement::ChartElement(QObject* parent)
	: QAbstractListModel(parent)
{

}

int ChartElement::rowCount(const QModelIndex& parent) const
{
	Q_UNUSED(parent)
	return m_bars.size();
}

QVariant ChartElement::data(const QModelIndex& index, int role) const
{
	if (!index.isValid())
		return QVariant();

	if (index.row() >= m_bars.size())
		return QVariant();

	if (role == NameRole)
		return m_name;
	else if (role == BarNameRole)
		return m_bars.at(index.row())->name();
	else if (role == BarValueRole)
		return m_bars.at(index.row())->value();
	else if (role == BarColorRole)
		return m_bars.at(index.row())->color();
	else if (role == BarSelectedRole)
		return m_bars.at(index.row())->selected();
	else if (role == BarObjectRole)
		return QVariant::fromValue(m_bars.at(index.row()));

	return QVariant();
}

bool ChartElement::setData(const QModelIndex& index, const QVariant& value, int role)
{
	if (!index.isValid())
		return false;

	if (index.row() >= m_bars.size())
		return false;

	if (role == NameRole)
	{
		m_name = value.toString();
		emit dataChanged(index, index);
		return true;
	}
	else if (role == BarNameRole)
	{
		m_bars.at(index.row())->setName(value.toString());
		emit dataChanged(index, index);
		return true;
	}
	else if (role == BarValueRole)
	{
		m_bars.at(index.row())->setValue(value.toDouble());
		emit dataChanged(index, index);
		return true;
	}
	else if (role == BarColorRole)
	{
		m_bars.at(index.row())->setColor(value.toString());
		emit dataChanged(index, index);
		return true;
	}
	else if (role == BarSelectedRole)
	{
		m_bars.at(index.row())->setSelected(value.toBool());
		emit dataChanged(index, index);
		return true;
	}

	return false;
}

QHash<int, QByteArray> ChartElement::roleNames() const
{
	QHash<int, QByteArray> roles;
	roles[NameRole] = "name";
	roles[BarNameRole] = "barName";
	roles[BarValueRole] = "barValue";
	roles[BarColorRole] = "barColor";
	roles[BarSelectedRole] = "barSelected";
	roles[BarObjectRole] = "barObject";
	return roles;
}

void ChartElement::insert(int index, ChartElementBar* bar)
{
	beginInsertRows(QModelIndex(), index, index);
	m_bars.insert(index, bar);
	endInsertRows();
}

void ChartElement::insertEmpty(int index)
{
	insert(index, new ChartElementBar(this));
}

void ChartElement::remove(int index)
{
	beginRemoveRows(QModelIndex(), index, index);
	m_bars.takeAt(index)->deleteLater();
	endRemoveRows();
}

ChartElementBar* ChartElement::createEmpty()
{
	return new ChartElementBar(this);
}

ChartElementBar* ChartElement::at(int index)
{
	return m_bars.at(index);
}

QList<ChartElementBar*> ChartElement::bars() const
{
	return m_bars;
}

void ChartElement::setBars(const QList<ChartElementBar*>& newBars)
{
	if (m_bars == newBars)
		return;
	m_bars = newBars;
}

QQmlListProperty<ChartElementBar> ChartElement::model() { return QQmlListProperty<ChartElementBar>(this, &m_bars); }

QString ChartElement::name() const
{
	return m_name;
}

void ChartElement::setName(const QString& newName)
{
	m_name = newName;
	emit nameChanged();
}

double ChartElement::getMaxValue() const
{
	double max = 0;
	for (auto bar : m_bars)
	{
		if (bar->value() > max)
			max = bar->value();
	}
	return max;
}

void ChartElement::refreshExtremas()
{
	double max = 0;
	double min = 0;
	for (auto bar : m_bars)
	{
		if (bar->value() > max)
			max = bar->value();
		if (bar->value() < min)
			min = bar->value();
	}

	m_peak = max;
	m_trough = min;

	emit peakChanged();
	emit troughChanged();
}

double ChartElement::peak() const
{
	return m_peak;
}

double ChartElement::trough() const
{
	return m_trough;
}

ChartModel::ChartModel(QObject* parent)
	: QAbstractListModel(parent)
{

}

int ChartModel::count()
{
	return m_elements.size();
}

int ChartModel::rowCount(const QModelIndex& parent) const
{
	Q_UNUSED(parent)
	return m_elements.size();
}

QVariant ChartModel::data(const QModelIndex& index, int role) const
{
	if (!index.isValid())
		return QVariant();

	if (index.row() >= m_elements.size())
		return QVariant();

	if (role == ElementRole)
		return QVariant::fromValue(m_elements.at(index.row()));
	else if (role == NameRole)
		return m_elements.at(index.row())->name();

	return QVariant();
}

bool ChartModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
	if (!index.isValid())
		return false;

	if (index.row() >= m_elements.size())
		return false;

	if (role == NameRole)
		m_elements.at(index.row())->setName(value.toString());

	emit dataChanged(index, index, { role });

	return true;
}

QHash<int, QByteArray> ChartModel::roleNames() const
{
	QHash<int, QByteArray> roles;
	roles[ElementRole] = "element";
	roles[NameRole] = "name";
	return roles;
}

QList<ChartElement*> ChartModel::elements() const
{
	return m_elements;
}

void ChartModel::setElements(const QList<ChartElement*>& newElements)
{
	if (m_elements == newElements)
		return;
	m_elements = newElements;
}

void ChartModel::insert(int index, ChartElement* bar)
{
	beginInsertRows(QModelIndex(), index, index);
	m_elements.insert(index, bar);
	endInsertRows();

	emit countChanged();
}

void ChartModel::insertEmpty(int index)
{
	insert(index, new ChartElement(this));
}

void ChartModel::remove(int index)
{
	beginRemoveRows(QModelIndex(), index, index);
	m_elements.takeAt(index)->deleteLater();
	endRemoveRows();

	emit countChanged();
}

double ChartModel::getMinValue() const
{
	double min = std::numeric_limits<double>::max();
	for (auto element : m_elements)
	{
		for (auto bar : element->bars())
		{
			if (bar->value() < min)
				min = bar->value();
		}
	}
	return min;
}

double ChartModel::getMaxValue() const
{
	double max = m_elements.size() == 0 ? 0 : std::numeric_limits<double>::min();
	for (auto element : m_elements)
	{
		double elementMax = element->getMaxValue();

		if (elementMax > max)
			max = elementMax;
	}
	return max;
}

QQmlListProperty<ChartElement> ChartModel::model() { return QQmlListProperty<ChartElement>(this, &m_elements); }

#include "colorhistorymodel.h"

using namespace Qt::Literals;

ColorHistoryModel::ColorHistoryModel( QObject* parent )
    : QAbstractListModel { parent }
    , m_historySize { 10 } { }


int ColorHistoryModel::rowCount( const QModelIndex& parent ) const {
    if ( !parent.isValid() ) {
        return static_cast<int>( m_colors.size() );
    }
    return 0;
}

QVariant ColorHistoryModel::data( const QModelIndex& index, int role ) const {

    if ( !checkIndex( index, CheckIndexOption::IndexIsValid ) ) {
        return {};
    }

    const auto color { m_colors.at( index.row() ) };

    if ( role == Color ) {
        return color;
    }

    return {};
}

bool ColorHistoryModel::setData( const QModelIndex& index, const QVariant& value, int role ) {

    if ( role != Qt::EditRole ) {
        return false;
    }

    const auto row { index.row() };

    const auto color { value.value<QColor>() };

    if ( m_colors.at( row ) == color ) {
        return false;
    }

    m_colors[row] = color;

    Q_EMIT dataChanged( index, index );

    return true;
}


QHash<int, QByteArray> ColorHistoryModel::roleNames() const {
    static const QHash<int, QByteArray> roles { { Color, "colorRole"_ba } };
    return roles;
}

Qt::ItemFlags ColorHistoryModel::flags( const QModelIndex& index ) const {
    if ( !index.isValid() ) {
        return Qt::NoItemFlags;
    }

    return QAbstractListModel::flags( index ) | Qt::ItemIsEditable;
}

bool ColorHistoryModel::removeRows( int row, int count, const QModelIndex& parent ) {

    if ( row < 0 && row >= m_colors.size() ) {
        return false;
    }

    beginRemoveRows( parent, row, count );
    m_colors.removeAt( row );
    endRemoveRows();
    return true;
}

void ColorHistoryModel::append( const QColor& newColor ) {

    if ( m_colors.contains( newColor ) || !m_colors.isEmpty() && m_colors.first().rgb() == newColor.rgb() ) {
        return;
    }

    const auto index { static_cast<int>( m_colors.size() - 1 ) };

    if ( m_colors.size() >= m_historySize ) {
        beginRemoveRows( QModelIndex(), index, index );
        m_colors.removeFirst();
        endRemoveRows();
    }

    beginInsertRows( QModelIndex(), 0, 0 );
    m_colors.prepend( newColor );
    endInsertRows();
}

void ColorHistoryModel::clear() {
    beginResetModel();
    m_colors.clear();
    endResetModel();
}

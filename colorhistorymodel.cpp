#include "colorhistorymodel.h"

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
    QHash<int, QByteArray> roles;
    roles[Color] = "color";
    return roles;
}

Qt::ItemFlags ColorHistoryModel::flags( const QModelIndex& index ) const {
    if ( !index.isValid() ) {
        return Qt::NoItemFlags;
    }

    return QAbstractListModel::flags( index ) | Qt::ItemIsEditable;
}

QColor ColorHistoryModel::at( int row ) {
    if ( row < 0 || row >= m_colors.size() ) {
        return {};
    }

    return m_colors.at( row );
}

void ColorHistoryModel::append( const QColor& newColor ) {

    const auto index { static_cast<int>( m_colors.size() - 1 ) };

    auto insert = [&] {
        beginInsertRows( QModelIndex(), 0, 0 );
        m_colors.insert( 0, newColor );
        endInsertRows();
    };

    if ( index < 1 ) {
        insert();
    }

    if ( m_colors.contains( newColor ) ) {
        return;
    }

    if ( m_colors.size() < m_historySize ) {
        insert();
        return;
    }

    beginRemoveRows( QModelIndex(), index, index );
    m_colors.removeFirst();
    endRemoveRows();
    insert();
}

void ColorHistoryModel::clear() {
    beginResetModel();
    m_colors.clear();
    endResetModel();
}

void ColorHistoryModel::removeAt( int row ) {
    beginRemoveRows( QModelIndex(), row, row );
    m_colors.removeAt( row );
    endRemoveRows();
}

int ColorHistoryModel::historySize() const {
    return m_historySize;
}

void ColorHistoryModel::setHistorySize( int newHistorySize ) {
    if ( m_historySize == newHistorySize ) {
        return;
    }
    m_historySize = newHistorySize;
    Q_EMIT historySizeChanged();
}

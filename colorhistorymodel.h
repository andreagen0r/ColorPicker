#pragma once

#include <QAbstractListModel>
#include <QQmlEngine>
#include <QColor>

class ColorHistoryModel : public QAbstractListModel {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( int historySize MEMBER m_historySize NOTIFY historySizeChanged FINAL )

public:
    enum ColorHistoryRoles {
        Color = Qt::UserRole + 1,
    };

    explicit ColorHistoryModel( QObject* parent = nullptr );

    [[nodiscard]] int rowCount( const QModelIndex& parent ) const override;
    [[nodiscard]] QVariant data( const QModelIndex& index, int role ) const override;
    [[nodiscard]] bool setData( const QModelIndex& index, const QVariant& value, int role ) override;
    [[nodiscard]] QHash<int, QByteArray> roleNames() const override;
    [[nodiscard]] Qt::ItemFlags flags( const QModelIndex& index ) const override;
    bool removeRows( int row, int count, const QModelIndex& parent ) override;

    Q_INVOKABLE void append( const QColor& newColor );
    Q_INVOKABLE void clear();

Q_SIGNALS:
    void historySizeChanged();

private:
    QList<QColor> m_colors;
    int m_historySize;
};

#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>

class ColorPicker_p : public QObject {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor color READ color WRITE setColor NOTIFY colorChanged FINAL )

public:
    explicit ColorPicker_p( QObject* parent = nullptr );

    [[nodiscard]] const QColor& color() const;
    Q_INVOKABLE void setColor( const QColor& newColor );

signals:
    void colorChanged();

private:
    QColor m_color;
};

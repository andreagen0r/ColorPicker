#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>
#include <QPointF>

class ColorPicker_p : public QObject {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor color READ color WRITE setColor NOTIFY colorChanged FINAL )
    Q_PROPERTY( QColor oldColor READ oldColor WRITE setOldColor NOTIFY oldColorChanged )
    Q_PROPERTY( bool picking READ picking WRITE setPicking NOTIFY pickingChanged )

public:
    explicit ColorPicker_p( QObject* parent = nullptr );

    [[nodiscard]] const QColor& color() const;
    Q_INVOKABLE void setColor( const QColor& newColor );

    Q_INVOKABLE void eyedrop( QPointF mousePosition );

    [[nodiscard]] bool picking() const;
    void setPicking( bool newPicking );

    [[nodiscard]] const QColor& oldColor() const;
    Q_INVOKABLE void setOldColor( const QColor& newOldColor );

    Q_INVOKABLE void startPicking();
    Q_INVOKABLE void revertPicking();


Q_SIGNALS:
    void colorChanged();
    void pickingChanged();

    void oldColorChanged();

private:
    QColor m_color;
    bool m_picking;
    QColor m_oldColor;
};

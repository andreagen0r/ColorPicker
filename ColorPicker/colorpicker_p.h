#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>
#include <QPointF>

class ColorPicker_p : public QObject {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor color MEMBER m_color NOTIFY colorChanged FINAL )
    Q_PROPERTY( QColor oldColor MEMBER m_oldColor NOTIFY colorChanged FINAL )
    Q_PROPERTY( bool picking MEMBER m_picking NOTIFY pickingChanged )

public:
    explicit ColorPicker_p( QObject* parent = nullptr );

    Q_INVOKABLE void eyedrop( QPointF mousePosition );

    Q_INVOKABLE void startPicking();
    Q_INVOKABLE void revertPicking();

Q_SIGNALS:
    void colorChanged();
    void pickingChanged();

private:
    QColor m_color;
    QColor m_oldColor;
    bool m_picking;
};

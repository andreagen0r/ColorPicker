#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>

class ColorSampler_p : public QObject {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor color READ color WRITE setColor NOTIFY colorChanged )
public:
    explicit ColorSampler_p( QObject* parent = nullptr );

    [[nodiscard]] const QColor& color() const;
    Q_INVOKABLE void setColor( const QColor& newColor );

    Q_INVOKABLE void setRed( qreal r );
    Q_INVOKABLE void setGreen( qreal g );
    Q_INVOKABLE void setBlue( qreal b );
    Q_INVOKABLE void setAlpha( qreal a );

    Q_INVOKABLE void setHue( qreal hue );
    Q_INVOKABLE void setSaturation( qreal saturation );
    Q_INVOKABLE void setValue( qreal value );

Q_SIGNALS:
    void colorChanged();

private:
    QColor m_color;
};

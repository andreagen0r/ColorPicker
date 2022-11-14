#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>

class ColorSlider_p : public QObject {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( qreal value READ value WRITE setValue NOTIFY valueChanged )

public:
    explicit ColorSlider_p( QObject* parent = nullptr );

    [[nodiscard]] qreal value() const;
    Q_INVOKABLE void setValue( qreal newValue );

    Q_INVOKABLE void increase( qreal stepSize );
    Q_INVOKABLE void decrease( qreal stepSize );

Q_SIGNALS:
    void valueChanged();

private:
    qreal m_value;
};

#include "colorslider_p.h"

ColorSlider_p::ColorSlider_p( QObject* parent )
    : QObject { parent }
    , m_value { 0.0 } { }

qreal ColorSlider_p::value() const {
    return m_value;
}

void ColorSlider_p::setValue( qreal newValue ) {
    if ( qFuzzyCompare( m_value, newValue ) ) {
        return;
    }
    m_value = newValue;
    Q_EMIT valueChanged();
}

void ColorSlider_p::increase( const qreal stepSize ) {
    const auto tmp = m_value + stepSize;
    m_value = std::clamp( tmp, 0.0, 1.0 );
    Q_EMIT valueChanged();
}

void ColorSlider_p::decrease( qreal stepSize ) {
    const auto tmp = m_value - stepSize;
    m_value = std::clamp( tmp, 0.0, 1.0 );
    Q_EMIT valueChanged();
}

#include "colorsampler_p.h"

ColorSampler_p::ColorSampler_p( QObject* parent )
    : QObject { parent }
    , m_color { Qt::white } { }

const QColor& ColorSampler_p::color() const {
    return m_color;
}

void ColorSampler_p::setColor( const QColor& newColor ) {
    if ( m_color == newColor ) {
        return;
    }
    m_color = newColor;
    Q_EMIT colorChanged();
}

void ColorSampler_p::setRed( qreal r ) {
    if ( m_color.redF() == r ) {
        return;
    }
    m_color.setRedF( static_cast<float>( r ) );
    Q_EMIT colorChanged();
}

void ColorSampler_p::setGreen( qreal g ) {
    if ( m_color.greenF() == g ) {
        return;
    }
    m_color.setGreenF( static_cast<float>( g ) );
    Q_EMIT colorChanged();
}

void ColorSampler_p::setBlue( qreal b ) {
    if ( m_color.blueF() == b ) {
        return;
    }
    m_color.setBlueF( static_cast<float>( b ) );
    Q_EMIT colorChanged();
}

void ColorSampler_p::setAlpha( qreal a ) {
    if ( m_color.alphaF() == a ) {
        return;
    }
    m_color.setAlphaF( static_cast<float>( a ) );
    Q_EMIT colorChanged();
}

void ColorSampler_p::setHue( qreal hue ) {
    if ( m_color.hueF() == hue ) {
        return;
    }
    m_color.setHsvF( static_cast<float>( hue ), m_color.saturationF(), m_color.valueF() );
    Q_EMIT colorChanged();
}

void ColorSampler_p::setSaturation( qreal saturation ) {
    if ( m_color.saturationF() == saturation ) {
        return;
    }
    m_color.setHsvF( m_color.hsvHueF(), static_cast<float>( saturation ), m_color.valueF() );
    Q_EMIT colorChanged();
}

void ColorSampler_p::setValue( qreal value ) {
    if ( m_color.valueF() == value ) {
        return;
    }
    m_color.setHsvF( m_color.hsvHueF(), m_color.saturationF(), static_cast<float>( value ) );
    Q_EMIT colorChanged();
}

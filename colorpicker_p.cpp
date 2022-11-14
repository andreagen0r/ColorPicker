#include "colorpicker_p.h"

ColorPicker_p::ColorPicker_p( QObject* parent )
    : QObject { parent }
    , m_color { Qt::white } { }

const QColor& ColorPicker_p::color() const {
    return m_color;
}

void ColorPicker_p::setColor( const QColor& newColor ) {
    if ( m_color == newColor ) {
        return;
    }
    m_color = newColor;
    Q_EMIT colorChanged();
}

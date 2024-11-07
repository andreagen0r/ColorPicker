#include "colortool_p.h"

ColorTool_p::ColorTool_p( QObject* parent )
    : QObject { parent }
    , m_primary { Qt::black }
    , m_secondary { Qt::white }
    , m_currentColor { Qt::white }
    , m_swapSwatch { false } { }

const QColor& ColorTool_p::primary() const {
    return m_primary;
}

void ColorTool_p::setPrimary( const QColor& newPrimary ) {
    if ( m_primary == newPrimary ) {
        return;
    }
    m_primary = newPrimary;
    Q_EMIT primaryChanged();
}

const QColor& ColorTool_p::secondary() const {
    return m_secondary;
}

void ColorTool_p::setSecondary( const QColor& newSecondary ) {
    if ( m_secondary == newSecondary ) {
        return;
    }
    m_secondary = newSecondary;
    Q_EMIT secondaryChanged();
}

void ColorTool_p::swap() {
    std::swap( m_primary, m_secondary );
    Q_EMIT primaryChanged();
    Q_EMIT secondaryChanged();
}

const QColor& ColorTool_p::currentColor() const {
    return m_currentColor;
}

void ColorTool_p::setCurrentColor( const QColor& newCurrentColor ) {
    if ( m_currentColor == newCurrentColor ) {
        return;
    }
    m_currentColor = newCurrentColor;
    Q_EMIT currentColorChanged();
}

bool ColorTool_p::swapSwatch() const {
    return m_swapSwatch;
}

void ColorTool_p::swapSwatchPlane() {
    m_swapSwatch = !m_swapSwatch;
    Q_EMIT swapSwatchChanged();
}

void ColorTool_p::reset() {
    m_primary = Qt::black;
    m_secondary = Qt::white;
    Q_EMIT primaryChanged();
    Q_EMIT secondaryChanged();
}

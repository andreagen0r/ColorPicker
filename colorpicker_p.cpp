#include "colorpicker_p.h"

#include <QGuiApplication>
#include <QScreen>
#include <QCursor>

ColorPicker_p::ColorPicker_p( QObject* parent )
    : QObject { parent }
    , m_color { Qt::white }
    , m_picking { false } { }

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

void ColorPicker_p::eyedrop() {

    const QPoint p = QCursor::pos();
    const auto pixmap = QGuiApplication::primaryScreen()->grabWindow( 0, p.x(), p.y(), 1, 1 );
    const QImage img = pixmap.toImage();
    m_color = QColor( img.pixel( 0, 0 ) );
    Q_EMIT colorChanged();
}

bool ColorPicker_p::picking() const {
    return m_picking;
}

void ColorPicker_p::setPicking( bool newPicking ) {
    if ( m_picking == newPicking ) {
        return;
    }
    m_picking = newPicking;
    Q_EMIT pickingChanged();
}

const QColor& ColorPicker_p::oldColor() const {

    return m_oldColor;
}

void ColorPicker_p::setOldColor( const QColor& newOldColor ) {
    if ( m_oldColor == newOldColor ) {
        return;
    }
    m_oldColor = newOldColor;
    qDebug() << m_oldColor;
    Q_EMIT oldColorChanged();
}

void ColorPicker_p::startPicking() {
    m_oldColor = m_color;
}

void ColorPicker_p::revertPicking() {
    setColor( m_oldColor );
}

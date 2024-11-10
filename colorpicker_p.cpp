#include "colorpicker_p.h"

#include <QGuiApplication>
#include <QScreen>
#include <QImage>
#include <QPixmap>

ColorPicker_p::ColorPicker_p( QObject* parent )
    : QObject { parent }
    , m_color { Qt::white }
    , m_oldColor { Qt::white }
    , m_picking { false } { }

void ColorPicker_p::eyedrop( const QPointF mousePosition ) {

    const auto pixmap
        = QGuiApplication::primaryScreen()->grabWindow( 0, static_cast<int>( mousePosition.x() ), static_cast<int>( mousePosition.y() ), 1, 1 );
    const QImage img { pixmap.toImage() };
    m_color = QColor( img.pixel( 0, 0 ) );
    Q_EMIT colorChanged();
}

void ColorPicker_p::startPicking() {
    m_oldColor = m_color;
    Q_EMIT colorChanged();
}

void ColorPicker_p::revertPicking() {
    m_color = m_oldColor;
    Q_EMIT colorChanged();
}

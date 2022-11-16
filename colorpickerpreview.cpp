#include "colorpickerpreview.h"

#include <QPainter>
#include <QPainterPath>
#include <QGuiApplication>
#include <QScreen>

ColorPickerPreview::ColorPickerPreview()
    : m_previewSize { 151 }
    , m_size { 5 }
    , m_mousePosition { 0, 0 } {
    setAcceptHoverEvents( true );
}

void ColorPickerPreview::paint( QPainter* painter ) {

    const auto windowSize { QGuiApplication::screens()[0]->availableSize() };

    const bool flipX { m_mousePosition.x() > ( windowSize.width() - m_previewSize ) };
    const bool flipY { m_mousePosition.y() > ( windowSize.height() - m_previewSize ) };

    const double sizeHalf = ( m_size - 1 ) / 2.0;
    const double sizePreviewHalf = ( m_previewSize - 1 ) / 2.0;

    const auto pixmap
        = QGuiApplication::primaryScreen()->grabWindow( 0, m_mousePosition.x() - sizeHalf, m_mousePosition.y() - sizeHalf, m_size, m_size );

    painter->setRenderHints( QPainter::Antialiasing, true );
    painter->setPen( QPen( QBrush( Qt::black ), 4.0, Qt::SolidLine ) );

    const QPointF coord( flipX ? m_mousePosition.x() - m_size - m_previewSize : m_mousePosition.x() + m_size,
                         flipY ? m_mousePosition.y() - m_size - m_previewSize : m_mousePosition.y() + m_size );

    QPainterPath path;
    path.addEllipse( coord.x(), coord.y(), m_previewSize, m_previewSize );
    painter->setClipPath( path );
    painter->drawPixmap( coord.x(), coord.y(), m_previewSize, m_previewSize, pixmap );
    painter->drawEllipse( coord.x(), coord.y(), m_previewSize, m_previewSize );

    // Center Point
    const auto fSize = m_previewSize / m_size;
    painter->setPen( Qt::white );
    painter->drawRect( coord.x() + sizePreviewHalf - ( fSize / 2 ), coord.y() + sizePreviewHalf - ( fSize / 2 ), fSize, fSize );
}

qreal ColorPickerPreview::previewSize() const {
    return m_previewSize;
}

void ColorPickerPreview::setPreviewSize( qreal newPreviewSize ) {
    if ( qFuzzyCompare( m_previewSize, newPreviewSize ) ) {
        return;
    }
    const auto tmp { 2 * ( ( int )( newPreviewSize / 2.0F ) ) + 1 };
    m_previewSize = tmp;
    Q_EMIT previewSizeChanged();
}

qreal ColorPickerPreview::size() const {
    return m_size;
}

void ColorPickerPreview::setSize( qreal newSize ) {
    if ( qFuzzyCompare( m_size, newSize ) ) {
        return;
    }

    // nearest odd
    const auto tmp { 2 * ( ( int )( newSize / 2.0F ) ) + 1 };
    m_size = std::clamp( tmp, 3, 15 );
    Q_EMIT sizeChanged();
}

QPointF ColorPickerPreview::mousePosition() const {
    return m_mousePosition;
}

void ColorPickerPreview::setMousePosition( QPointF newMousePosition ) {
    if ( m_mousePosition == newMousePosition ) {
        return;
    }
    m_mousePosition = newMousePosition;
    Q_EMIT mousePositionChanged();
    //    update();
}

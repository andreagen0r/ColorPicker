#include "colorpickerpreview.h"
#include <QPainter>
#include <QPainterPath>
#include <QGuiApplication>
#include <QCursor>
#include <QTimer>
#include <QScreen>

ColorPickerPreview::ColorPickerPreview()
    : m_previewSize { 151 }
    , m_size { 5 } {
    setAcceptHoverEvents( true );
}

void ColorPickerPreview::paint( QPainter* painter ) {

    const auto windowSize { QGuiApplication::screens()[0]->availableSize() };

    const QPointF position = QCursor::pos();

    const bool flipX { position.x() > ( windowSize.width() - m_previewSize ) };
    const bool flipY { position.y() > ( windowSize.height() - m_previewSize ) };

    const double sizeHalf = ( m_size - 1 ) / 2.0;
    const double sizePreviewHalf = ( m_previewSize - 1 ) / 2.0;

    const auto pixmap = QGuiApplication::primaryScreen()->grabWindow( 0, position.x() - sizeHalf, position.y() - sizeHalf, m_size, m_size );

    painter->setRenderHints( QPainter::Antialiasing, true );
    painter->setPen( QPen( QBrush( Qt::black ), 4.0, Qt::SolidLine ) );

    const QPointF coord( flipX ? position.x() - m_size - m_previewSize : position.x() + m_size,
                         flipY ? position.y() - m_size - m_previewSize : position.y() + m_size );

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

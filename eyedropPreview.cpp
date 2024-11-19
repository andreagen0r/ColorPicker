#include "eyedropPreview.h"

#include <QPainter>
#include <QPainterPath>
#include <QGuiApplication>
#include <QScreen>

EyedropPreview::EyedropPreview( QQuickItem* parent )
    : QQuickPaintedItem( parent )
    , m_previewSize { 151 }
    , m_previewMaxPixels { 5 }
    , m_mouseX { 0 }
    , m_mouseY { 0 }
    , m_showPreview { true } {

    setAcceptHoverEvents( true );

    connect( this, &EyedropPreview::mousePositionChanged, this, &EyedropPreview::eyedrop );
}

void EyedropPreview::paint( QPainter* painter ) {

    if ( !m_showPreview ) {
        return;
    }

    const auto windowSize { QGuiApplication::screens().at( 0 )->availableSize() };

    const bool flipX { m_mouseX > ( windowSize.width() - m_previewSize ) };
    const bool flipY { m_mouseY > ( windowSize.height() - m_previewSize ) };

    const double sizeHalf = ( m_previewMaxPixels - 1 ) / 2.0;
    const double sizePreviewHalf = ( m_previewSize - 1 ) / 2.0;

    const auto pixmap
        = QGuiApplication::primaryScreen()->grabWindow( 0, static_cast<int>( m_mouseX - sizeHalf ), static_cast<int>( m_mouseY - sizeHalf ),
                                                        static_cast<int>( m_previewMaxPixels ), static_cast<int>( m_previewMaxPixels ) );

    painter->setRenderHints( QPainter::Antialiasing, true );
    painter->setPen( QPen( QBrush( Qt::black ), 4.0, Qt::SolidLine ) );

    const QPointF coord( flipX ? m_mouseX - m_previewMaxPixels - m_previewSize : m_mouseX + m_previewMaxPixels,
                         flipY ? m_mouseY - m_previewMaxPixels - m_previewSize : m_mouseY + m_previewMaxPixels );

    QPainterPath path;
    path.addEllipse( coord.x(), coord.y(), m_previewSize, m_previewSize );
    painter->setClipPath( path );
    painter->drawPixmap( static_cast<int>( coord.x() ), static_cast<int>( coord.y() ), static_cast<int>( m_previewSize ),
                         static_cast<int>( m_previewSize ), pixmap );
    painter->drawEllipse( static_cast<int>( coord.x() ), static_cast<int>( coord.y() ), static_cast<int>( m_previewSize ),
                          static_cast<int>( m_previewSize ) );

    // Center Point
    const auto fSize = m_previewSize / m_previewMaxPixels;
    painter->setPen( Qt::white );
    painter->drawRect( static_cast<int>( coord.x() + sizePreviewHalf - ( fSize / 2 ) ),
                       static_cast<int>( coord.y() + sizePreviewHalf - ( fSize / 2 ) ), static_cast<int>( fSize ), static_cast<int>( fSize ) );
}

qreal EyedropPreview::previewSize() const {
    return m_previewSize;
}

void EyedropPreview::setPreviewSize( const qreal newPreviewSize ) {

    if ( qFuzzyCompare( m_previewSize, newPreviewSize ) ) {
        return;
    }
    const auto tmp { 2 * ( ( int )( newPreviewSize / 2.0F ) ) + 1 };
    m_previewSize = tmp;
    Q_EMIT previewSizeChanged();
}

void EyedropPreview::setPreviewMaxPixels( const qreal newSize ) {

    if ( qFuzzyCompare( m_previewMaxPixels, newSize ) ) {
        return;
    }
    // nearest odd
    const auto tmp { 2 * ( ( int )( newSize / 2.0F ) ) + 1 };
    m_previewMaxPixels = std::clamp( tmp, 3, 15 );
    Q_EMIT sizeChanged();
}

void EyedropPreview::startPicking() {
    Q_EMIT pickingStarted();
    m_oldColor = m_color;
}

void EyedropPreview::cancelPicking() {
    m_color = m_oldColor;
    Q_EMIT colorChanged();
    Q_EMIT pickingFinished();
}

void EyedropPreview::eyedrop() {
    const auto pixmap = QGuiApplication::primaryScreen()->grabWindow( 0, static_cast<int>( m_mouseX ), static_cast<int>( m_mouseY ), 1, 1 );
    const QImage img { pixmap.toImage() };
    m_color = QColor( img.pixel( 0, 0 ) );
    Q_EMIT colorChanged();
    update();
}

QColor EyedropPreview::color() const noexcept {
    return m_color;
}

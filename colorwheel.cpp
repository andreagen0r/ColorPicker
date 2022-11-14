#include "colorwheel.h"

#include <QDebug>
#include <QPainter>

namespace {
constexpr qreal ONETURN { 360.0 };
}

ColorWheel::ColorWheel( QQuickItem* parent )
    : QQuickPaintedItem( parent )
    , m_quadHit { UpDown::UP }
    , m_hitMode { HitPosition::IDLE }
    , m_color { Qt::red }
    , m_arrow { QPointF( 0, 0 ), QPointF( 0, 0 ), QPointF( 0, 0 ) }
    , m_outerRadius { 1 }
    , m_innerRadius { 0 }
    , m_indicatorSize { 0 } {

    setAcceptedMouseButtons( Qt::AllButtons );
    setAcceptHoverEvents( true );

    // Wheel gradient
    m_wheelGradient.setAngle( 0.0 );
    m_wheelGradient.setColorAt( 0.0, Qt::red );
    m_wheelGradient.setColorAt( 60.0 / ONETURN, Qt::yellow );
    m_wheelGradient.setColorAt( 120.0 / ONETURN, Qt::green );
    m_wheelGradient.setColorAt( 180.0 / ONETURN, Qt::cyan );
    m_wheelGradient.setColorAt( 240.0 / ONETURN, Qt::blue );
    m_wheelGradient.setColorAt( 300.0 / ONETURN, Qt::magenta );
    m_wheelGradient.setColorAt( 1.0, Qt::red );

    connect( this, &ColorWheel::colorChanged, this, [&] { update(); } );
}

void ColorWheel::paint( QPainter* painter ) {

    // *****************************
    // Wheel
    // *****************************
    QPainterPath path;
    painter->translate( width() / 2, height() / 2 );
    painter->setRenderHints( QPainter::Antialiasing, true );
    painter->setPen( Qt::NoPen );
    painter->setBrush( m_wheelGradient );
    path.addEllipse( QPointF( 0, 0 ), m_innerRadius, m_innerRadius );
    path.addEllipse( QPointF( 0, 0 ), m_outerRadius, m_outerRadius );
    painter->drawPath( path );

    // *****************************
    // Chooser
    // *****************************
    QLinearGradient colorGradientSaturation { QPointF( 0, 0 ), QPointF( 1, 0 ) };
    colorGradientSaturation.setCoordinateMode( QGradient::ObjectMode );
    colorGradientSaturation.setColorAt( 0, QColor::fromHsvF( m_color.hueF(), 0.0, 1.0, 1.0 ) );
    colorGradientSaturation.setColorAt( 1, QColor::fromHsvF( m_color.hueF(), 1.0, 1.0, 1.0 ) );

    QLinearGradient colorGradientValue { QPointF( 0, 0 ), QPointF( 0, 1 ) };
    colorGradientValue.setCoordinateMode( QGradient::ObjectMode );
    colorGradientValue.setColorAt( 0, Qt::transparent );
    colorGradientValue.setColorAt( 1, Qt::black );

    const qreal localChooserWidth { m_chooserSize.width() };
    const qreal localChooserHeight { m_chooserSize.height() };

    const QPointF translateChooser { -( localChooserWidth / 2.0 ), -( localChooserHeight / 2.0 ) };

    painter->setBrush( colorGradientSaturation );
    painter->drawRect( QRectF( translateChooser, QSizeF( localChooserWidth, localChooserHeight ) ) );

    painter->setPen( Qt::SolidLine );
    painter->setBrush( colorGradientValue );
    painter->drawRect( QRectF( translateChooser, QSizeF( localChooserWidth, localChooserHeight ) ) );

    // *****************************
    // Wheel Indicator
    // *****************************

    // Rotate Indicator
    painter->save();
    painter->rotate( -m_color.hsvHue() );

    // Draw wheel indicator
    painter->setPen( QPen( Qt::NoPen ) );
    painter->setBrush( Qt::black );
    painter->drawConvexPolygon( m_arrow );
    painter->setPen( QPen( Qt::black, 1 ) );
    painter->drawLine( QPointF( m_innerRadius + 1.0, 0 ), QPointF( m_outerRadius, 0 ) );
    painter->restore();

    // *****************************
    // Chooser Indicator
    // *****************************
    // Draw chooser indicator

    const QPointF indicatorPosition = saturationValueFromColor( m_color );

    painter->drawEllipse( indicatorPosition, m_indicatorSize, m_indicatorSize );
    painter->setBrush( m_color );
    painter->setPen( QPen( Qt::white, 1, Qt::SolidLine ) );
    painter->drawEllipse( indicatorPosition, m_indicatorSize - 1.0, m_indicatorSize - 1.0 );
}

const QColor& ColorWheel::color() const {
    return m_color;
}

void ColorWheel::setColor( const QColor& newColor ) {
    if ( m_color == newColor ) {
        return;
    }

    m_color = newColor;
    Q_EMIT colorChanged();
}

void ColorWheel::setHue( qreal value ) {
    setColor( QColor::fromHsvF( static_cast<float>( value ), m_color.saturationF(), m_color.valueF(), m_color.alphaF() ) );
}

// *****************************
// PRIVATE
// *****************************

bool ColorWheel::isHitMode() noexcept {

    if ( static_cast<qreal>( m_mouseVec.length() ) > m_innerRadius && static_cast<qreal>( m_mouseVec.length() ) < m_outerRadius ) {

        m_hitMode = HitPosition::WHEEL;

        return true;
    }

    if ( m_chooserSize.contains( static_cast<qreal>( m_mouseVec.x() ), static_cast<qreal>( m_mouseVec.y() ) ) ) {

        m_hitMode = HitPosition::CHOOSER;

        return true;
    }

    return false;
}

QColor ColorWheel::hueAt( const QVector2D in_mouseVec ) noexcept {

    const QVector2D vec { 1.0, 0.0 };
    qreal angle = qRadiansToDegrees( std::acos( QVector2D::dotProduct( vec, in_mouseVec ) / ( in_mouseVec.length() * vec.length() ) ) );

    m_quadHit
        = getQuadrant( QPoint( static_cast<int>( mapFromGlobal( QCursor::pos() ).x() ), static_cast<int>( mapFromGlobal( QCursor::pos() ).y() ) ) );

    if ( m_quadHit == UpDown::DOWN ) {
        angle = ONETURN - angle;
    }

    return QColor::fromHsvF( static_cast<float>( angle / ONETURN ), m_color.hsvSaturationF(), m_color.valueF(), m_color.alphaF() );
}

QColor ColorWheel::saturationValuePositionLimit( const QVector2D position ) noexcept {

    qreal x { static_cast<qreal>( position.x() ) };
    qreal y { static_cast<qreal>( -position.y() ) };

    if ( m_hitMode == HitPosition::CHOOSER ) {
        x = std::clamp( x, m_chooserSize.left(), m_chooserSize.right() );
        y = std::clamp( y, m_chooserSize.top(), m_chooserSize.bottom() );
    }

    const float m_sat = static_cast<float>( x / m_chooserSize.width() ) + 0.5F;
    const float m_val = static_cast<float>( y / m_chooserSize.height() ) + 0.5F;

    return QColor::fromHsvF( m_color.hsvHueF(), m_sat, m_val, m_color.alphaF() );
}

QPointF ColorWheel::saturationValueFromColor( const QColor& color ) noexcept {
    return { static_cast<float>( m_chooserSize.width() * ( color.saturationF() - 0.5F ) ),
             static_cast<float>( -m_chooserSize.height() * ( color.valueF() - 0.5F ) ) };
}

ColorWheel::UpDown ColorWheel::getQuadrant( const QPoint position ) noexcept {
    return ( position.y() <= static_cast<int>( height() / 2 ) ) ? UpDown::UP : UpDown::DOWN;
}

void ColorWheel::updateMousePosition( const QPoint position ) {
    m_mouseVec = QVector2D( static_cast<float>( position.x() - width() / 2.0F ), static_cast<float>( position.y() - height() / 2.0F ) );
}

// *****************************
// PROTECTED
// *****************************

void ColorWheel::mousePressEvent( QMouseEvent* event ) {

    if ( event->buttons() != Qt::LeftButton ) {
        return;
    }

    updateMousePosition( event->pos() );

    if ( !isHitMode() ) {
        return;
    }

    switch ( m_hitMode ) {
        case HitPosition::WHEEL:
            setColor( hueAt( m_mouseVec ) );
            setCursor( Qt::ClosedHandCursor );
            break;
        case HitPosition::CHOOSER:
            setColor( saturationValuePositionLimit( m_mouseVec ) );
            setCursor( Qt::BlankCursor );
            break;
        default:
            break;
    }
}

void ColorWheel::mouseMoveEvent( QMouseEvent* event ) {

    if ( event->buttons() != Qt::LeftButton ) {
        return;
    }

    if ( m_hitMode == HitPosition::IDLE ) {
        return;
    }

    updateMousePosition( event->pos() );

    switch ( m_hitMode ) {
        case HitPosition::WHEEL:
            setColor( hueAt( m_mouseVec ) );
            break;

        case HitPosition::CHOOSER:
            setColor( saturationValuePositionLimit( m_mouseVec ) );
            break;

        default:
            break;
    }
}

void ColorWheel::mouseReleaseEvent( QMouseEvent* /*event*/ ) {

    if ( m_hitMode != HitPosition::IDLE ) {
        Q_EMIT editFinished();
    }

    m_hitMode = HitPosition::IDLE;
    setCursor( Qt::ArrowCursor );
}

void ColorWheel::geometryChange( const QRectF& newGeometry, const QRectF& /*oldGeometry*/ ) {

    const qreal side = std::fmin( newGeometry.width(), newGeometry.height() ) / 2;
    m_outerRadius = side - 1.0;
    m_innerRadius = side - ( side * 0.25 );

    // Make the arrow points relative to widget size
    constexpr float scaleFactor { 0.01F };
    m_arrow[0] = QPointF( m_innerRadius, 3 * ( side * scaleFactor ) );
    m_arrow[1] = QPointF( m_innerRadius + 6 * ( side * scaleFactor ), 0 );
    m_arrow[2] = QPointF( m_innerRadius, -3 * ( side * scaleFactor ) );

    // Calculate chooser indicator size
    m_indicatorSize = m_innerRadius * 0.04;
    if ( m_indicatorSize < 1.0 ) {
        m_indicatorSize = 1.0;
    }

    // Calculate the size for chooser
    const double diagonal = std::cos( qDegreesToRadians( 45.0 ) ) * m_innerRadius;
    const double gap = ( diagonal * 0.05 );

    const double diagonalMin = -diagonal + gap;
    const double diagonalMax = diagonal - gap;

    // Setup the rect size for color sampler
    m_chooserSize.setTopLeft( QPointF( diagonalMin, diagonalMin ) );
    m_chooserSize.setBottomRight( QPointF( diagonalMax, diagonalMax ) );
}

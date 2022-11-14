#pragma once

#include <QtQuick>

class ColorWheel : public QQuickPaintedItem {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor color READ color WRITE setColor NOTIFY colorChanged FINAL )

public:
    explicit ColorWheel( QQuickItem* parent = nullptr );

    void paint( QPainter* painter ) override;

    [[nodiscard]] const QColor& color() const;
    void setColor( const QColor& newColor );

    Q_INVOKABLE void setHue( qreal value );

Q_SIGNALS:
    void colorChanged();
    void editFinished();

private:
    enum class HitPosition { IDLE, WHEEL, CHOOSER };
    enum class UpDown { UP, DOWN };

    UpDown m_quadHit;
    HitPosition m_hitMode;

    QColor m_color;
    QConicalGradient m_wheelGradient;

    QRectF m_chooserSize;
    QPolygonF m_arrow;

    QVector2D m_mouseVec;
    qreal m_outerRadius;
    qreal m_innerRadius;
    qreal m_indicatorSize;

    [[nodiscard]] bool isHitMode() noexcept;
    [[nodiscard]] QColor hueAt( QVector2D in_mouseVec ) noexcept;
    [[nodiscard]] QColor saturationValuePositionLimit( QVector2D position ) noexcept;
    [[nodiscard]] QPointF saturationValueFromColor( const QColor& color ) noexcept;
    [[nodiscard]] UpDown getQuadrant( QPoint position ) noexcept;

    void updateMousePosition( QPoint position );

protected:
    void mousePressEvent( QMouseEvent* event ) override;
    void mouseMoveEvent( QMouseEvent* event ) override;
    void mouseReleaseEvent( QMouseEvent* event ) override;
    void geometryChange( const QRectF& newGeometry, const QRectF& oldGeometry ) override;
};

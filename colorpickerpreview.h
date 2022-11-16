#pragma once

#include <QQuickPaintedItem>
#include <QQmlEngine>
#include <QPointF>

class ColorPickerPreview : public QQuickPaintedItem {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( qreal previewSize READ previewSize WRITE setPreviewSize NOTIFY previewSizeChanged )
    Q_PROPERTY( qreal size READ size WRITE setSize NOTIFY sizeChanged )
    Q_PROPERTY( QPointF mousePosition READ mousePosition WRITE setMousePosition NOTIFY mousePositionChanged )

public:
    ColorPickerPreview();

    void paint( QPainter* painter ) override;
    [[nodiscard]] qreal previewSize() const;
    void setPreviewSize( qreal newPreviewSize );
    [[nodiscard]] qreal size() const;
    void setSize( qreal newSize );

    [[nodiscard]] QPointF mousePosition() const;
    Q_INVOKABLE void setMousePosition( QPointF newMousePosition );

signals:
    void previewSizeChanged();
    void sizeChanged();
    void mousePositionChanged();

private:
    qreal m_previewSize;
    qreal m_size;
    QPointF m_mousePosition;
};

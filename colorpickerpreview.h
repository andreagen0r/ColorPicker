#pragma once

#include <QQuickPaintedItem>
#include <QQmlEngine>

class Timer;

class ColorPickerPreview : public QQuickPaintedItem {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( qreal previewSize READ previewSize WRITE setPreviewSize NOTIFY previewSizeChanged )
    Q_PROPERTY( qreal size READ size WRITE setSize NOTIFY sizeChanged )

public:
    ColorPickerPreview();

    void paint( QPainter* painter ) override;
    qreal previewSize() const;
    void setPreviewSize( qreal newPreviewSize );
    qreal size() const;
    void setSize( qreal newSize );

signals:
    void previewSizeChanged();

    void sizeChanged();

private:
    qreal m_previewSize;
    qreal m_size;
};

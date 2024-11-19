#pragma once

#include <QQuickPaintedItem>
#include <QQmlEngine>

class EyedropPreview : public QQuickPaintedItem {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor color READ color NOTIFY colorChanged FINAL )
    Q_PROPERTY( qreal previewSize READ previewSize WRITE setPreviewSize NOTIFY previewSizeChanged )
    Q_PROPERTY( qreal previewMaxPixels MEMBER m_previewMaxPixels WRITE setPreviewMaxPixels NOTIFY sizeChanged )
    Q_PROPERTY( qreal mouseX MEMBER m_mouseX NOTIFY mousePositionChanged FINAL REQUIRED )
    Q_PROPERTY( qreal mouseY MEMBER m_mouseY NOTIFY mousePositionChanged FINAL REQUIRED )
    Q_PROPERTY( bool showPreview MEMBER m_showPreview NOTIFY showPreviewChanged FINAL )

public:
    explicit EyedropPreview( QQuickItem* parent = nullptr );

    void paint( QPainter* painter ) override;

    [[nodiscard]] QColor color() const noexcept;

    [[nodiscard]] qreal previewSize() const;
    void setPreviewSize( qreal newPreviewSize );

    void setPreviewMaxPixels( qreal newSize );

    Q_INVOKABLE void startPicking();
    Q_INVOKABLE void cancelPicking();

Q_SIGNALS:
    void colorChanged();
    void previewSizeChanged();
    void sizeChanged();
    void mousePositionChanged();
    void showPreviewChanged();
    void pickingStarted();
    void pickingFinished();

private:
    QColor m_color;
    QColor m_oldColor;
    qreal m_previewSize;
    qreal m_previewMaxPixels;
    qreal m_mouseX;
    qreal m_mouseY;
    bool m_showPreview;

    void eyedrop();
};

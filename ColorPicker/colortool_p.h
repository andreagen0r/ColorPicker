#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>

class ColorTool_p : public QObject {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor primary READ primary WRITE setPrimary NOTIFY primaryChanged FINAL )
    Q_PROPERTY( QColor secondary READ secondary WRITE setSecondary NOTIFY secondaryChanged FINAL )
    Q_PROPERTY( QColor currentColor READ currentColor WRITE setCurrentColor NOTIFY currentColorChanged FINAL )
    Q_PROPERTY( bool swapSwatch READ swapSwatch NOTIFY swapSwatchChanged FINAL )

public:
    explicit ColorTool_p( QObject* parent = nullptr );

    [[nodiscard]] const QColor& primary() const;
    Q_INVOKABLE void setPrimary( const QColor& newPrimary );

    [[nodiscard]] const QColor& secondary() const;
    Q_INVOKABLE void setSecondary( const QColor& newSecondary );

    Q_INVOKABLE void swap();

    [[nodiscard]] const QColor& currentColor() const;
    Q_INVOKABLE void setCurrentColor( const QColor& newCurrentColor );

    [[nodiscard]] bool swapSwatch() const;
    Q_INVOKABLE void swapSwatchPlane();

    Q_INVOKABLE void reset();

Q_SIGNALS:
    void primaryChanged();
    void secondaryChanged();
    void currentColorChanged();
    void swapSwatchChanged();

private:
    QColor m_primary;
    QColor m_secondary;
    QColor m_currentColor;
    bool m_swapSwatch;
};

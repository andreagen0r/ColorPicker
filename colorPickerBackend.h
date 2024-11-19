#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QColor>

class ColorPickerBackend : public QObject {

    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY( QColor currentColor MEMBER m_color NOTIFY colorChanged FINAL REQUIRED )
public:
    explicit ColorPickerBackend( QObject* parent = nullptr );

Q_SIGNALS:
    void colorChanged();

private:
    QColor m_color;
};

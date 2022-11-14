#pragma once

#include <QDoubleValidator>
#include <QQmlEngine>

class TextFieldDoubleValidator : public QDoubleValidator {

    Q_OBJECT
    QML_ELEMENT

public:
    TextFieldDoubleValidator( QObject* parent = nullptr );

    QValidator::State validate( QString& s, int& pos ) const override;
    void fixup( QString& input ) const override;
};

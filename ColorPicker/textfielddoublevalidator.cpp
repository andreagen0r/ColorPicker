#include "textfielddoublevalidator.h"

TextFieldDoubleValidator::TextFieldDoubleValidator( QObject* parent )
    : QDoubleValidator( parent ) { }

QValidator::State TextFieldDoubleValidator::validate( QString& s, int& /*pos*/ ) const {

    if ( s.isEmpty() || ( s.startsWith( u"-"_qs ) && s.length() == 1 ) ) {
        return QValidator::Intermediate;
    }

    QChar point = locale().decimalPoint().back();
    if ( s.indexOf( point ) != -1 ) {
        const auto lengthDecimals = s.length() - s.indexOf( point ) - 1;
        if ( lengthDecimals > decimals() ) {
            return QValidator::Invalid;
        }
    }

    bool ok = false;
    const double value = s.toDouble( &ok );

    if ( ok && bottom() <= value && value <= top() ) {
        return QValidator::Acceptable;
    }

    return QValidator::Invalid;
}

void TextFieldDoubleValidator::fixup( QString& input ) const {
    bool ok { false };
    double tmp = input.toDouble( &ok );

    if ( ok ) {
        tmp = std::clamp( tmp, bottom(), top() );
    }

    input = QString::number( tmp, 'g', 3 );
}

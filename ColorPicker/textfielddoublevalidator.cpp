#include "textfielddoublevalidator.h"

using namespace Qt::StringLiterals;

TextFieldDoubleValidator::TextFieldDoubleValidator( QObject* parent )
    : QDoubleValidator( parent ) { }

QValidator::State TextFieldDoubleValidator::validate( QString& strValue, int& /*pos*/ ) const {

    if ( strValue.isEmpty() || ( strValue.startsWith( "-"_L1 ) && strValue.length() == 1 ) ) {
        return QValidator::Intermediate;
    }

    const QChar point = locale().decimalPoint().back();

    if ( strValue.indexOf( point ) != -1 ) {
        const auto lengthDecimals = strValue.length() - strValue.indexOf( point ) - 1;
        if ( lengthDecimals > decimals() ) {
            return QValidator::Invalid;
        }
    }

    bool ok = false;
    const double value = strValue.toDouble( &ok );

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

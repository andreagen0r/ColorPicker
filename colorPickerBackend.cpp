#include "colorPickerBackend.h"

ColorPickerBackend::ColorPickerBackend( QObject* parent )
    : QObject { parent }
    , m_color { Qt::white } { }

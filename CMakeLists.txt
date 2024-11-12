qt_add_qml_module(ColorPicker
    URI Origin.ColorPicker
    STATIC
    VERSION 1.0
    IMPORTS
        QtQuick.Controls.Basic
    QML_FILES
        ColorPickerDialog.qml
        ColorSampler.qml
        ColorHistory.qml
        ColorSlider.qml
        RGBSlider.qml
        HSVSlider.qml
    SOURCES
        colorpicker_p.h colorpicker_p.cpp
        colorwheel.h colorwheel.cpp
        colorslider_p.h colorslider_p.cpp
        colorhistorymodel.h colorhistorymodel.cpp
        colorpickerpreview.h colorpickerpreview.cpp
        textfielddoublevalidator.h textfielddoublevalidator.cpp
    RESOURCES
        assets/eyedropper.svg
        assets/alphaBackground.png
)

set_target_properties(ColorPicker PROPERTIES AUTOMOC ON)
target_link_libraries(ColorPicker
    PRIVATE
    Qt6::Quick
    Origin
)

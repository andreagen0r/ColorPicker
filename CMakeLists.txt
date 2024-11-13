qt_standard_project_setup(REQUIRES 6.8)

qt_add_library(ColorPickerModule STATIC)

qt_add_qml_module(ColorPickerModule
    URI ColorPicker
    VERSION 1.0
    RESOURCE_PREFIX /pigment/qml
    DEPENDENCIES
        Origin.Controls
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

set_target_properties(ColorPickerModule PROPERTIES AUTOMOC ON)
target_link_libraries(ColorPickerModule
    PRIVATE
    Qt6::Quick
    Origin
)

cmake_minimum_required(VERSION 3.16)

project(ColorPickerDialog
    VERSION 0.2
    DESCRIPTION "Color Wheel"
    LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick )

qt6_policy(
    SET QTP0001 NEW
)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_qml_module(ColorPicker
    URI ColorPicker
    VERSION 1.0
    IMPORTS
        QtQuick.Controls.Basic
    QML_FILES
        # ColorTool.qml
        # Eyedroper.qml
        ColorPickerDialog.qml
        ColorSampler.qml
        ColorHistory.qml
        ColorSlider.qml
        RGBSlider.qml
        HSVSlider.qml
    SOURCES
        colorpicker_p.h colorpicker_p.cpp

        colorwheel.h colorwheel.cpp
        # colorsampler_p.h colorsampler_p.cpp
        # colortool_p.h colortool_p.cpp
        colorslider_p.h colorslider_p.cpp
        colorhistorymodel.h colorhistorymodel.cpp
        colorpickerpreview.h colorpickerpreview.cpp
        textfielddoublevalidator.h textfielddoublevalidator.cpp
    RESOURCES
        assets/swap.svg
        assets/eyedropper.svg
        assets/alphaBackground.png
)

target_link_libraries(ColorPicker
    PRIVATE
    Qt6::Quick
    Origin
)

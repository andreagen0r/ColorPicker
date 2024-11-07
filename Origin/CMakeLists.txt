cmake_minimum_required(VERSION 3.16)

project(OriginStyle
    VERSION 1.0.0
    DESCRIPTION "Origin Qml Style"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick )

qt6_policy(
    SET QTP0001 NEW
)

qt_standard_project_setup(REQUIRES 6.8)

set_source_files_properties(OriginTheme.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)
set_source_files_properties(Fonts.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(Origin
    URI "Origin"
    VERSION 1.0
    IMPORTS
     QtQuick.Controls.Material
    RESOURCES
        Icons/check-mark.svg
        Icons/caret-right.svg
        Icons/caret-down.svg
        Icons/times-circle.svg
    QML_FILES
        OriginTheme.qml # Singleton
        ApplicationWindow.qml
        BoxShadow.qml
        BusyIndicator.qml
        Button.qml
        CheckBox.qml
        CheckDelegate.qml
        ComboBox.qml
        DelayButton.qml
        DialogButtonBox.qml
        Dialog.qml
        Dial.qml
        Drawer.qml
        ElevationEffect.qml
        Frame.qml
        GroupBox.qml
        HorizontalHeaderView.qml
        ItemDelegate.qml
        Label.qml
        MenuBarItem.qml
        MenuBar.qml
        MenuItem.qml
        Menu.qml
        MenuSeparator.qml
        PageIndicator.qml
        Page.qml
        Pane.qml
        Popup.qml
        ProgressBar.qml
        RadioButton.qml
        RadioDelegate.qml
        RangeSlider.qml
        RectangularGlow.qml
        RoundButton.qml
        ScrollBar.qml
        ScrollIndicator.qml
        SliderHandle.qml
        Slider.qml
        SpinBox.qml
        SplitView.qml
        StackView.qml
        SwipeDelegate.qml
        SwipeView.qml
        SwitchDelegate.qml
        Switch.qml
        TabBar.qml
        TabButton.qml
        TextArea.qml
        TextField.qml
        ToolBar.qml
        ToolButton.qml
        ToolSeparator.qml
        ToolTip.qml
        Tumbler.qml
        TreeViewDelegate.qml
        VerticalHeaderView.qml
        CheckIndicator.qml
        CursorDelegate.qml
        RadioIndicator.qml
        SwitchIndicator.qml
    SOURCES
        OriginStatics.cpp
)

qt_add_resources(Origin "origin_resources"
    PREFIX
        /qt-project.org/imports/QtQuick/Dialogs/quickimpl/qml
    FILES
        +Origin/ColorDialog.qml
        +Origin/FileDialog.qml
        +Origin/FileDialogDelegate.qml
        +Origin/FolderBreadcrumbBar.qml
        +Origin/FolderDialog.qml
        +Origin/FolderDialogDelegate.qml
        +Origin/FontDialog.qml
        +Origin/MessageDialog.qml
        +Origin/ColorInputs.qml
        +Origin/FileDialogDelegateLabel.qml
        +Origin/FolderDialogDelegateLabel.qml
        +Origin/FontDialogContent.qml
        +Origin/HueGradient.qml
        +Origin/PickerHandle.qml
        +Origin/SaturationLightnessPicker.qml
)

target_link_libraries(Origin
    PRIVATE
    Qt6::Quick
)

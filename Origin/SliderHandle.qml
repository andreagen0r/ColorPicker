import QtQuick
import QtQuick.Controls.Material.impl

import Origin

Item {
    id: root
    implicitWidth: initialSize
    implicitHeight: initialSize

    property real value: 0
    property bool handleHasFocus: false
    property bool handlePressed: false
    property bool handleHovered: false
    readonly property int initialSize: 13
    readonly property var control: parent

    Rectangle {
        id: handleRect
        width: parent.width
        height: parent.height
        radius: width / 2
        scale: root.handlePressed ? 1.5 : 1
        color: !root.control.enabled ? OriginTheme.foregroundDisable
                                     : root.handlePressed ? OriginTheme.accent : OriginTheme.foreground

        Behavior on scale {
            NumberAnimation {
                duration: OriginTheme.speedFast
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: OriginTheme.speedFast
                easing.type: Easing.OutCubic
            }
        }
    }

    Ripple {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 22; height: 22
        pressed: root.handlePressed
        active: control.enabled && (root.handlePressed || root.handleHasFocus || root.handleHovered)
        color: control.checked ? OriginTheme.makeTransparent(OriginTheme.accent, 0.2) : OriginTheme.makeTransparent(OriginTheme.accent, 0.1)
    }
}

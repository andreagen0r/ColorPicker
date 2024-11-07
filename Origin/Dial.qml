import QtQuick
import QtQuick.Templates as T

import Origin

T.Dial {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding) || 100 // ### remove 100 in Qt 6
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding) || 100 // ### remove 100 in Qt 6

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 100

        x: control.width / 2 - width / 2
        y: control.height / 2 - height / 2
        width: Math.max(64, Math.min(control.width, control.height))
        height: width
        color: control.pressed ? OriginTheme.makeTransparent(OriginTheme.accent, 0.1) :"transparent"
        radius: width / 2

        border.color: control.enabled ? OriginTheme.accent : OriginTheme.foregroundDisable

        Behavior on color {
            ColorAnimation {
                duration: OriginTheme.speedFast
                easing.type: Easing.OutCubic
            }
        }
    }

    handle: SliderHandle {
        x: control.background.x + control.background.width / 2 - control.handle.width / 2
        y: control.background.y + control.background.height / 2 - control.handle.height / 2
        transform: [
            Translate {
                y: -control.background.height * 0.4 + control.handle.height / 2
            },
            Rotation {
                angle: control.angle
                origin.x: control.handle.width / 2
                origin.y: control.handle.height / 2
            }
        ]

        implicitWidth: 10
        implicitHeight: 10

        value: control.value
        handleHasFocus: control.visualFocus
        handlePressed: control.pressed
        handleHovered: control.hovered
    }
}

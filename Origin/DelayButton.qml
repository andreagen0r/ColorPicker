import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import Origin

T.DelayButton {
    id: id_control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topInset: OriginTheme.spacingSmall
    bottomInset: OriginTheme.spacingSmall
    padding: OriginTheme.spacingSmall + 1
    horizontalPadding: OriginTheme.spacingMedium
    spacing: OriginTheme.spacingSmall

    font {
      pointSize: 10
      letterSpacing: 1.2
    }

    transition: Transition {
        NumberAnimation {
            duration: id_control.delay * (id_control.pressed ? 1.0 - id_control.progress : 0.3 * id_control.progress)
        }
    }

    contentItem: IconLabel {
        spacing: id_control.spacing
        mirrored: id_control.mirrored
        display: id_control.display
        icon: id_control.icon
        text: id_control.text
        font: id_control.font
        color:  OriginTheme.foreground
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: OriginTheme.buttonHeight
        radius: OriginTheme.radiusSmall
        color: id_control.checked ? OriginTheme.buttonChecked : OriginTheme.button

        scale: pressed ? 0.95 : 1
        Behavior on scale { NumberAnimation{ duration: OriginTheme.speedSuperFast } }

        layer.enabled: id_control.enabled && !id_control.checked && !id_control.flat
        layer.effect: ElevationEffect {
            elevation: id_control.down ? 8 : 2
        }

        Ripple {
            clip: true
            clipRadius: parent.radius
            Material.theme: Material.Dark
            Material.accent: OriginTheme.accent

            width: parent.width
            height: parent.height
            pressed: id_control.pressed
            anchor: id_control
            active: ( id_control.down || id_control.visualFocus || ( id_control.hovered && id_control.enabled ) ) && !id_control.checkable
            color: id_control.flat && id_control.highlighted ? Material.highlightedRippleColor : Material.rippleColor
        }

        PaddedRectangle {
            y: parent.height - 2
            width: parent.width
            height: 2
            topPadding: -2
            clip: true
            color: id_control.checked && id_control.enabled ? OriginTheme.accent : OriginTheme.foregroundDisable

            PaddedRectangle {
                width: parent.width * id_control.progress
                height: 2
                topPadding: -2
                rightPadding: Math.max(-2, width - parent.width)
                clip: true
                color: OriginTheme.accent
            }
        }
    }
}

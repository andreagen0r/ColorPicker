pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T

import Origin

T.Pane {
    id: idControl

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: OriginTheme.spacingMedium

    background: Rectangle {
        color: OriginTheme.surface
        radius: 0

        layer.enabled: false
        layer.effect: ElevationEffect {
            elevation: idControl.elevation
        }
    }
}

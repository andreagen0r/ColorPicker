pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T

import Origin

T.Popup {
  id: control

  property double elevation: OriginTheme.elevation
  property alias radius: bg.radius
  property color modalOverlayColor: OriginTheme.makeTransparent(OriginTheme.surfaceBackground, 0.5)
  property color modelessOverlayColor: OriginTheme.makeTransparent(OriginTheme.surfaceBackground, 0.5)

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  padding: OriginTheme.spacingLarge


  enter: Transition {
    // grow_fade_in
    NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
  }

  exit: Transition {
    // shrink_fade_out
    NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
  }

  background: Rectangle {
    id: bg
    implicitWidth: 200
    implicitHeight: 200

    radius: OriginTheme.radiusMedium
    color: OriginTheme.surface

    layer.enabled: control.elevation > 0
    layer.effect: ElevationEffect {
      elevation: control.elevation
    }
  }

  T.Overlay.modal: Rectangle {
    color: OriginTheme.backgroundOverlay
    Behavior on opacity { NumberAnimation { duration: 150 } }
  }

  T.Overlay.modeless: Rectangle {
    color: OriginTheme.backgroundOverlay
    Behavior on opacity { NumberAnimation { duration: 150 } }
  }
}

import QtQuick
import QtQuick.Controls.Material.impl

import Origin

Item {
  id: indicator
  implicitWidth: 58
  implicitHeight: 36

  required property Item control
  property alias handle: handle

  Rectangle {
    width: parent.width
    height: 30
    radius: height / 2
    y: parent.height / 2 - height / 2
    color: !indicator.control.enabled ? OriginTheme.foregroundDisable
                                      : indicator.control.checked ? OriginTheme.accent : OriginTheme.surfaceBackground

  }

  Rectangle {
    id: handle
    x: Math.max(3, Math.min(parent.width - (width + 3), indicator.control.visualPosition * parent.width - (width / 2)))
    y: (parent.height - height) / 2
    width: 24
    height: 24
    radius: width / 2
    color: OriginTheme.surface
    scale: indicator.control.pressed ? 0.9 : 1

    Behavior on scale { SmoothedAnimation { duration: 300 } }
    Behavior on x { SmoothedAnimation { duration: 300 } }

    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: 1
    }
  }
}

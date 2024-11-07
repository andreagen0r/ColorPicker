import QtQuick

import Origin

Rectangle {
  id: indicator
  implicitWidth: 20
  implicitHeight: 20
  radius: width / 2
  border.width: 1
  border.color: !control.enabled ? OriginTheme.foregroundDisable
                                 : control.checked || control.down ? OriginTheme.accent : hovered ? OriginTheme.accent : OriginTheme.foregroundPlaceHolder
  color: "transparent"

  scale: indicator.control.pressed ? 0.9 : 1
  Behavior on scale { NumberAnimation { duration: 100 } }

  property Item control

  Rectangle {
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 10
    height: 10
    radius: width / 2
    color: parent.border.color
    visible: indicator.control.checked || indicator.control.down
  }
}

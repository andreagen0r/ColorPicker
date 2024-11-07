import QtQuick
import QtQuick.Templates as T

import Origin

T.ScrollBar {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  padding: control.interactive ? 1 : 2
  visible: control.policy !== T.ScrollBar.AlwaysOff
  minimumSize: orientation == Qt.Horizontal ? height / width : width / height

  contentItem: Rectangle {
    implicitWidth: control.interactive ? 8 : 4
    implicitHeight: control.interactive ? 8 : 4

    color: control.pressed ? OriginTheme.foreground :
                             control.interactive && control.hovered ? OriginTheme.foreground : OriginTheme.foreground
    opacity: 0.0
    radius: implicitWidth / 2
  }

  background: Rectangle {
    implicitWidth: control.interactive ? 8 : 4
    implicitHeight: control.interactive ? 8 : 4
    color: OriginTheme.surfaceBackground
    opacity: 0.0
    visible: control.interactive
    radius: implicitWidth / 2
  }

  states: State {
    name: "active"
    when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
  }

  transitions: [
    Transition {
      to: "active"
      NumberAnimation { targets: [control.contentItem, control.background]; property: "opacity"; to: 1.0 }
    },
    Transition {
      from: "active"
      SequentialAnimation {
        PropertyAction{ targets: [control.contentItem, control.background]; property: "opacity"; value: 1.0 }
        PauseAnimation { duration: 2450 }
        NumberAnimation { targets: [control.contentItem, control.background]; property: "opacity"; to: 0.0 }
      }
    }
  ]
}

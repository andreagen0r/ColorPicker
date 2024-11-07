import QtQuick
import QtQuick.Templates as T

import Origin

T.ScrollIndicator {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  padding: 2

  contentItem: Rectangle {
    implicitWidth: 4
    implicitHeight: 4

    color: OriginTheme.accent
    visible: control.size < 1.0
    opacity: 0.0

    states: State {
      name: "active"
      when: control.active
      PropertyChanges { target: control.contentItem; opacity: 0.75 }
    }

    transitions: [
      Transition {
        from: "active"
        SequentialAnimation {
          PauseAnimation { duration: 450 }
          NumberAnimation { target: control.contentItem; duration: 200; property: "opacity"; to: 0.0 }
        }
      }
    ]
  }
}

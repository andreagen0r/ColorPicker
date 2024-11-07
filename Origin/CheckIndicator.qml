import QtQuick
import QtQuick.Controls.impl

import Origin

Rectangle {
  id: indicatorItem
  implicitWidth: 18
  implicitHeight: 18
  color: !control.enabled ? "transparent" : checkState !== Qt.Unchecked ? OriginTheme.accent : "transparent"
  border.color: !control.enabled ? OriginTheme.foregroundDisable
                                 : checkState !== Qt.Unchecked ? OriginTheme.accent : hovered ? OriginTheme.accent : OriginTheme.foregroundPlaceHolder
  border.width: 1
  radius: OriginTheme.radiusSmall

  property Item control
  property int checkState: control.checkState

  Behavior on border.width {
    NumberAnimation {
      duration: 100
      easing.type: Easing.OutCubic
    }
  }

  Behavior on border.color {
    ColorAnimation {
      duration: 100
      easing.type: Easing.OutCubic
    }
  }

  IconLabel {
    id: checkImage
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 14
    height: 14
    icon.source: "qrc:/qt/qml/Origin/Icons/check-mark.svg"
    icon.color: control.enabled ? OriginTheme.foregroundInvertedContrasted : OriginTheme.foregroundDisable

    scale: indicatorItem.checkState === Qt.Checked ? 1 : 0
    Behavior on scale { NumberAnimation { duration: 100 } }
  }

  Rectangle {
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 12
    height: 3
    color: OriginTheme.foregroundInvertedContrasted

    scale: indicatorItem.checkState === Qt.PartiallyChecked ? 1 : 0
    Behavior on scale { NumberAnimation { duration: 100 } }
  }

  states: [
    State {
      name: "checked"
      when: indicatorItem.checkState === Qt.Checked
    },
    State {
      name: "partiallychecked"
      when: indicatorItem.checkState === Qt.PartiallyChecked
    }
  ]

  transitions: Transition {
    SequentialAnimation {
      NumberAnimation {
        target: indicatorItem
        property: "scale"
        // Go down 2 pixels in size.
        to: 1 - 2 / indicatorItem.width
        duration: 120
      }
      NumberAnimation {
        target: indicatorItem
        property: "scale"
        to: 1
        duration: 120
      }
    }
  }
}

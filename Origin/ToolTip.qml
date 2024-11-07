import QtQuick
import QtQuick.Templates as T

import Origin

T.ToolTip {
  id: control

  x: parent ? (parent.width - implicitWidth) / 2 : 0
  y: -implicitHeight - 24

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  margins: OriginTheme.spacingMedium
  padding: OriginTheme.spacingMedium
  horizontalPadding: OriginTheme.spacingLarge

  closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent

  enter: Transition {
    // toast_enter
    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutQuad; duration: 500 }
  }

  exit: Transition {
    // toast_exit
    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.InQuad; duration: 500 }
  }

  contentItem: Text {
    text: control.text
    font: control.font
    wrapMode: Text.Wrap
    color: OriginTheme.foreground
  }

  background: Rectangle {
    implicitHeight: OriginTheme.buttonHeight
    color: OriginTheme.background
    opacity: 0.9
    radius: OriginTheme.radiusSmall
  }
}

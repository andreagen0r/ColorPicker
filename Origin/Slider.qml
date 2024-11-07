import QtQuick
import QtQuick.Templates as T

import Origin

T.Slider {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitHandleWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitHandleHeight + topPadding + bottomPadding)

  padding: OriginTheme.spacingSmall

  handle: SliderHandle {
    x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
    y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
    value: control.value
    handleHasFocus: control.visualFocus
    handlePressed: control.pressed
    handleHovered: control.hovered
  }

  background: Rectangle {
    x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
    y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
    implicitWidth: control.horizontal ? 200 : 48
    implicitHeight: control.horizontal ? 48 : 200
    width: control.horizontal ? control.availableWidth : 1
    height: control.horizontal ? 1 : control.availableHeight
    color: OriginTheme.background
    scale: control.horizontal && control.mirrored ? -1 : 1

    Rectangle {
      x: control.horizontal ? 0 : (parent.width - width) / 2
      y: control.horizontal ? (parent.height - height) / 2 : control.visualPosition * parent.height
      width: control.horizontal ? control.position * parent.width : 1
      height: control.horizontal ? 1 : control.position * parent.height

      color: control.enabled ? OriginTheme.accent : OriginTheme.foregroundDisable
    }
  }
}

import QtQuick
import QtQuick.Templates as T

import Origin

// TODO: Conferir

T.RangeSlider {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          first.implicitHandleWidth + leftPadding + rightPadding,
                          second.implicitHandleWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           first.implicitHandleHeight + topPadding + bottomPadding,
                           second.implicitHandleHeight + topPadding + bottomPadding)

  padding: OriginTheme.spacingSmall

  first.handle: SliderHandle {
    x: control.leftPadding + (control.horizontal ? control.first.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
    y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.first.visualPosition * (control.availableHeight - height))
    value: first.value
    handleHasFocus: activeFocus
    handlePressed: first.pressed
    handleHovered: first.hovered
  }

  second.handle: SliderHandle {
    x: control.leftPadding + (control.horizontal ? control.second.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
    y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.second.visualPosition * (control.availableHeight - height))
    value: second.value
    handleHasFocus: activeFocus
    handlePressed: second.pressed
    handleHovered: second.hovered
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
      x: control.horizontal ? control.first.position * parent.width : 0
      y: control.horizontal ? -1 : control.second.visualPosition * parent.height + 1
      width: control.horizontal ? control.second.position * parent.width - control.first.position * parent.width -1 : 1
      height: control.horizontal ? 1 : control.second.position * parent.height - control.first.position * parent.height - 1

      color: control.enabled ? OriginTheme.accent : OriginTheme.foregroundDisable
    }
  }
}

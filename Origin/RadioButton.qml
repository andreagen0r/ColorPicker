import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material.impl as M

import Origin

T.RadioButton {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding,
                           implicitIndicatorHeight + topPadding + bottomPadding)

  spacing: 8
  padding: 8
  verticalPadding: padding + 1

  indicator: RadioIndicator {
    x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
    y: control.topPadding + (control.availableHeight - height) / 2
    control: control

    M.Ripple {
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      width: 28; height: 28

      z: -1
      anchor: control
      pressed: control.pressed
      active: enabled && ( control.down || control.visualFocus || control.hovered )
      color: control.checked ? OriginTheme.makeTransparent(OriginTheme.accent, 0.2) : OriginTheme.makeTransparent(OriginTheme.accent, 0.1)
    }
  }

  contentItem: Text {
    leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
    rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

    text: control.text
    font: control.font
    color: control.enabled ? OriginTheme.foreground : OriginTheme.foregroundDisable
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
  }
}

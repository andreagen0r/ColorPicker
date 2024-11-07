import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl

import Origin

T.SwitchDelegate {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding,
                           implicitIndicatorHeight + topPadding + bottomPadding)

  verticalPadding: OriginTheme.spacingSmall
  padding: OriginTheme.spacingSmall
  spacing: OriginTheme.spacingMedium

  icon.width: 24
  icon.height: 24
  icon.color: enabled ? OriginTheme.icon : OriginTheme.foregroundDisable

  indicator: SwitchIndicator {
    x: control.text ? (control.mirrored ? control.leftPadding : control.width - width - control.rightPadding) : control.leftPadding + (control.availableWidth - width) / 2
    y: control.topPadding + (control.availableHeight - height) / 2
    control: control
  }

  contentItem: IconLabel {
    leftPadding: !control.mirrored ? 0 : control.indicator.width + control.spacing
    rightPadding: control.mirrored ? 0 : control.indicator.width + control.spacing

    spacing: control.spacing
    mirrored: control.mirrored
    display: control.display
    alignment: control.display === IconLabel.IconOnly || control.display === IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft

    icon: control.icon
    text: control.text
    font: control.font
    color: control.enabled ? OriginTheme.foreground : OriginTheme.foregroundDisable
  }

  background: Rectangle {
    implicitHeight: OriginTheme.buttonHeight

    color: control.highlighted ? OriginTheme.surface : "transparent"

    Ripple {
      width: parent.width
      height: parent.height

      clip: visible
      pressed: control.pressed
      anchor: control
      active: control.down || control.visualFocus || control.hovered
      color: OriginTheme.makeTransparent( Qt.lighter( OriginTheme.surface, 1.5), 0.5)
    }
  }
}

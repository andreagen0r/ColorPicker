import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl

import Origin

// TODO: Editar

T.ItemDelegate {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding,
                           implicitIndicatorHeight + topPadding + bottomPadding)

  padding: 16
  verticalPadding: 8
  spacing: 16

  icon.width: 24
  icon.height: 24
  icon.color: enabled ? OriginTheme.icon : OriginTheme.foregroundDisable

  contentItem: IconLabel {
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

    color: control.highlighted ? OriginTheme.accent : "transparent"

    Ripple {
      width: parent.width
      height: parent.height

      clip: visible
      pressed: control.pressed
      anchor: control
      active: enabled && (control.down || control.visualFocus || control.hovered)
      color: OriginTheme.makeTransparent( Qt.lighter( OriginTheme.surface, 1.5), 0.5)
    }
  }
}

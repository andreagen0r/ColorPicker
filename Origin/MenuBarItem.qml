import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl

import Origin

T.MenuBarItem {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding,
                           implicitIndicatorHeight + topPadding + bottomPadding)

  padding: OriginTheme.spacingMedium
  verticalPadding: OriginTheme.spacingMedium
  spacing: OriginTheme.spacingMedium

  icon.width: 24
  icon.height: 24
  icon.color: enabled ? OriginTheme.icon : OriginTheme.foregroundDisable

  contentItem: IconLabel {
    spacing: control.spacing
    mirrored: control.mirrored
    display: control.display
    alignment: Qt.AlignLeft

    icon: control.icon
    text: control.text
    font: control.font
    color: !control.enabled ? OriginTheme.foregroundDisable
                            : control.highlighted ? OriginTheme.foregroundInvertedContrasted
                                                  : OriginTheme.foreground
  }

  background: Rectangle {
    implicitWidth: 40
    implicitHeight: 40
    color: control.highlighted ? OriginTheme.accent : "transparent"

    Ripple {
      width: parent.width
      height: parent.height

      clip: visible
      pressed: control.pressed
      anchor: control
      active: control.down || control.highlighted
      color: OriginTheme.makeTransparent( Qt.lighter( OriginTheme.accent, 1.5 ), 0.1 )
    }
  }
}

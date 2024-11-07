import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl

import Origin

T.TabButton {
  id: idControl

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)

  implicitHeight: Math.max(implicitBackgroundHeight + leftInset + rightInset,
                           implicitContentHeight + topPadding + bottomPadding)

  spacing: display === AbstractButton.TextUnderIcon ? OriginTheme.spacingSmall : OriginTheme.spacingMedium
  verticalPadding: OriginTheme.spacingExtraSmall
  horizontalPadding: OriginTheme.spacingMedium

  icon.width: 24
  icon.height: 24
  icon.color: !enabled ? OriginTheme.foregroundDisable
                       : checked ? OriginTheme.accent : OriginTheme.icon

  contentItem: IconLabel {
    spacing: idControl.spacing
    mirrored: idControl.mirrored
    display: idControl.display

    icon: idControl.icon
    text: idControl.text
    font: idControl.font

    color: !idControl.enabled ? OriginTheme.foregroundDisable
                              : idControl.highlighted ? OriginTheme.background
                                                      : idControl.checked && !idControl.highlighted ? OriginTheme.accent
                                                                                                    : OriginTheme.foreground
  }

  background: Rectangle {
    implicitWidth: 120
    implicitHeight: OriginTheme.buttonHeight
    color: idControl.checked || idControl.pressed ? OriginTheme.background : OriginTheme.surface

    Ripple {
      clip: true
      width: parent.width
      height: parent.height
      pressed: idControl.pressed
      anchor: idControl
      active: idControl.down || idControl.visualFocus || idControl.hovered
      color: OriginTheme.makeTransparent(OriginTheme.foreground, 0.1)
    }
  }
}

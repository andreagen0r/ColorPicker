import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl

import Origin

T.RoundButton {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  topInset: OriginTheme.spacingSmall
  leftInset: OriginTheme.spacingSmall
  rightInset: OriginTheme.spacingSmall
  bottomInset: OriginTheme.spacingSmall
  padding: OriginTheme.spacingMedium
  spacing: OriginTheme.spacingSmall

  icon.width: 24
  icon.height: 24
  icon.color: !enabled ? OriginTheme.foregroundDisable :
                         flat && highlighted ? OriginTheme.accent :
                                               highlighted ? OriginTheme.accent : OriginTheme.foreground

  contentItem: IconLabel {
    spacing: control.spacing
    mirrored: control.mirrored
    display: control.display

    icon: control.icon
    text: control.text
    font: control.font
    color: !control.enabled ? OriginTheme.foregroundDisable :
                              control.down ? OriginTheme.foregroundInvertedContrasted :
                                             control.flat && OriginTheme.foreground ? OriginTheme.accent :
                                                                                      control.highlighted ? OriginTheme.foregroundHighlight : OriginTheme.foreground
  }

  background: Rectangle {
    implicitWidth: OriginTheme.buttonHeight
    implicitHeight: OriginTheme.buttonHeight

    radius: control.radius
    color: !control.enabled ? OriginTheme.buttonDisable
                            : control.down ? OriginTheme.buttonHighlighted
                                           : control.checked || control.highlighted ? OriginTheme.buttonHighlighted
                                                                                    : OriginTheme.button

    layer.enabled: control.enabled
    layer.effect: ElevationEffect {
      elevation: control.down ? 2 : 12
    }
  }
}

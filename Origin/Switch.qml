import QtQuick
import QtQuick.Templates as T

import Origin

T.Switch {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding,
                           implicitIndicatorHeight + topPadding + bottomPadding)

  padding: OriginTheme.spacingSmall
  spacing: OriginTheme.spacingMedium

  indicator: SwitchIndicator {
    x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
    y: control.topPadding + (control.availableHeight - height) / 2
    control: control
  }

  contentItem: Text {
    leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
    rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

    text: control.text
    font: control.font
    color: control.enabled ? ( control.visualFocus ? OriginTheme.accent : OriginTheme.foreground )
                           : OriginTheme.foregroundDisable
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
  }
}

import QtQuick
import QtQuick.Templates as T

import Origin

T.Frame {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  padding: 12
  verticalPadding: OriginTheme.spacingMedium

  background: Rectangle {
    radius: OriginTheme.radiusSmall
    color: "transparent"
    border.color: OriginTheme.surfaceBackground
  }
}

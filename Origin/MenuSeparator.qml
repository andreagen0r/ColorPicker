import QtQuick
import QtQuick.Templates as T

import Origin

T.MenuSeparator {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  verticalPadding: OriginTheme.spacingSmall

  contentItem: Rectangle {
    implicitWidth: 200
    implicitHeight: 1
    color: OriginTheme.surfaceBackground
  }
}

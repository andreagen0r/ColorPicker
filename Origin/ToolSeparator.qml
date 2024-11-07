import QtQuick
import QtQuick.Templates as T

import Origin

T.ToolSeparator {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  contentItem: Rectangle {
    implicitWidth: control.vertical ? 1 : 48
    implicitHeight: control.vertical ? 48 : 1
    color: OriginTheme.divider
  }
}

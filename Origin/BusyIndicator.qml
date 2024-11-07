import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material.impl

import Origin

T.BusyIndicator {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  padding: 0

  contentItem: Rectangle {
    implicitWidth: 49
    implicitHeight: 49
    color: OriginTheme.makeTransparent(OriginTheme.background, 0.8)
    radius: implicitHeight / 2
    opacity: control.running ? 1 : 0
    Behavior on opacity { OpacityAnimator { duration: OriginTheme.speedSuperFast } }

    BusyIndicatorImpl {
      anchors.fill: parent
      anchors.margins: OriginTheme.spacingSmall
      color: OriginTheme.accent

      running: control.running
      opacity: control.running ? 1 : 0
      Behavior on opacity { OpacityAnimator { duration: OriginTheme.speedSuperFast } }
    }
  }
}

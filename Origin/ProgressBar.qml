import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Basic.impl

import Origin

T.ProgressBar {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  contentItem: ProgressBarImpl {
    implicitWidth: 200
    implicitHeight: 4
    scale: control.mirrored ? -1 : 1
    progress: control.position
    indeterminate: control.visible && control.indeterminate
    color: OriginTheme.accent
  }

  background: Rectangle {
    implicitWidth: 200
    implicitHeight: 4
    y: (control.height - height)
    color: OriginTheme.surfaceBackground
  }
}

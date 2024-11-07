import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls

import Origin

T.MenuBar {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  delegate: MenuBarItem { }

  contentItem: Row {
    spacing: control.spacing

    Repeater {
      model: control.contentModel
    }
  }

  background: Rectangle {
    implicitHeight: 40
    color: OriginTheme.surface
  }
}

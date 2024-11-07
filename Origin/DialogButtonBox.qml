import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls

import Origin

T.DialogButtonBox {
  id: idControl

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  spacing: 24 // Ficará com valor fixo por algum bug que desloca ao usar o OriginTheme.spacing
  padding: OriginTheme.spacingMedium
  alignment: Qt.AlignRight
  buttonLayout: T.DialogButtonBox.KdeLayout
  verticalPadding: OriginTheme.spacingMedium
  horizontalPadding: OriginTheme.spacingLarge

  delegate: Button {
    flat: true
  }

  contentItem: ListView {
    model: idControl.contentModel
    spacing: idControl.spacing
    orientation: ListView.Horizontal
    boundsBehavior: Flickable.StopAtBounds
    snapMode: ListView.SnapToItem
  }

  background: Item {
    // Rectangle {
    //   width: parent.width
    //   height: 1
    //   color: OriginTheme.divider
    // }
  }
}

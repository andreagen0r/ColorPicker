import QtQuick
import QtQuick.Templates as T

import Origin.ColorPicker

T.Control {
  id: control

  implicitWidth: Math.max( implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding )
  implicitHeight: Math.max( implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding )

  required property ColorPicker_p internal

  signal clicked
  signal doubleClicked

  background: Item {
    implicitWidth: 50
    implicitHeight: implicitWidth

    Image {
      anchors.fill: parent
      visible: control.internal.color.a < 1
      fillMode: Image.Tile
      horizontalAlignment: Image.AlignLeft
      verticalAlignment: Image.AlignTop
      source: Qt.resolvedUrl("assets/alphaBackground.png")
    }

    Rectangle {
      anchors.fill: parent
      color: control.internal.color
      border.color: "lightgray"
    }
  }


  DropArea {
    id: dropAreag
    anchors.fill: parent
    keys: ["application/x-color"]
    onEntered: drag => {
                 if (!drag.hasColor) {
                   drag.accepted = false
                 }
               }
    onDropped: drop => {
                 if (drop.hasColor) {
                   if (drop.proposedAction === Qt.CopyAction) {
                     control.internal.color = drop.colorData
                     drop.acceptProposedAction()
                   }
                 }
               }
  }

  Item {
    id: draggable
    anchors.fill: parent
    Drag.dragType: Drag.Automatic
    Drag.supportedActions: Qt.CopyAction
    Drag.mimeData: {
      "application/x-color": control.internal.color
    }

    MouseArea {
      anchors.fill: parent
      onClicked: control.clicked()
      onDoubleClicked: control.doubleClicked()
    }
  }

  DragHandler {
    id: dragHandler
    target: draggable
    onActiveChanged: draggable.Drag.active = active
  }
}

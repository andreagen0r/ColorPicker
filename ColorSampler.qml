import QtQuick
import QtQuick.Templates as T

import ColorPicker

T.Control {
  id: control

  implicitWidth: Math.max( implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding )
  implicitHeight: Math.max( implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding )

  required property ColorPickerBackend backend

  signal clicked
  signal doubleClicked

  background: Item {
    implicitWidth: 50
    implicitHeight: implicitWidth

    Image {
      anchors.fill: parent
      visible: control.backend.currentColor.a < 1
      fillMode: Image.Tile
      horizontalAlignment: Image.AlignLeft
      verticalAlignment: Image.AlignTop
      source: Qt.resolvedUrl("assets/alphaBackground.png")
    }

    Rectangle {
      anchors.fill: parent
      color: control.backend.currentColor
      border.color: "lightgray"
    }
  }

  DropArea {
    id: dropArea
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
                     control.backend.currentColor = drop.colorData
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
      "application/x-color": control.backend.currentColor
    }

    MouseArea {
      anchors.fill: parent
      onClicked: control.clicked()
      onDoubleClicked: control.doubleClicked()
    }
  }

  DragHandler {
    target: draggable
    onActiveChanged: draggable.Drag.active = active
  }
}

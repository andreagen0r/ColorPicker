import QtQuick

import ColorTools

Item {
  id: root

  property alias color: internal.color
  property bool border: true
  property real radius: 0

  signal clicked
  signal doubleClicked

  ColorSampler_p {
    id: internal
  }

  Image {
    anchors.fill: parent
    visible: internal.color.a < 1
    fillMode: Image.Tile
    horizontalAlignment: Image.AlignLeft
    verticalAlignment: Image.AlignTop
    source: "assets/alphaBackground.png"
  }

  Rectangle {
    anchors.fill: parent
    radius: root.radius
    border.width: root.border ? 1 : 0
    color: internal.color

    Rectangle {
      anchors.fill: parent
      anchors.margins: 1
      color: "transparent"
      border.width: root.border ? 1 : 0
      border.color: "lightgray"
      radius: root.radius
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
                     internal.setColor(drop.colorData)
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
      "application/x-color": internal.color
    }

    MouseArea {
      anchors.fill: parent
      onClicked: root.clicked()
      onDoubleClicked: root.doubleClicked()
    }
  }

  DragHandler {
    id: dragHandler
    target: draggable
    onActiveChanged: draggable.Drag.active = active
  }
}

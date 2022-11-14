import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ColorTools

Control {
  id: root

  property alias historySize: model.historySize
  property real swatchSize: 30
  readonly property color color: internal.color

  function addToHistory(_color) {
    model.append(_color)
  }

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, topPadding + bottomPadding)

  ColorSampler_p {
    id: internal
  }

  ColorHistoryModel {
    id: model
  }

  background: Flickable {
    clip: true
    boundsBehavior: Flickable.OvershootBounds
    implicitHeight: root.swatchSize
    flickableDirection: Flickable.HorizontalFlick
    contentHeight: root.swatchSize
    contentWidth: Math.max(root.width, repeater.count * (root.swatchSize + row.spacing))

    Row {
      id: row
      spacing: 2
      anchors.fill: parent

      Repeater {
        id: repeater

        property int index: -1

        model: model
        delegate: Item {
          anchors.verticalCenter: parent.verticalCenter
          width: root.swatchSize
          height: width

          Image {
            anchors.fill: parent
            visible: model.color.a < 1
            fillMode: Image.Tile
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignTop
            source: "assets/alphaBackground.png"
          }

          Rectangle {
            id: sampler
            anchors.fill: parent
            color: model.color
          }

          Item {
            id: draggable
            anchors.fill: parent
            Drag.dragType: Drag.Automatic
            Drag.supportedActions: Qt.CopyAction
            Drag.mimeData: {
              "application/x-color": model.color
            }
          }

          DragHandler {
            id: dragHandler
            target: draggable
            onActiveChanged: draggable.Drag.active = active
          }

          MouseArea {
            id: mouseHist
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            propagateComposedEvents: false

            onClicked: _mouse => {
                         if (_mouse.button === Qt.LeftButton) {
                           internal.setColor(sampler.color)
                         } else if (_mouse.button === Qt.RightButton) {
                           menu.x = mapToItem(row, mouseX, mouseY).x + (root.swatchSize - mouseX) + 2
                           repeater.index = index
                           menu.open()
                         }
                       }
          }
        }
      }
    }
  }

  Menu {
    id: menu

    MenuItem {
      text: qsTr("Delete")
      onTriggered: model.removeAt(repeater.index, 1)
    }

    MenuSeparator {}

    MenuItem {
      text: qsTr("Clear History")
      onTriggered: model.clear()
    }
  }
}

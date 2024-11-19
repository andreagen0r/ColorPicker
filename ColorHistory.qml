pragma ComponentBehavior: Bound

import QtQuick

import ColorPicker
import Origin.Controls

Control {
  id: control

  required property ColorPickerBackend backend

  property alias historySize: model.historySize
  property real swatchSize: 30

  function addToHistory() : void {
    model.append(control.backend.currentColor)
  }

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, topPadding + bottomPadding)

  background: Flickable {
    clip: true
    boundsBehavior: Flickable.OvershootBounds
    implicitHeight: control.swatchSize
    flickableDirection: Flickable.HorizontalFlick
    contentHeight: control.swatchSize
    contentWidth: Math.max(control.width, repeater.count * (control.swatchSize + row.spacing))

    Row {
      id: row
      spacing: 2
      anchors.fill: parent

      Repeater {
        id: repeater

        property int index: -1

        model: ColorHistoryModel { id: model }

        delegate: Item {
          id: swatchDelegate
          required property color colorRole
          required property int index

          anchors.verticalCenter: parent.verticalCenter
          width: control.swatchSize
          height: width

          Image {
            anchors.fill: parent
            visible: swatchDelegate.colorRole.a < 1
            fillMode: Image.Tile
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignTop
            source: Qt.resolvedUrl("assets/alphaBackground.png")
          }

          Rectangle {
            id: sampler
            anchors.fill: parent
            color: swatchDelegate.colorRole
          }

          Item {
            id: draggable
            anchors.fill: parent
            Drag.dragType: Drag.Automatic
            Drag.supportedActions: Qt.CopyAction
            Drag.mimeData: {
              "application/x-color": swatchDelegate.colorRole
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
            hoverEnabled: true

            ToolTip {

              visible: mouseHist.containsMouse
              delay: Application.styleHints.mousePressAndHoldInterval
              text: swatchDelegate.colorRole.toString()
            }
            onClicked: _mouse => {
              if (_mouse.button === Qt.LeftButton) {
                control.backend.currentColor = swatchDelegate.colorRole
              } else if (_mouse.button === Qt.RightButton) {
                repeater.index = swatchDelegate.index
                menu.x = mapToItem(row, mouseX, mouseY).x + (control.swatchSize - mouseX) + 2
                menu.y = mouseY
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
      onTriggered: {
        model.removeRows(repeater.index, repeater.index)
      }
    }

    MenuSeparator {}

    MenuItem {
      text: qsTr("Clear History")
      onTriggered: model.clear()
    }
  }
}

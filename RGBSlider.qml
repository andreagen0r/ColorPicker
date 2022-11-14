import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ColorTools

Item {
  id: root

  property alias color: internal.color

  signal editFinished

  implicitWidth: col.implicitWidth
  implicitHeight: col.implicitHeight

  ColorSampler_p {
    id: internal
  }

  QtObject {
    id: rgb
    readonly property color r1: Qt.rgba(0, greenSlider.value, blueSlider.value, 1)
    readonly property color r2: Qt.rgba(1, greenSlider.value, blueSlider.value, 1)
    readonly property color g1: Qt.rgba(redSlider.value, 0, blueSlider.value, 1)
    readonly property color g2: Qt.rgba(redSlider.value, 1, blueSlider.value, 1)
    readonly property color b1: Qt.rgba(redSlider.value, greenSlider.value, 0, 1)
    readonly property color b2: Qt.rgba(redSlider.value, greenSlider.value, 1, 1)
    readonly property color a1: Qt.rgba(redSlider.value, greenSlider.value, blueSlider.value, 0)
    readonly property color a2: Qt.rgba(redSlider.value, greenSlider.value, blueSlider.value, 1)

    readonly property real defaultHeight: 32
  }

  Rectangle {
    anchors.right: parent.right
    width: parent.width - (redSlider.leftPadding + redSlider.spacing)
    height: col.implicitHeight - 1
    color: "black"
  }
  ColumnLayout {
    id: col
    anchors.fill: parent
    spacing: 1

    ColorSlider {
      id: redSlider
      Layout.fillWidth: true
      Layout.preferredHeight: rgb.defaultHeight
      text: "R:"
      value: internal.color.r
      sliderBackground: Rectangle {
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            color: rgb.r1
          }
          GradientStop {
            position: 1.0
            color: rgb.r2
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setRed(value)
      KeyNavigation.down: greenSlider
    }

    ColorSlider {
      id: greenSlider
      Layout.fillWidth: true
      Layout.preferredHeight: rgb.defaultHeight
      text: "G:"
      value: internal.color.g
      sliderBackground: Rectangle {
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            position: 0.0
            color: rgb.g1
          }
          GradientStop {
            position: 1.0
            color: rgb.g2
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setGreen(value)
      KeyNavigation.down: blueSlider
    }

    ColorSlider {
      id: blueSlider
      Layout.fillWidth: true
      Layout.preferredHeight: rgb.defaultHeight
      text: "B:"
      value: internal.color.b
      sliderBackground: Rectangle {
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            position: 0.0
            color: rgb.b1
          }
          GradientStop {
            position: 1.0
            color: rgb.b2
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setBlue(value)
      KeyNavigation.down: alphaSlider
    }

    ColorSlider {
      id: alphaSlider
      Layout.fillWidth: true
      Layout.preferredHeight: rgb.defaultHeight
      text: "A:"
      value: internal.color.a
      sliderBackground: Item {
        Image {
          anchors.fill: parent
          fillMode: Image.Tile
          horizontalAlignment: Image.AlignLeft
          verticalAlignment: Image.AlignTop
          source: "assets/alphaBackground.png"
        }

        Rectangle {
          anchors.fill: parent
          gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
              position: 0.0
              color: rgb.a1
            }
            GradientStop {
              position: 1
              color: rgb.a2
            }
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setAlpha(value)
      KeyNavigation.down: redSlider
    }

    Item {
      Layout.fillHeight: implicitHeight > 0 ? false : true
    }
  }
}

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
    readonly property real defaultHeight: 32
  }

  Rectangle {
    anchors.right: parent.right
    width: parent.width - (hueSlider.leftPadding + hueSlider.spacing)
    height: col.implicitHeight - 1
    color: "black"
  }

  ColumnLayout {
    id: col
    anchors.fill: parent
    spacing: 1

    ColorSlider {
      id: hueSlider
      Layout.fillWidth: true
      Layout.preferredHeight: internal.defaultHeight
      text: "H:"
      value: internal.color.hsvHue
      sliderBackground: Rectangle {
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            position: 0.0
            color: "red"
          }
          GradientStop {
            position: (60.0 / 360)
            color: "yellow"
          }
          GradientStop {
            position: (120.0 / 360)
            color: "green"
          }
          GradientStop {
            position: (180.0 / 360)
            color: "cyan"
          }
          GradientStop {
            position: (240.0 / 360)
            color: "blue"
          }
          GradientStop {
            position: (300.0 / 360)
            color: "magenta"
          }
          GradientStop {
            position: 1.0
            color: "red"
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setHue(value)
      KeyNavigation.down: saturationSlider
    }

    ColorSlider {
      id: saturationSlider
      Layout.fillWidth: true
      Layout.preferredHeight: internal.defaultHeight
      text: "S:"
      value: internal.color.hsvSaturation
      sliderBackground: Rectangle {
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            position: 0.0
            color: Qt.hsva(internal.color.hsvHue, 0, internal.color.hsvValue)
          }
          GradientStop {
            position: 1.0
            color: internal.color
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setSaturation(value)
      KeyNavigation.down: blueSlider
    }

    ColorSlider {
      id: blueSlider
      Layout.fillWidth: true
      Layout.preferredHeight: internal.defaultHeight
      text: "V:"
      value: internal.color.hsvValue
      sliderBackground: Rectangle {
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            position: 0.0
            color: Qt.hsva(internal.color.hsvHue, internal.color.hsvSaturation, 0)
          }
          GradientStop {
            position: 1.0
            color: internal.color
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setValue(value)
      KeyNavigation.down: alphaSlider
    }

    ColorSlider {
      id: alphaSlider
      Layout.fillWidth: true
      Layout.preferredHeight: internal.defaultHeight
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
              color: Qt.hsva(internal.color.hsvHue, internal.color.hsvSaturation, internal.color.hsvValue, 0)
            }
            GradientStop {
              position: 1
              color: internal.color
            }
          }
        }
      }
      onEditFinished: root.editFinished()
      onValueChanged: internal.setAlpha(value)
      KeyNavigation.down: hueSlider
    }

    Item {
      Layout.fillHeight: implicitHeight > 0 ? false : true
    }
  }
}

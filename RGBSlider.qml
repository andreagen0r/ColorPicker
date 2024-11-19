import QtQuick
import QtQuick.Layouts

import ColorPicker
import Origin.Controls

Item {
  id: control

  required property ColorPickerBackend backend

  signal editFinished

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
  }

  ColumnLayout {
    id: col
    anchors.fill: parent
    spacing: 1

    ColorSlider {
      id: redSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "R"
      value: control.backend.currentColor.r
      sliderBackgroundGradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: rgb.r1
        }
        GradientStop {
          position: 1.0
          color: rgb.r2
        }
      }

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.r = newValue
                       }
    }

    ColorSlider {
      id: greenSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "G"
      value: control.backend.currentColor.g

      sliderBackgroundGradient: Gradient {
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

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.g = newValue
                       }
    }

    ColorSlider {
      id: blueSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "B"
      value: control.backend.currentColor.b

      sliderBackgroundGradient: Gradient {
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

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.b = newValue
                       }
    }

    ColorSlider {
      id: alphaSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "A"
      value: control.backend.currentColor.a

      sliderBackgroundGradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: rgb.a1
        }
        GradientStop {
          position: 1.0
          color: rgb.a2
        }
      }

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.a = newValue
                       }
    }

    Item { Layout.fillHeight: true }
  }
}

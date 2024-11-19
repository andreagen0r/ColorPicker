import QtQuick
import QtQuick.Layouts

import ColorPicker
import Origin.Controls

Item {
  id: control

  required property ColorPickerBackend backend

  signal editFinished

  implicitWidth: col.implicitWidth
  implicitHeight: col.implicitHeight


  ColumnLayout {
    id: col
    anchors.fill: parent
    spacing: 1

    ColorSlider {
      id: hueSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "H"
      value: control.backend.currentColor.hsvHue
      sliderBackgroundGradient: Gradient {
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
      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.hsvHue = newValue
                       }
    }

    ColorSlider {
      id: satSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "S"
      value: control.backend.currentColor.hsvSaturation

      sliderBackgroundGradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: Qt.hsva(control.backend.currentColor.hsvHue, 0, control.backend.currentColor.hsvValue)
        }
        GradientStop {
          position: 1.0
          color: control.backend.currentColor
        }
      }

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.hsvSaturation = newValue
                       }
    }

    ColorSlider {
      id: valSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "V"
      value: control.backend.currentColor.hsvValue

      sliderBackgroundGradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: Qt.hsva(control.backend.currentColor.hsvHue, control.backend.currentColor.hsvSaturation, 0)
        }
        GradientStop {
          position: 1.0
          color: control.backend.currentColor
        }
      }

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.hsvValue = newValue
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
          color: Qt.hsva(control.backend.currentColor.hsvHue, control.backend.currentColor.hsvSaturation, control.backend.currentColor.hsvValue, 0)
        }
        GradientStop {
          position: 1.0
          color: control.backend.currentColor
        }
      }

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.backend.currentColor.a = newValue
                       }
    }

    Item {
      Layout.fillHeight: implicitHeight > 0 ? false : true
    }
  }
}

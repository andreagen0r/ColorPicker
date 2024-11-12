import QtQuick
import QtQuick.Layouts

import Origin.ColorPicker
import Origin.Controls

Item {
  id: control

  required property ColorPicker_p internal

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
      value: control.internal.color.hsvHue
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
                         control.internal.color.hsvHue = newValue
                       }
    }

    ColorSlider {
      id: satSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "S"
      value: control.internal.color.hsvSaturation

      sliderBackgroundGradient: Gradient {
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

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.internal.color.hsvSaturation = newValue
                       }
    }

    ColorSlider {
      id: valSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "V"
      value: control.internal.color.hsvValue

      sliderBackgroundGradient: Gradient {
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

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.internal.color.hsvValue = newValue
                       }
    }

    ColorSlider {
      id: alphaSlider
      Layout.fillWidth: true
      Layout.preferredHeight: 32

      label: "A"
      value: control.internal.color.a

      sliderBackgroundGradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: Qt.hsva(internal.color.hsvHue, internal.color.hsvSaturation, internal.color.hsvValue, 0)
        }
        GradientStop {
          position: 1.0
          color: control.internal.color
        }
      }

      onEditFinished: control.editFinished()
      onValueModified: (newValue) => {
                         control.internal.color.a = newValue
                       }
    }

    Item {
      Layout.fillHeight: implicitHeight > 0 ? false : true
    }
  }
}

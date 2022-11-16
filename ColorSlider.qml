import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

import ColorTools

FocusScope {
  id: root

  property color textColor: "#B5B5B9"
  property string text: ""

  property alias sliderBackground: slider.background
  property alias value: internal.value
  property alias leftPadding: control.leftPadding
  property alias spacing: control.spacing
  property alias from: slider.from
  property alias to: slider.to

  signal editFinished

  implicitWidth: Math.max(control.implicitBackgroundWidth + control.leftInset + control.rightInset, /*leftPadding +*/ control.rightPadding)
  implicitHeight: Math.max(control.implicitBackgroundHeight + control.topInset + control.bottomInset, control.topPadding + control.bottomPadding)

  Control {
    id: control
    anchors.fill: parent
    leftPadding: 18
    spacing: 6

    ColorSlider_p {
      id: internal
    }

    background: RowLayout {
      implicitWidth: 150
      implicitHeight: 32
      spacing: control.spacing

      Label {
        id: label
        Layout.fillHeight: true
        Layout.preferredWidth: control.leftPadding
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        text: root.text
      }

      RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 0

        TextField {
          id: textField
          z: 1
          Layout.fillHeight: true
          Layout.preferredWidth: 75
          topPadding: 0
          bottomPadding: 0
          leftPadding: 6
          rightPadding: 6
          focus: true
          validator: TextFieldDoubleValidator {
            bottom: 0
            top: 1
            decimals: 3
          }
          color: acceptableInput ? root.textColor : "#B82C2C"
          text: internal.value.toFixed(3)

          onEditingFinished: {
            if (acceptableInput) {
              internal.setValue(parseFloat(text))
            } else {
              if (parseFloat(text) <= 0) {
                internal.setValue(0)
              } else if (parseFloat(text) > 1) {
                internal.setValue(1.0)
              } else {
                textField.undo()
              }
            }
          }

          Keys.onPressed: event => {
                            let stepSize = 0.1

                            if (event.modifiers & Qt.ShiftModifier) {
                              stepSize = 0.01
                            }

                            switch (event.key) {
                              case Qt.Key_Plus:
                              {
                                internal.increase(stepSize)
                                break
                              }
                              case Qt.Key_Minus:
                              {
                                internal.decrease(stepSize)
                                break
                              }
                            }
                          }

          ToolTip.visible: hovered
          ToolTip.delay: 1500
          ToolTip.timeout: 3000
          ToolTip.text: qsTr("Use the Plus or Minus key to increase or decrease values.\nPress Shift Key to more precise adjustments")
        }

        Slider {
          id: slider
          Layout.fillWidth: true
          Layout.fillHeight: true
          wheelEnabled: true
          value: internal.value
          focus: false

          handle: Rectangle {
            x: slider.visualPosition * (parent.width - width)
            y: (parent.height - height) / 2
            implicitWidth: 2
            height: Math.round(slider.height * 0.7)
          }

          // INFO: Circle Option

          //          handle: Rectangle {
          //            x: slider.visualPosition * (parent.width - width)
          //            y: (parent.height - height) / 2
          //            implicitWidth: 20
          //            implicitHeight: 20
          //            radius: 10
          //            smooth: true
          //            color: "transparent" //Qt.hsva(0, 0, 1, 0.5)
          //            border.width: 2
          //            border.color: Qt.hsva(0, 0, 0, 0.8)
          //            scale: slider.pressed ? 0.9 : 1

          //            Rectangle {
          //              anchors.fill: parent
          //              anchors.margins: 1
          //              radius: 10
          //              smooth: true
          //              color: "transparent" //Qt.hsva(0, 0, 1, 0.5)
          //              border.width: 2
          //              border.color: Qt.hsva(0, 0, 1, 0.8)
          //              scale: slider.pressed ? 0.9 : 1
          //            }
          //          }
          onValueChanged: internal.setValue(value)
          onPressedChanged: {
            if (!pressed) {
              root.editFinished()
            }
          }
        }
      }
    }
  }
}

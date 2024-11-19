import QtQuick
import QtQuick.Layouts

import Origin.Controls
import ColorPicker

Control {
  id: control

  implicitWidth: Math.max( implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding )
  implicitHeight: Math.max( implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding )

  property string label: ""
  property alias sliderBackgroundColor: sliderBackground.color
  property alias sliderBackgroundGradient: sliderBackground.gradient
  property real value: _private.value

  signal editFinished
  signal valueModified( newValue : real )

  spacing: 0
  topPadding: 0
  bottomPadding: 0
  leftPadding: 12

  onValueChanged: {
    if (_private.value != value) {
      _private.value = value
    }
  }

  QtObject {
    id: _private
    readonly property real defaultHeight: 32

    property real value: 0.0
  }

  background: RowLayout {
    implicitWidth: 150
    implicitHeight: 32
    spacing: 0

    Label {
      Layout.minimumWidth: 18
      verticalAlignment: Text.AlignVCenter
      text: control.label
    }

    TextField {
      id: textField
      Layout.fillWidth: true
      Layout.preferredWidth: 20

      focus: true
      text: control.value.toFixed(3)
      color: acceptableInput ? control.palette.active.text : "#B82C2C"
      validator: TextFieldDoubleValidator {
        bottom: 0
        top: 1
        decimals: 3
      }

      onEditingFinished: control.editFinished()

      Keys.onPressed: event => {
                        let stepSize = 0.1

                        if (event.modifiers & Qt.ControlModifier &&
                            event.modifiers & Qt.ShiftModifier) {
                          stepSize = 0.001
                        } else if (event.modifiers & Qt.ShiftModifier) {
                          stepSize = 0.01
                        }

                        switch (event.key) {
                          case Qt.Key_Plus:
                          {
                            const v = _private.value + stepSize
                            _private.value = Math.max(Math.min(v, 1.0), 0.0)
                            control.valueModified(_private.value)
                            break
                          }
                          case Qt.Key_Minus:
                          {
                            const v = _private.value - stepSize
                            _private.value = Math.max(Math.min(v, 1.0), 0.0)
                            control.valueModified(_private.value)
                            break
                          }
                          case Qt.Key_Enter: {
                            if (acceptableInput) {
                              const v = parseFloat(text)
                              _private.value = Math.max(Math.min(v, 1.0), 0.0)
                              control.valueModified(_private.value)
                              control.editFinished()
                            } else  {
                              textField.undo()
                            }

                            break
                          }
                        }
                      }

      ToolTip.visible: hovered
      ToolTip.delay: 1500
      ToolTip.timeout: 3000
      ToolTip.text: qsTr("Use the Plus or Minus key to increase or decrease values.\nPress Shift or Ctrl+Shift Key to more precise adjustments")
    }

    Slider {
      id: slider
      Layout.fillWidth: true
      Layout.preferredWidth: 80
      activeFocusOnTab: false
      wheelEnabled: true
      value: control.value

      Timer {
        id: tm
        interval: 300
        repeat: false
        triggeredOnStart: false
        onTriggered: control.editFinished()
      }

      onMoved: {
        _private.value = slider.value
        control.valueModified(_private.value)

        if (!pressed) {
          tm.restart()
        }
      }

      onPressedChanged: {
        if (!pressed) {
          control.editFinished()
        }
      }

      Keys.onPressed: event => {
                        switch (event.key) {
                          case Qt.Key_Enter: {
                            control.editFinished()
                            break
                          }
                        }
                      }

      handle: Rectangle {
        x: slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 2
        implicitHeight: 32
        color: slider.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
      }

      background: Rectangle {
        id: sliderBackground
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: slider.horizontal ? 200 : 32
        implicitHeight: slider.horizontal ? 32 : 200
        width: slider.horizontal ? slider.availableWidth : 32
        height: slider.horizontal ? 32 : slider.availableHeight
        scale: slider.horizontal && slider.mirrored ? -1 : 1

        Image {
          z: -1
          anchors.fill: parent
          fillMode: Image.Tile
          horizontalAlignment: Image.AlignLeft
          verticalAlignment: Image.AlignTop
          source: Qt.resolvedUrl("assets/alphaBackground.png")
        }
      }
    }
  }
}

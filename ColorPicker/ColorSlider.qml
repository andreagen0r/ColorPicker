import QtQuick
import Origin
import QtQuick.Layouts

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
      id: label
      Layout.minimumWidth: 18
      // Layout.
      // rightPadding: 6
      // horizontalAlignment: Text.AlignRight
      verticalAlignment: Text.AlignVCenter
      text: control.label
    }

    TextField {
      id: textField
      // Layout.minimumWidth: 70
      // Layout.maximumWidth: 70
      Layout.fillWidth: true
      Layout.preferredWidth: 20

      focus: true
      text: control.value.toFixed(3)
      color: acceptableInput ? OriginTheme.foreground: "#B82C2C"
      validator: TextFieldDoubleValidator {
        bottom: 0
        top: 1
        decimals: 3
      }

      onEditingFinished: {
        if (acceptableInput) {
          _private.value = parseFloat(text)
          control.valueModified(_private.value)
        }
        else {
          if (parseFloat(text) <= 0) {
            _private.value = parseFloat(text)
            control.valueModified(0.0)
          } else if (parseFloat(text) > 1) {
            _private.value = parseFloat(text)
            control.valueModified(1.0)
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
      Layout.preferredWidth: 80
      activeFocusOnTab: false
      value: control.value

      onMoved: {
        _private.value = slider.value
        control.valueModified(_private.value)
      }

      onPressedChanged: {
        if (!slider.down) {
          control.editFinished()
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
          source: "assets/alphaBackground.png"
        }
      }
    }
  }
}

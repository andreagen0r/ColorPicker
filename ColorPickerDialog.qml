pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ColorPicker
import Origin.Controls

T.Dialog {
  id: control

  property alias icon: headerTitle.icon
  property alias color: cpBackend.currentColor
  property alias eyedropPreview: eyedroptool.showPreview
  property alias eyedropPreviewSize: eyedroptool.previewSize
  property alias eyedropPreviewMaxPixels: eyedroptool.previewMaxPixels
  property alias historySize: history.historySize

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding,
                          implicitHeaderWidth,
                          implicitFooterWidth)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding
                           + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                           + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

  title: qsTr("Color Picker")
  padding: 12
  spacing: 6

  modal: true
  dim: false
  closePolicy: Popup.CloseOnEscape
  standardButtons: Dialog.Ok | Dialog.Cancel

  enter: Transition {
    // grow_fade_in
    NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
  }

  exit: Transition {
    // shrink_fade_out
    NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
  }

  background: Rectangle {
    implicitWidth: 400
    implicitHeight: 600
    radius: control.popupType === Popup.Item ? 5 : 0
    color: control.palette.active.window

    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: 6
    }
  }

  header: T.Control {
    implicitHeight: contentItem.implicitHeight + topPadding + bottomPadding
    implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding

    horizontalPadding: 12
    verticalPadding: 6
    spacing: 0

    background: Rectangle {
      color: control.palette.active.button
      topLeftRadius: control.popupType === Popup.Item ? 5 : 0
      topRightRadius: topLeftRadius

      Rectangle {
        height: 1
        color: control.palette.active.highlight
        anchors {
          left: parent.left
          right: parent.right
          bottom: parent.bottom
        }
      }
    }

    contentItem: IconLabel {
      id: headerTitle
      implicitHeight: 24

      spacing: 12
      alignment: Qt.AlignLeft
      color: control.palette.active.text
      text: control.title
      font.pointSize: 20
      font.letterSpacing: 2.0
      icon.width: 36
      icon.height: 36
    }
  }

  footer: DialogButtonBox {
    visible: count > 0
  }

  T.Overlay.modal: Rectangle {
    color: Qt.alpha( control.palette.active.shadow, 0.98)
    Behavior on opacity { NumberAnimation { duration: 150 } }
  }

  T.Overlay.modeless: Rectangle {
    Behavior on opacity { NumberAnimation { duration: 150 } }
  }

  ColorPickerBackend {
    id: cpBackend
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 24

    RowLayout {
      Layout.fillWidth: true
      Layout.fillHeight: true

      spacing: 12

      ColorSampler {
        id: sampler
        Layout.alignment: Qt.AlignBottom
        backend: cpBackend
      }

      GroupBox {
        title: qsTr("History")
        Layout.fillWidth: true
        padding: 1

        ColorHistory {
          id: history
          backend: cpBackend
          anchors.fill: parent
          swatchSize: 30
        }
      }
    }

    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.minimumHeight: 280

      ColorWheel {
        id: colorWheel
        anchors.fill: parent
        color: cpBackend.currentColor
        onColorChanged: cpBackend.currentColor = colorWheel.color
        onEditFinished: history.addToHistory()
      }

      ToolButton {
        id: eyedropBtn
        anchors.top: parent.top
        anchors.left: parent.left
        width: 48
        height: width
        padding: 0
        horizontalPadding: 0
        verticalPadding: 0
        display: AbstractButton.IconOnly
        icon.source: Qt.resolvedUrl("assets/eyedropper.svg")
        action: pickingAction
        visible: control.popupType === Popup.Item

        ToolTip.delay: 1500
        ToolTip.timeout: 3000
        ToolTip.text: "Shortcut \"P\""
        ToolTip.visible: hovered
      }

      Label {
        id: label
        anchors.right: txField.left
        anchors.verticalCenter: txField.verticalCenter
        anchors.rightMargin: 6
        text: "#"
      }

      TextField {
        id: txField
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        inputMask: "HHHHHHhh"
        width: 80
        height: 28
        topPadding: 0
        bottomPadding: 0
        leftPadding: 3
        rightPadding: 3
        text: `#${cpBackend.currentColor.toString().toUpperCase()}`
        font.pointSize: 10
        onEditingFinished: {
          cpBackend.currentColor = `#${text}`
          history.addToHistory()
        }
      }
    }

    ColumnLayout {
      Layout.fillWidth: true
      Layout.fillHeight: true
      spacing: 0

      TabBar {
        id: bar
        Layout.fillWidth: true
        TabButton {
          text: qsTr("RGB")
        }
        TabButton {
          text: qsTr("HSV")
        }
      }

      StackLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        currentIndex: bar.currentIndex

        RGBSlider {
          id: rgbSlider
          backend: cpBackend
          onEditFinished: {
            history.addToHistory()
          }
        }

        HSVSlider {
          id: hsvSlider
          backend: cpBackend
          onEditFinished: {
            history.addToHistory()
          }
        }
      }
    }
  }


  Action {
    id: pickingAction
    checkable: true
    shortcut: "P"
    onToggled: {
      if (checked && control.visible) {
        pickingWindow.showFullScreen()
        eyedroptool.startPicking()
      }
    }
  }

  Window {
    id: pickingWindow
    flags: Qt.FramelessWindowHint
    visible: false
    color: "transparent"

    function stopPicking() {
      pickingWindow.close()
      pickingAction.trigger()
    }

    EyedropPreview {
      id: eyedroptool
      anchors.fill: parent
      mouseX: mousePicker.mouseX
      mouseY: mousePicker.mouseY
      onColorChanged: cpBackend.currentColor = eyedroptool.color
    }

    Shortcut {
      sequence: StandardKey.Cancel
      onActivated: {
        eyedroptool.cancelPicking()
        pickingWindow.stopPicking()
      }
    }

    MouseArea {
      id: mousePicker
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.CrossCursor

      onClicked: {
        pickingWindow.stopPicking()
        history.addToHistory()
      }
    }
  }
}

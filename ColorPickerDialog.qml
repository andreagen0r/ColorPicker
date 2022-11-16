import QtQuick
import QtQuick.Controls

Dialog {
  id: root

  property alias color: colorPicker.color

  topPadding: 0
  bottomPadding: 0
  modal: true
  dim: false
  closePolicy: Popup.CloseOnEscape
  anchors.centerIn: Overlay.overlay
  standardButtons: Dialog.Ok | Dialog.Cancel

  onRejected: colorPicker.picking = false

  ColorPicker {
    id: colorPicker
    anchors.fill: parent
    color: colorDialog.color
  }
}

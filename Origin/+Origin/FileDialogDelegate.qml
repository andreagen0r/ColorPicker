import QtQuick
import QtQuick.Dialogs.quickimpl as DialogsQuickImpl

DialogsQuickImpl.FileDialogDelegate {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding,
                           implicitIndicatorHeight + topPadding + bottomPadding)

  padding: 6
  horizontalPadding: 12
  spacing: 24

  icon.width: 16
  icon.height: 16
  icon.color: !enabled ?  control.palette.disabled.text : highlighted ?
                           control.palette.active.highlightedText : control.palette.active.text
  icon.source: "qrc:/qt/qml/qt-project.org/imports/QtQuick/Dialogs/quickimpl/images/"
               + (fileIsDir ? "folder" : "file") + "-icon-square.png"

  file: fileUrl

  required property int index
  required property string fileName
  required property url fileUrl
  required property double fileSize
  required property date fileModified
  required property bool fileIsDir

  required property int fileDetailRowWidth

  contentItem: FileDialogDelegateLabel {
    delegate: control
    fileDetailRowTextColor: !control.enabled ?  control.palette.disabled.text : control.highlighted ?
                                                 Qt.lighter( control.palette.active.highlightedText, 1.4) : Qt.darker( control.palette.active.text, 1.4)
    fileDetailRowWidth: control.fileDetailRowWidth
  }

  background: Rectangle {
    implicitHeight: 32
    color: control.highlighted ? control.palette.active.accent : "transparent"

    Rectangle {
      z: -1
      anchors.fill: parent
      color: control.enabled ? control.palette.midlight : "transparent"
      opacity: control.highlighted || control.hovered || control.visualFocus ? 0.2 : 0

      Behavior on opacity { NumberAnimation { easing.type: Easing.OutCubic; duration: 450 } }
    }
  }
}

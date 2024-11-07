pragma ComponentBehavior: Bound

import Qt.labs.folderlistmodel
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Dialogs.quickimpl
import QtQuick.Templates as T
import Origin

import "." as DialogsImpl

FileDialogImpl {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding,
                          implicitFooterWidth)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding
                           + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                           + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

  leftPadding: 12
  rightPadding: 12

  standardButtons: T.Dialog.Open | T.Dialog.Cancel

  FileDialogImpl.buttonBox: buttonBox
  FileDialogImpl.nameFiltersComboBox: nameFiltersComboBox
  FileDialogImpl.fileDialogListView: fileDialogListView
  FileDialogImpl.breadcrumbBar: breadcrumbBar
  FileDialogImpl.fileNameLabel: fileNameLabel
  FileDialogImpl.fileNameTextField: fileNameTextField
  FileDialogImpl.overwriteConfirmationDialog: overwriteConfirmationDialog

  background: Rectangle {
    implicitWidth: 600
    implicitHeight: 400
    color: control.palette.active.mid
  }

  header: ColumnLayout {
    spacing: 6

    Label {
      text: control.title
      visible: parent.parent?.parent === Overlay.overlay && control.title.length > 0
      elide: Label.ElideRight
      font.bold: true
      font.pixelSize: 16

      Layout.leftMargin: 12
      Layout.rightMargin: 12
      Layout.topMargin: 12
      Layout.fillWidth: true
    }

    DialogsImpl.FolderBreadcrumbBar {
      id: breadcrumbBar
      dialog: control

      Layout.topMargin: 12
      Layout.leftMargin: 12
      Layout.rightMargin: 12
      Layout.fillWidth: true
    }
  }

  contentItem: Rectangle {
    color: control.palette.active.base

    ListView {
      id: fileDialogListView
      objectName: "fileDialogListView"
      anchors.fill: parent
      anchors.topMargin: 6
      anchors.bottomMargin: 2
      anchors.leftMargin: 2
      anchors.rightMargin: 2
      clip: true

      ScrollBar.vertical: ScrollBar {}

      model: FolderListModel {
        folder: control.currentFolder
        nameFilters: control.selectedNameFilter.globs
        showDirsFirst: PlatformTheme.themeHint(PlatformTheme.ShowDirectoriesFirst)
        sortCaseSensitive: false
      }

      delegate: DialogsImpl.FileDialogDelegate {
        objectName: "fileDialogDelegate" + index
        width: ListView.view.width
        highlighted: ListView.isCurrentItem
        dialog: control
        fileDetailRowWidth: nameFiltersComboBox.width

        KeyNavigation.backtab: breadcrumbBar
        KeyNavigation.tab: fileNameTextField.visible ? fileNameTextField : nameFiltersComboBox
      }
    }
  }

  footer: Pane {

    GridLayout {
      anchors.fill: parent
      columnSpacing: 6
      rowSpacing: 6
      columns: 3

      Label {
        id: fileNameLabel
        Layout.fillHeight: true
        text: qsTr("File name")
        visible: false
        verticalAlignment: Text.AlignVCenter
      }

      TextField {
        id: fileNameTextField
        objectName: "fileNameTextField"
        Layout.fillWidth: true
        Layout.fillHeight: true
        visible: false
        Layout.columnSpan: 2
      }

      Label {
        text: qsTr("Filter")
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
      }

      ComboBox {
        id: nameFiltersComboBox
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumWidth: 300
        flat: true
        model: control.nameFilters
      }

      DialogButtonBox {
        id: buttonBox
        Layout.fillWidth: true
        Layout.fillHeight: true
        standardButtons: control.standardButtons
        padding: 0
        leftPadding: 12
      }
    }
  }

  Overlay.modal: Rectangle {
    color: Color.transparent(control.palette.shadow, 0.5)
  }

  Overlay.modeless: Rectangle {
    color: Color.transparent(control.palette.shadow, 0.12)
  }



  Dialog {
    id: overwriteConfirmationDialog
    objectName: "confirmationDialog"
    anchors.centerIn: parent

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    dim: true
    modal: true
    title: qsTr("Overwrite file?")
    width: control.width > 450 ? 450 : control.width - control.leftPadding - control.rightPadding
    height: control.height > 200 ? 200 : control.height - control.topPadding - control.bottomPadding
    clip: true

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
      implicitWidth: 900
      implicitHeight: 600
      radius: 5
      color: control.palette.active.mid

      layer.enabled: true
      layer.effect: ElevationEffect {
        elevation: 6
      }
    }

    header: Control {
      implicitHeight: contentItem.implicitHeight + topPadding + bottomPadding
      implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding

      horizontalPadding: 12
      verticalPadding: 6
      spacing: 0

      background: Rectangle {
        color: control.palette.active.button
        topLeftRadius: 5
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
        implicitHeight: 24
        spacing: 12
        alignment: Qt.AlignLeft
        color: control.palette.active.text
        text: overwriteConfirmationDialog.title
        font.pointSize: 20
        font.letterSpacing: 2.0
        icon.width: 36
        icon.height: 36
        icon.source: "qrc:/qt/qml/qt/qml/Sandbox/assets/warning-alt.svg"
      }
    }

    contentItem: Label {
      verticalAlignment: Text.AlignVCenter
      color: control.palette.active.text
      text: qsTr("“%1” already exists.\nDo you want to replace it?").arg(control.fileName)
      wrapMode: Text.WordWrap
      lineHeight: 1.5
    }

    footer: DialogButtonBox {
      alignment: Qt.AlignVCenter | Qt.AlignRight
      standardButtons: DialogButtonBox.Yes | DialogButtonBox.No

      delegate: Button {
        id: btn
        flat: true

        contentItem: IconLabel {
          id: iconAndLabel
          spacing: btn.spacing
          mirrored: btn.mirrored
          display: btn.display
          icon: btn.icon
          text: btn.text
          font: btn.font
          state: btn.state
          color: control.palette.active.text
          scale: btn.pressed ? 0.95 : 1
        }

        background: Rectangle {
          id: bgBase
          implicitWidth: 100
          implicitHeight: 32
          color: {
            if ( btn.hovered && !btn.down ) {
              return Qt.alpha( control.palette.active.midlight, 0.2 )
            } else if ( btn.hovered && btn.down ) {
              return Qt.alpha( control.palette.active.midlight, 0.3 )
            }

            return "transparent"
          }

          Rectangle {
            id: bgFocus
            anchors.centerIn: parent
            z: -1
            readonly property int margin: 6
            width: parent.width + margin
            height: parent.height + margin
            radius: ( parent as Rectangle )?.radius || 3
            color: "transparent"
            border.width: control.visualFocus ? 1 : 0
            border.color: control.palette.active.midlight
          }
        }
      }
    }

    T.Overlay.modal: Rectangle {
      color: Qt.alpha( control.palette.active.shadow, 0.98)
      Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    T.Overlay.modeless: Item {
      Behavior on opacity { NumberAnimation { duration: 150 } }
    }
  }
}

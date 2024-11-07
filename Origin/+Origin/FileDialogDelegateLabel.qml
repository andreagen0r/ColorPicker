import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Dialogs.quickimpl as DialogsQuickImpl
import Origin
/*
    Most of the elements in here are the same between styles, so we
    have a reusable component for it and provide some properties to enable style-specific tweaks.
*/
Item {
  id: root
  implicitWidth: column.implicitWidth
  implicitHeight: column.implicitHeight

  required property DialogsQuickImpl.FileDialogDelegate delegate
  required property int fileDetailRowWidth

  property color fileDetailRowTextColor

  RowLayout {
    id: column
    anchors.fill: parent
    spacing: root.delegate.spacing

    IconImage {
      id: iconImage
      Layout.fillHeight: true
      source: root.delegate.icon.source
      sourceSize: Qt.size(root.delegate.icon.width, root.delegate.icon.height)
      Layout.preferredWidth: root.delegate.icon.width
      color: root.delegate.icon.color
    }

    ColumnLayout {
      Layout.fillWidth: true
      Layout.fillHeight: true

      Label {
        Layout.fillWidth: true
        text: root.delegate.fileName
        font.pointSize: root.delegate.font.pointSize + 1
        renderTypeQuality: Text.HighRenderTypeQuality
        color: root.delegate.icon.color
        elide: Text.ElideMiddle
      }

      RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: root.delegate.spacing

        Label {
          Layout.fillWidth: true
          elide: Text.ElideMiddle
          text: {
            const path = root.delegate.fileUrl.toString()
            path.startsWith("file://",0) ? path.slice(7) : path
          }

          font.pixelSize: root.delegate.font.pixelSize * 0.75
          color: root.fileDetailRowTextColor
        }

        Label {

          text: {
            const fileSize = root.delegate.fileSize;
            return fileSize > Number.MAX_SAFE_INTEGER
                ? ('>' + locale.formattedDataSize(Number.MAX_SAFE_INTEGER))
                : locale.formattedDataSize(fileSize);
          }
          font.pixelSize: root.delegate.font.pixelSize * 0.75
          color: root.fileDetailRowTextColor
        }

        Label {
          text: Qt.formatDateTime(root.delegate.fileModified)
          font.pixelSize: root.delegate.font.pixelSize * 0.75
          color: root.fileDetailRowTextColor
          x: parent.width - width
        }
      }
    }
  }
}

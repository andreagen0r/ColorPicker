import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl

import Origin

T.Dialog {
  id: idControl

  property alias icon: idTitle.icon

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding,
                          implicitHeaderWidth,
                          implicitFooterWidth)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding
                           + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                           + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

  padding: OriginTheme.spacingMedium
  horizontalPadding: OriginTheme.spacingLarge
  spacing: OriginTheme.spacingLarge

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
    radius: OriginTheme.radiusMedium
    color: OriginTheme.surface

    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: OriginTheme.elevation
    }
  }

  header: Control {
    implicitHeight: contentItem.implicitHeight+ topPadding + bottomPadding
    implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding

    padding: idControl.padding
    horizontalPadding: idControl.horizontalPadding
    verticalPadding: idControl.verticalPadding
    spacing: idControl.spacing

    font {
      pointSize: 18
      capitalization: Font.AllUppercase
      letterSpacing: 2
    }

    background: Rectangle {
      color: OriginTheme.surfaceHighlight
      radius: OriginTheme.radiusMedium

      Rectangle {
        color: parent.color
        visible: parent.radius > 0
        width: parent.width
        height: parent.radius
        y: parent.height - height
      }

      Rectangle {
        height: 1
        color: OriginTheme.accent
        anchors {
          left: parent.left
          right: parent.right
          bottom: parent.bottom
        }
      }
    }

    contentItem: IconLabel {
      id: idTitle
      spacing: idControl.spacing
      display: AbstractButton.TextBesideIcon
      alignment: Qt.AlignLeft
      color: OriginTheme.foreground
      font {
        pointSize: 26
        letterSpacing: 4.0
      }
      implicitHeight: 24
      text: idControl.title
    }
  }

  footer: DialogButtonBox {
    visible: count > 0
  }

  T.Overlay.modal: Rectangle {
    color: OriginTheme.makeTransparent( OriginTheme.backgroundOverlay, 0.98)
    Behavior on opacity { NumberAnimation { duration: OriginTheme.speedSuperFast } }
  }

  T.Overlay.modeless: Rectangle {
    color: "transparent"
    Behavior on opacity { NumberAnimation { duration: OriginTheme.speedSuperFast } }
  }
}

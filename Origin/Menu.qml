import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import QtQuick.Window

import Origin

T.Menu {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  margins: 0
  verticalPadding: OriginTheme.spacingSmall
  horizontalPadding: OriginTheme.spacingSmall

  transformOrigin: !cascade ? Item.Top : (mirrored ? Item.TopRight : Item.TopLeft)

  delegate: MenuItem { }

  enter: Transition {
    // grow_fade_in
    NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: OriginTheme.speedFast }
    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: OriginTheme.speedSuperFast }
  }

  exit: Transition {
    // shrink_fade_out
    NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: OriginTheme.speedFast }
    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: OriginTheme.speedSuperFast }
  }

  contentItem: ListView {
    implicitHeight: contentHeight

    model: control.contentModel
    interactive: Window.window ? contentHeight > Window.window.height : false
    clip: true
    currentIndex: control.currentIndex

    ScrollIndicator.vertical: ScrollIndicator {}
  }

  background: Rectangle {
    implicitWidth: 200
    implicitHeight: OriginTheme.buttonHeight

    radius: OriginTheme.radiusSmall
    color: Qt.lighter( OriginTheme.surface, 1.2 )

    layer.enabled: true
    layer.effect: ElevationEffect {
      elevation: OriginTheme.elevation
    }
  }

  T.Overlay.modal: Rectangle {
    color: OriginTheme.backgroundOverlay
    Behavior on opacity { NumberAnimation { duration: OriginTheme.speedSuperFast } }
  }

  T.Overlay.modeless: Rectangle {
    color: OriginTheme.backgroundOverlay
    Behavior on opacity { NumberAnimation { duration: OriginTheme.speedSuperFast } }
  }
}

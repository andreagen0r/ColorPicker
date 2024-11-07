import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl as M

import Origin

T.ToolButton {
  id: idControl

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  spacing: display === AbstractButton.TextUnderIcon ? OriginTheme.spacingSmall : OriginTheme.spacingMedium
  verticalPadding: OriginTheme.spacingMedium
  horizontalPadding: OriginTheme.spacingLarge

  icon.width: 32
  icon.height: 32
  icon.color: !enabled ? OriginTheme.foregroundDisable
                       : checked && !flat ? "transparent"
                                          : checked && flat ? OriginTheme.accent
                                                            : idControl.pressed && !idControl.checkable && !idControl.highlighted ? OriginTheme.foregroundDarker
                                                                                                                                  : idControl.pressed && !idControl.checkable &&  idControl.highlighted ? OriginTheme.accent : OriginTheme.icon

  contentItem: IconLabel {
    spacing: idControl.spacing
    mirrored: idControl.mirrored
    display: idControl.display
    icon: idControl.icon
    text: idControl.text
    font: idControl.font
    color: !idControl.enabled ? OriginTheme.foregroundDisable
                              : idControl.pressed && !idControl.checkable && !idControl.highlighted ? OriginTheme.foregroundDarker
                                                                                                    : idControl.pressed && !idControl.checkable &&  idControl.highlighted ? OriginTheme.accent : OriginTheme.foreground
  }

  background: Rectangle {
    implicitWidth: 120
    implicitHeight: OriginTheme.buttonHeight
    color: idControl.checked || idControl.pressed ? OriginTheme.background : OriginTheme.surface

    M.Ripple {
      clip: true
      clipRadius: parent.radius
      width: parent.width
      height: parent.height
      pressed: idControl.pressed
      anchor: idControl
      active: idControl.down || idControl.visualFocus || idControl.hovered
      color: !idControl.enabled ? "transparent"
                                : idControl.flat && idControl.highlighted ? OriginTheme.makeTransparent(OriginTheme.foreground, 0.1)
                                                                          : OriginTheme.makeTransparent(OriginTheme.foreground, 0.1)
    }

    Rectangle {
      width: idControl.checked ? parent.width : 0
      x: idControl.checked ? 0 : parent.width / 2
      height: 2
      anchors.bottom: parent.bottom
      color: OriginTheme.accent
      opacity: idControl.checked ? 1.0 : 0

      Behavior on width {
        NumberAnimation {duration: OriginTheme.speedSuperFast; easing.type: Easing.OutQuad  }
      }

      Behavior on x {
        NumberAnimation {duration: OriginTheme.speedSuperFast; easing.type: Easing.OutQuad }
      }

      Behavior on opacity {
        NumberAnimation {duration: OriginTheme.speedSuperFast; easing.type: Easing.OutQuad }
      }
    }
  }
}

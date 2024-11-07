import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import Origin

T.Button {
  id: id_Control

  property int elevation: down ? 0 : 4


  implicitWidth: Math.max( implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding )
  implicitHeight: Math.max( implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding )

  topInset: OriginTheme.spacingSmall
  bottomInset: OriginTheme.spacingSmall
  padding: OriginTheme.spacingSmall + 1
  horizontalPadding: OriginTheme.spacingMedium
  spacing: OriginTheme.spacingSmall

  icon.width: 24
  icon.height: 24
  icon.color: !enabled ? OriginTheme.foregroundDisable
                       : pressed ? OriginTheme.accent
                                 : highlighted ? OriginTheme.background
                                               : checked ? OriginTheme.accent : OriginTheme.foreground

  state: {
    if ( enabled ) {

      if ( flat && highlighted && checkable) {
        return "flat_highlighted_checkable"
      }

      if ( flat && checkable) {
        return "flat_checkable"
      }

      if ( flat && highlighted ) {
        return "flat_highlighted"
      }

      if ( flat /*&& !checkable && !highlighted */ ) {
        return "flat"
      }

      if ( highlighted ) {
        return "highlighted"
      }

      if ( checked ) {
        return "checked"
      }

      return ""

    } else {

      if ( flat ) {
        return "disable_flat"
      }

      return "disable"
    }

  }

  states: [

    State {
      name: "flat_highlighted_checkable"
      PropertyChanges { target: idbg; color: id_Control.checked ? OriginTheme.buttonChecked : "transparent"; border.width: id_Control.checked ? 0 : 1; border.color: OriginTheme.accent }
      PropertyChanges { target: iconLabelId; color: id_Control.checked ? OriginTheme.foreground : OriginTheme.accent }
    },

    State {
      name: "flat_checkable"
      PropertyChanges { target: idbg; color: id_Control.checked ? OriginTheme.buttonChecked : id_Control.hovered ? Qt.lighter(OriginTheme.surface, 1.2) : "transparent" }
    },

    State {
      name: "flat_highlighted"
      PropertyChanges { target: idbg; color: id_Control.hovered ? OriginTheme.surfaceBackground : "transparent"; border.width: 1; border.color: OriginTheme.accent }
      PropertyChanges { target: iconLabelId; color: OriginTheme.accent }
    },

    State {
      name: "flat"
      PropertyChanges { target: idbg; color: id_Control.hovered ? Qt.lighter(OriginTheme.surface, 1.2) : "transparent" }
    },

    State {
      name: "highlighted"
      PropertyChanges { target: idbg; color: id_Control.hovered ? Qt.lighter(OriginTheme.accent, 1.2) : OriginTheme.accent }
      PropertyChanges { target: iconLabelId; color: OriginTheme.foregroundInvertedContrasted }
    },

    State {
      name: "checked"
      PropertyChanges { target: idbg; color: id_Control.checked ? OriginTheme.buttonChecked : OriginTheme.button }
    },

    State {
      name: "disable"
      PropertyChanges { target: idbg; color: "transparent"; border.width: 1; border.color: OriginTheme.foregroundDisable }
      PropertyChanges { target: iconLabelId; color: OriginTheme.foregroundDisable }
      // PropertyChanges { target: rpl; color: "transparent"}
    },

    State {
      name: "disable_flat"
      PropertyChanges { target: idbg; color: "transparent"; border.width: 0 }
      PropertyChanges { target: iconLabelId; color: OriginTheme.foregroundDisable }
      // PropertyChanges { target: rpl; color: "transparent"}
    }
  ]

  contentItem: IconLabel {
    id: iconLabelId
    spacing: id_Control.spacing
    mirrored: id_Control.mirrored
    display: id_Control.display
    icon: id_Control.icon
    text: id_Control.text
    font: id_Control.font
    state: id_Control.state
    color:  OriginTheme.icon
    scale: pressed ? 0.95 : 1
  }

  background: Rectangle {
    id: idbg
    implicitWidth: 120
    implicitHeight: OriginTheme.buttonHeight
    radius: OriginTheme.radiusSmall
    border.width: 0
    border.color: Qt.lighter(OriginTheme.button, 1.2)
    color: id_Control.hovered ? Qt.lighter(OriginTheme.button, 1.2) : OriginTheme.button

    // scale: pressed ? 0.95 : 1
    Behavior on scale { NumberAnimation{ duration: OriginTheme.speedSuperFast } }

    state: id_Control.state

    layer.enabled: id_Control.enabled && !id_Control.checked && !id_Control.flat && id_Control.elevation > 0
    layer.effect: ElevationEffect {
      elevation: id_Control.elevation
    }

    Ripple {
      id: rpl
      clip: true
      clipRadius: parent.radius
      Material.theme: Material.Dark
      Material.accent: OriginTheme.accent

      width: parent.width
      height: parent.height
      pressed: id_Control.pressed
      anchor: id_Control
      active: ( id_Control.down || id_Control.visualFocus || ( id_Control.hovered && id_Control.enabled ) ) && !id_Control.checkable
      color: OriginTheme.makeTransparent( Qt.lighter( OriginTheme.button, 1.5), 0.2)
    }

    Rectangle {
      visible: id_Control.checkable
      width: id_Control.checked ? parent.width : 0
      x: id_Control.checked ? 0 : parent.width / 2
      height: 2
      anchors.bottom: parent.bottom
      color: id_Control.enabled ? OriginTheme.accent : OriginTheme.surfaceBackground
      opacity: id_Control.checked ? 1.0 : 0

      Behavior on width {
        NumberAnimation { duration: OriginTheme.speedFast; easing.type: Easing.OutQuad }
      }

      Behavior on x {
        NumberAnimation { duration: OriginTheme.speedFast; easing.type: Easing.OutQuad }
      }

      Behavior on opacity {
        NumberAnimation { duration: OriginTheme.speedFast; easing.type: Easing.OutQuad }
      }
    }
  }
}

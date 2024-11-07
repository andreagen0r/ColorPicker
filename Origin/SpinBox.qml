import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import Origin

T.SpinBox {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentItem.implicitWidth +
                          up.implicitIndicatorWidth +
                          down.implicitIndicatorWidth)
  implicitHeight: Math.max(implicitContentHeight + topPadding + bottomPadding,
                           implicitBackgroundHeight,
                           up.implicitIndicatorHeight,
                           down.implicitIndicatorHeight)

  spacing: OriginTheme.spacingSmall
  topPadding: OriginTheme.spacingSmall
  bottomPadding: OriginTheme.spacingSmall
  leftPadding: (control.mirrored ? (up.indicator ? up.indicator.width : 0) : (down.indicator ? down.indicator.width : 0))
  rightPadding: (control.mirrored ? (down.indicator ? down.indicator.width : 0) : (up.indicator ? up.indicator.width : 0))

  validator: IntValidator {
    locale: control.locale.name
    bottom: Math.min(control.from, control.to)
    top: Math.max(control.from, control.to)
  }

  contentItem: TextInput {
    text: control.displayText

    font: control.font
    color: enabled ? OriginTheme.foreground : OriginTheme.foregroundDisable
    selectionColor: OriginTheme.accent
    selectedTextColor: OriginTheme.foregroundInvertedContrasted
    horizontalAlignment: Qt.AlignHCenter
    verticalAlignment: Qt.AlignVCenter

    cursorDelegate: CursorDelegate { }

    readOnly: !control.editable
    validator: control.validator
    inputMethodHints: control.inputMethodHints
  }

  up.indicator: Item {
    x: control.mirrored ? 0 : parent.width - width
    implicitWidth: 32
    implicitHeight: 32
    height: parent.height
    width: height

    Ripple {
      clipRadius: 2
      x: control.spacing
      y: control.spacing
      width: parent.width - 2 * control.spacing
      height: parent.height - 2 * control.spacing
      pressed: control.up.pressed
      active: control.up.pressed || control.up.hovered || control.visualFocus
      color: OriginTheme.makeTransparent(OriginTheme.surfaceBackground, 0.1)
    }

    Rectangle {
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      width: Math.min(parent.width / 3, parent.height / 3)
      height: 2
      color: !enabled ? OriginTheme.foregroundDisable
                      : control.up.pressed ? OriginTheme.accent : OriginTheme.foreground
    }

    Rectangle {
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      width: 2
      height: Math.min(parent.width / 3, parent.height / 3)
      color: !enabled ? OriginTheme.foregroundDisable
                      : control.up.pressed ? OriginTheme.accent : OriginTheme.foreground
    }
  }

  down.indicator: Item {
    x: control.mirrored ? parent.width - width : 0
    implicitWidth: control.Material.touchTarget
    implicitHeight: control.Material.touchTarget
    height: parent.height
    width: height

    Ripple {
      clipRadius: 2
      x: control.spacing
      y: control.spacing
      width: parent.width - 2 * control.spacing
      height: parent.height - 2 * control.spacing
      pressed: control.down.pressed
      active: control.down.pressed || control.down.hovered || control.visualFocus
      color: OriginTheme.makeTransparent(OriginTheme.surfaceBackground, 0.1)
    }

    Rectangle {
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      width: parent.width / 3
      height: 2
      color: !enabled ? OriginTheme.foregroundDisable
                      : control.down.pressed ? OriginTheme.accent : OriginTheme.foreground
    }
  }

  background: Item {
    implicitWidth: 160
    implicitHeight: control.Material.touchTarget

    Rectangle {
      x: parent.width / 2 - width / 2
      y: parent.y + parent.height - height - control.bottomPadding / 2
      width: control.availableWidth
      height: /*control.activeFocus ? 2 :*/ 1
      color: !control.enabled ? OriginTheme.foregroundDisable
                              : control.activeFocus ? OriginTheme.accent : OriginTheme.surfaceBackground
    }
  }
}

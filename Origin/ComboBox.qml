pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QtQuick.Controls.Material.impl

import Origin

T.ComboBox {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding,
                           implicitIndicatorHeight + topPadding + bottomPadding)

  topInset: OriginTheme.spacingSmall
  bottomInset: OriginTheme.spacingSmall

  leftPadding: padding + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
  rightPadding: padding + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)

  delegate: MenuItem {
    required property var model
    required property int index

    width: ListView.view.width
    text: model[control.textRole]
    highlighted: control.highlightedIndex === index
    hoverEnabled: control.hoverEnabled
  }

  indicator: ColorImage {
    x: control.mirrored ? control.padding : control.width - width - control.padding
    y: control.topPadding + (control.availableHeight - height) / 2
    color: !control.enabled ? OriginTheme.foregroundDisable : OriginTheme.foreground
    source: "qrc:/qt/qml/qt/qml/Origin/Icons/caret-down.svg"
  }

  contentItem: T.TextField {
    padding: 6
    leftPadding: control.editable ? 2 : control.mirrored ? 0 : 12
    rightPadding: control.editable ? 2 : control.mirrored ? 12 : 0

    text: control.editable ? control.editText : control.displayText

    enabled: control.editable
    autoScroll: control.editable
    readOnly: control.down
    inputMethodHints: control.inputMethodHints
    validator: control.validator

    font: control.font
    color: !control.enabled ? OriginTheme.foregroundDisable : OriginTheme.foreground
    selectionColor: OriginTheme.accent
    selectedTextColor: OriginTheme.foregroundInvertedContrasted
    verticalAlignment: Text.AlignVCenter

    cursorDelegate: CursorDelegate { }
  }

  background: Rectangle {
    implicitWidth: 120
    implicitHeight: OriginTheme.buttonHeight

    radius: control.flat ? 0 : OriginTheme.radiusSmall
    color: control.editable || control.flat ?  "transparent" : OriginTheme.button
    border.color: control.flat ? OriginTheme.button : "transparent"

    layer.enabled: control.enabled && !control.editable && !control.flat
    layer.effect: ElevationEffect {
      elevation: control.flat ? control.pressed || control.hovered ? 2 : 0
      : control.pressed ? 8 : 2
    }

    Rectangle {
      visible: control.editable
      y: parent.y + control.baselineOffset
      width: parent.width
      height: control.activeFocus ? 1 : 1
      color: !control.editable ? OriginTheme.foregroundDisable
                               : control.activeFocus ? OriginTheme.accent : OriginTheme.surfaceBackground
    }

    Ripple {
      clip: control.flat
      clipRadius: control.flat ? 0 : 2
      x: control.editable && control.indicator ? control.indicator.x : 0
      width: control.editable && control.indicator ? control.indicator.width : parent.width
      height: parent.height
      pressed: control.pressed
      anchor: control.editable && control.indicator ? control.indicator : control
      active: control.pressed || control.visualFocus || control.hovered
      color: OriginTheme.makeTransparent(OriginTheme.foreground, 0.1)
    }
  }

  popup: T.Popup {
    y: control.editable ? control.height - 5 : 0
    width: control.width
    height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
    transformOrigin: Item.Top
    topMargin: OriginTheme.spacingMedium
    bottomMargin: OriginTheme.spacingMedium

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
      clip: true
      implicitHeight: contentHeight
      model: control.delegateModel
      currentIndex: control.highlightedIndex
      highlightMoveDuration: 0

      T.ScrollIndicator.vertical: ScrollIndicator { }
    }

    background: Rectangle {
      radius: 2
      color: Qt.lighter( OriginTheme.surface, 1.2 )

      layer.enabled: control.enabled
      layer.effect: ElevationEffect {
        elevation: 8
      }
    }
  }
}

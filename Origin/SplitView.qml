import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl

import Origin

T.SplitView {
  id: control
  implicitWidth: Math.max( implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding )
  implicitHeight: Math.max( implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding )

  handle: Rectangle {
    readonly property int handleThickness: 7

    implicitWidth: control.orientation === Qt.Horizontal ? handleThickness : control.width
    implicitHeight: control.orientation === Qt.Horizontal ? control.height : handleThickness
    color: T.SplitHandle.pressed ? Qt.lighter( OriginTheme.surface, T.SplitHandle.hovered ? 1.2 : 1.1 ) : OriginTheme.surface

    Rectangle {

      property int length: parent.T.SplitHandle.pressed ? 3 : 16
      readonly property int thickness: parent.T.SplitHandle.pressed ? 3 : 1

      color: parent.T.SplitHandle.hovered ? OriginTheme.accent : OriginTheme.foreground
      width: control.orientation === Qt.Horizontal ? thickness : length
      height: control.orientation === Qt.Horizontal ? length : thickness
      radius: thickness
      x: ( parent.width - width ) / 2
      y: ( parent.height - height ) / 2

      Behavior on length {
        NumberAnimation { duration: 100 }
      }
    }
  }
}

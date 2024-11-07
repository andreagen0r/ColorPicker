import QtQuick
import QtQuick.Templates as T

import Origin

T.SwipeView {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  contentItem: ListView {
    id: listView
    model: control.contentModel
    interactive: control.interactive
    currentIndex: control.currentIndex
    focus: control.focus

    spacing: control.spacing
    orientation: control.orientation
    snapMode: ListView.SnapOneItem
    boundsBehavior: Flickable.StopAtBounds

    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: 0
    preferredHighlightEnd: 0
    highlightMoveDuration: OriginTheme.speedFast
    maximumFlickVelocity: 4 * (control.orientation === Qt.Horizontal ? width : height)
  }
}

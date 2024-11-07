pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T

import Origin

T.TabBar {
  id: idControl

  implicitWidth: contentWidth + leftPadding + rightPadding
  implicitHeight: contentHeight + topPadding + bottomPadding

  spacing: OriginTheme.spacingDivider

  contentItem: ListView {
    model: idControl.contentModel
    currentIndex: idControl.currentIndex
    clip: true

    spacing: idControl.spacing
    orientation: ListView.Horizontal
    boundsBehavior: Flickable.StopAtBounds
    flickableDirection: Flickable.AutoFlickIfNeeded
    snapMode: ListView.SnapToItem

    highlightMoveDuration: OriginTheme.speedFast
    highlightResizeDuration: 0
    highlightFollowsCurrentItem: true
    highlightRangeMode: ListView.ApplyRange
    preferredHighlightBegin: 48
    preferredHighlightEnd: width - 48

    highlight: Item {
      z: 2
      Rectangle {
        id: idHighlight
        height: 2
        width: parent.width
        y: idControl.position === T.TabBar.Footer ? 0 : parent.height - height
        color: OriginTheme.accent
      }
    }
  }

  background: Rectangle {
    color: OriginTheme.background
  }
}

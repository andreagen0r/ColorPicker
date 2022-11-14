import QtQuick
import QtQuick.Controls

import ColorTools

Item {
  id: root

  property alias primary: internal.primary
  property alias secondary: internal.secondary
  property alias currentColor: internal.currentColor
  readonly property bool primaryFirstPlane: primarySampler.z > secondarySampler.z

  signal primaryClicked
  signal secondaryClicked
  signal primaryDoubleClicked
  signal secondaryDoubleClicked

  ColorTool_p {
    id: internal
  }

  Item {
    anchors.top: primarySampler.bottom
    anchors.bottom: secondarySampler.bottom
    anchors.left: primarySampler.left
    anchors.right: secondarySampler.left
    anchors.margins: 6
    width: root.width / 2
    height: width

    Rectangle {
      anchors.centerIn: parent
      width: parent.width / 1.5
      height: width
      color: "white"
    }

    Rectangle {
      width: parent.width / 1.5
      height: width
      color: "black"
    }

    MouseArea {
      anchors.fill: parent
      onClicked: internal.reset()
    }
  }

  Item {
    anchors.top: primarySampler.top
    anchors.bottom: secondarySampler.top
    anchors.left: primarySampler.right
    anchors.right: secondarySampler.right
    anchors.margins: 6
    width: root.width / 2
    height: width

    IconLabel {
      id: swapButton
      anchors.fill: parent
      color: "white"
      icon.source: "assets/swap.svg"
      scale: swapColorMouse.pressed ? 0.9 : 1
    }

    MouseArea {
      id: swapColorMouse
      anchors.fill: parent
      onClicked: internal.swap()
    }
  }

  ColorSampler {
    id: secondarySampler

    anchors.right: root.right
    anchors.bottom: root.bottom
    radius: 3
    width: root.width / 1.5
    height: width
    z: internal.swapSwatch ? 1 : 0
    color: internal.secondary

    onColorChanged: internal.setSecondary(secondarySampler.color)
    onDoubleClicked: root.secondaryDoubleClicked()
    onClicked: {
      if (secondarySampler.z < 1) {
        internal.swapSwatchPlane()
      }
      internal.setCurrentColor(secondarySampler.color)
      root.secondaryClicked()
    }
  }

  ColorSampler {
    id: primarySampler
    width: root.width / 1.5
    radius: 3
    height: width
    z: internal.swapSwatch ? 0 : 1
    color: internal.primary

    onColorChanged: internal.setPrimary(primarySampler.color)
    onDoubleClicked: root.primaryDoubleClicked()
    onClicked: {
      if (primarySampler.z < 1) {
        internal.swapSwatchPlane()
      }
      internal.setCurrentColor(primarySampler.color)
      root.primaryClicked()
    }
  }
}

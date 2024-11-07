import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import Origin

T.MenuItem {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: OriginTheme.spacingMedium
    verticalPadding: OriginTheme.spacingMedium
    spacing: OriginTheme.spacingMedium

    icon.width: 24
    icon.height: 24
    icon.color: !enabled ? OriginTheme.foregroundDisable
                        : highlighted || hovered ? OriginTheme.foregroundInvertedContrasted
                        : OriginTheme.icon

    indicator: CheckIndicator {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.checkable
        control: control
        checkState: control.checked ? Qt.Checked : Qt.Unchecked
    }

    arrow: ColorImage {
        x: control.mirrored ? control.padding : control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.subMenu
        mirror: control.mirrored
        color: !control.enabled ? OriginTheme.foregroundDisable
                                : control.highlighted ? OriginTheme.foregroundInvertedContrasted
                                : OriginTheme.foreground
        source: "qrc:/qt/qml/Origin/Icons/caret-right.svg"
    }

    contentItem: IconLabel {
        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
        leftPadding: !control.mirrored ? indicatorPadding : arrowPadding
        rightPadding: control.mirrored ? indicatorPadding : arrowPadding

        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: Qt.AlignLeft

        icon: control.icon
        text: control.text
        font: control.font
        color: !control.enabled ? OriginTheme.foregroundDisable
                                : control.highlighted ? OriginTheme.foregroundInvertedContrasted
                                : OriginTheme.foreground
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: OriginTheme.buttonHeight
        color:  control.highlighted ? OriginTheme.accent : "transparent"

        Ripple {
            width: parent.width
            height: parent.height

            clip: visible
            pressed: control.pressed
            anchor: control
            active: control.enabled && ( control.down || control.highlighted )
            color: OriginTheme.makeTransparent( Qt.lighter( OriginTheme.accent, 1.5 ), 0.1 )
        }
    }
}

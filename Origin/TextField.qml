import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl

import Origin

// TODO: Revisar completamente

T.TextField {
    id: control

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    leftPadding: OriginTheme.spacingMedium
    rightPadding: OriginTheme.spacingMedium
    topPadding: OriginTheme.spacingSmall
    bottomPadding: OriginTheme.spacingSmall

    color: enabled ? OriginTheme.foreground : OriginTheme.foregroundDisable
    selectionColor: OriginTheme.accent
    selectedTextColor: OriginTheme.background
    placeholderTextColor: OriginTheme.foregroundDisable
    verticalAlignment: TextInput.AlignVCenter

    cursorDelegate: CursorDelegate {}

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        elide: Text.ElideRight
        renderType: control.renderType
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 32
        color: OriginTheme.surfaceBackground

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            visible: control.visible && control.activeFocus
            height: 2
            color: OriginTheme.accent
        }
    }
}

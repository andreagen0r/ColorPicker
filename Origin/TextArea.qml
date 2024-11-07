import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl

import Origin

// TODO: Revisar completamente

T.TextArea {
    id: control

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset,
                             placeholder.implicitHeight + 1 + topPadding + bottomPadding)

    padding: OriginTheme.spacingMedium

    color: enabled ? OriginTheme.foreground : OriginTheme.foregroundDisable
    selectionColor: OriginTheme.accent
    selectedTextColor: OriginTheme.foregroundInvertedContrasted
    placeholderTextColor: OriginTheme.foregroundPlaceHolder
    cursorDelegate: CursorDelegate { }

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
        color: OriginTheme.surfaceBackground

        Rectangle {
            width: parent.width
            anchors.bottom: parent.bottom
            height:  1
            color: control.enabled && control.activeFocus ? OriginTheme.accent : "transparent"
        }
    }
}

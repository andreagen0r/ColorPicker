import QtQuick
import QtQuick.Templates as T

import Origin

T.ToolBar {
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)

  spacing: 1

  background: Rectangle {
    implicitHeight: 48
    color: OriginTheme.surfaceBackground

    // TODO Fazer plugin com attached property para a sombra (elevation)

    //        layer.enabled: control.OriginTheme.elevation > 0
    //        layer.effect: ElevationEffect {
    //            elevation: control.OriginTheme.elevation
    //            fullWidth: true
    //        }
  }
}

pragma Singleton

import QtQuick

QtObject {
  readonly property color gray_01: "#19191F"
  readonly property color gray_02: "#222229"
  readonly property color gray_03: "#2E2E33"
  readonly property color gray_04: "#48484D"
  readonly property color gray_05: "#696970"
  readonly property color gray_06: "#818188"
  readonly property color gray_07: "#9B9BA1"
  readonly property color gray_08: "#B5B5B9"
  readonly property color gray_09: "#CACACC"
  readonly property color gray_10: "#DEDEE0"
  readonly property color gray_11: "#EBEBED"
  readonly property color gray_12: "#F5F5F5"

  readonly property color primary_01: "#43331F"
  readonly property color primary_02: "#705634"
  readonly property color primary_03: "#9D7849"
  readonly property color primary_04: "#CB9B5E"
  readonly property color primary_05: "#D6B181"
  readonly property color primary_06: "#E2C7A5"
  readonly property color primary_07: "#EDDDC9"

  // Accents
  readonly property color blue_01: "#1D303D"
  readonly property color blue_02: "#184461"
  readonly property color blue_03: "#1B5D89"
  readonly property color blue_04: "#207BB7"
  readonly property color blue_05: "#3097DB"
  readonly property color blue_06: "#64B0E3"
  readonly property color blue_07: "#9FD9FF"
  readonly property color blue_08: "#BBE4FF"
  readonly property color blue_09: "#E7F3FB"

  readonly property color green_01: "#2B3D1D"
  readonly property color green_02: "#386118"
  readonly property color green_03: "#4B891B"
  readonly property color green_04: "#61B720"
  readonly property color green_05: "#7ADB30"
  readonly property color green_06: "#9BE364"
  readonly property color green_07: "#C9FF9F"
  readonly property color green_08: "#D8FFBB"
  readonly property color green_09: "#F0FBE7"

  readonly property color yellow_01: "#3D301D"
  readonly property color yellow_02: "#614418"
  readonly property color yellow_03: "#895D1B"
  readonly property color yellow_04: "#B77B20"
  readonly property color yellow_05: "#DB9730"
  readonly property color yellow_06: "#E3B064"
  readonly property color yellow_07: "#FFD99F"
  readonly property color yellow_08: "#FFE4BB"
  readonly property color yellow_09: "#FBF3E7"

  readonly property color purple_01: "#2A1D3D"
  readonly property color purple_02: "#351861"
  readonly property color purple_03: "#471B89"
  readonly property color purple_04: "#5C20B7"
  readonly property color purple_05: "#7430DB"
  readonly property color purple_06: "#9764E3"
  readonly property color purple_07: "#C59FFF"
  readonly property color purple_08: "#D6BBFF"
  readonly property color purple_09: "#EFE7FB"

  readonly property color red_01: "#3D1D1D"
  readonly property color red_02: "#611818"
  readonly property color red_03: "#891B1B"
  readonly property color red_04: "#B72020"
  readonly property color red_05: "#DB3030"
  readonly property color red_06: "#E36464"
  readonly property color red_07: "#FF9F9F"
  readonly property color red_08: "#FFBBBB"
  readonly property color red_09: "#FBE7E7"


  // Layout Colors
  function makeTransparent( color : color, alphaPercent : real ) : color {
    return Qt.rgba(color.r, color.g, color.b, alphaPercent);
  }

  readonly property color accent: primary_04

  readonly property color background: gray_01
  readonly property color backgroundOverlay: gray_01

  readonly property color surface: gray_03
  readonly property color surfaceBackground: gray_02
  readonly property color surfaceBackgroundDisable: gray_04
  readonly property color surfaceDarker: gray_02
  readonly property color surfaceHighlight: gray_04

  readonly property color foreground: gray_08
  readonly property color foregroundHighlight: gray_12
  readonly property color foregroundDarker: gray_07
  readonly property color foregroundPlaceHolder: gray_05
  readonly property color foregroundInvertedContrasted: gray_01
  readonly property color foregroundInverted: gray_04
  readonly property color foregroundDisable: gray_04

  readonly property color icon: gray_08
  readonly property color iconPlaceHolder: gray_06

  readonly property color highlight: primary_04

  readonly property color button: gray_04
  readonly property color buttonChecked: gray_02
  readonly property color buttonHighlighted: gray_05
  readonly property color buttonDisable: gray_02

  readonly property color divider: gray_01

  readonly property color success: "#6CA83F"
  readonly property color successBackground: green_01
  readonly property color successForeground: green_08
  readonly property color successIcon: green_05

  readonly property color warning: "#E49D32"
  readonly property color warningBackground: yellow_01
  readonly property color warningForeground: yellow_08
  readonly property color warningIcon: yellow_05

  readonly property color info: "#3BBECC"
  readonly property color infoBackground: blue_01
  readonly property color infoForeground: blue_08
  readonly property color infoIcon: blue_05

  readonly property color danger: "#B82C2C"
  readonly property color dangerBackground: red_01
  readonly property color dangerForeground: red_08
  readonly property color dangerIcon: red_05

  // Spacing
  readonly property real spacingDivider: 1.0
  readonly property real spacingExtraSmall: 2.0
  readonly property real spacingSmall: 6.0
  readonly property real spacingMedium: 12.0
  readonly property real spacingLarge: 24.0
  readonly property real spacingExtraLarge: 48.0

  // Radius
  readonly property real radiusSmall: 2.0
  readonly property real radiusMedium: 4.0
  readonly property real radiusLarge: 8.0
  readonly property real radiusExtraLarge: 16.0

  readonly property real elevation: 12

  readonly property int speedSuperSlow: 1000
  readonly property int speedSlow: 500
  readonly property int speedMedium: 350
  readonly property int speedFast: 250
  readonly property int speedSuperFast: 150

  readonly property int buttonHeight: 36
}

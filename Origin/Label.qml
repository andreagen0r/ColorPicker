import QtQuick.Templates as T

import Origin

T.Label {
  linkColor: OriginTheme.accent
  color: enabled ? OriginTheme.foreground : OriginTheme.foregroundDisable
}

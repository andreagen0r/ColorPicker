pragma Singleton

import QtQuick

Item {

    readonly property font font : body

    readonly property font largeText:   Qt.font( { pointSize: 26,  letterSpacing: 4.0 } )
    readonly property font title1:      Qt.font( { pointSize: 22,  letterSpacing: 4.0 } )
    readonly property font title2:      Qt.font( { pointSize: 18,  letterSpacing: 2.0 } )
    readonly property font title3:      Qt.font( { pointSize: 15,  letterSpacing: 1.5 } )
    readonly property font headline:    Qt.font( { pointSize: 13,  letterSpacing: 1.8 } )
    readonly property font subheadline: Qt.font( { pointSize: 12,  letterSpacing: 1.2 } )
    readonly property font body:        Qt.font( { pointSize: 11,  letterSpacing: 1.0 } )
    readonly property font callout:     Qt.font( { pointSize: 10,  letterSpacing: 1.2 } )
    readonly property font footnote:    Qt.font( { pointSize: 09,  letterSpacing: 1.8 } )
    readonly property font caption1:    Qt.font( { pointSize: 09,  letterSpacing: 1.8 } )
    readonly property font caption2:    Qt.font( { pointSize: 08,  letterSpacing: 1.8 } )
}

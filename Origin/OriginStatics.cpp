#include <QtCore/private/qfileselector_p.h>

namespace {
// deliberate use of anonymous namespace

class OriginStatics
{
    // This class inserts a file selector static value at compile time.
    // Using file selectors in Qt Quick Controls styles is not normally necessary as it
    // is only used for run-time style selection which we are not using.
    // However Qt 6.5.3 QtQuick.Dialogs still does, so this is a temporary workaround
    // for the QtQuick.Dialogs' Non-Native fallback implementation being otherwise publicly unreachable.
    // We note that that this class iniitialises once for STATIC builds but twice for SHARED builds
    // but this has no behavioural consequence, only setting a duplicated static value in the file selector.

public:
    explicit OriginStatics(QObject *parent = nullptr) {
        using namespace Qt::StringLiterals;
        // this will be added on linking, without needing to import any plugins
        // and will take precedence over any statics a plugin might add
        QFileSelectorPrivate::addStatics(QStringList() << "Origin"_L1);
        // qDebug() << "Origin: adding static file selector"_L1 << this;
    }
} autoInitialiseCustomStyleStatics;
}

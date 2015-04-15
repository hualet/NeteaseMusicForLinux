TEMPLATE = app

QT += qml quick sql

SOURCES += src/main.cpp \
    src/netease_api/neteaseapi.cpp \
    src/appcontroller.cpp \
    src/song.cpp \
    src/playlist_model.cpp \
    src/htsettings.cpp \
    src/database.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/netease_api/neteaseapi.h \
    src/appcontroller.h \
    src/song.h \
    src/playlist_model.h \
    src/htsettings.h \
    src/database.h


unix {
    icon32.files = icons/32x32/NeteaseMusicForLinux.png
    icon32.path = /usr/share/icons/hicolor/32x32/apps
    icon64.files = icons/64x64/NeteaseMusicForLinux.png
    icon64.path = /usr/share/icons/hicolor/64x64/apps
    icon128.files = icons/128x128/NeteaseMusicForLinux.png
    icon128.path = /usr/share/icons/hicolor/128x128/apps
    icon256.files = icons/256x256/NeteaseMusicForLinux.png
    icon256.path = /usr/share/icons/hicolor/256x256/apps
}

target.path = /usr/bin/

desktop.files = NeteaseMusicForLinux.desktop
desktop.path = /usr/share/applications

INSTALLS += desktop \
    icon32 \
    icon64 \
    icon128 \
    icon256


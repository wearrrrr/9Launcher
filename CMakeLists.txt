cmake_minimum_required(VERSION 3.16)

project(nineLauncher VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(NineLauncher
    src/main.cpp
)

qt_add_qml_module(NineLauncher
    URI nineLauncher
    VERSION 1.0
    RESOURCE_PREFIX /
    QML_FILES
        src/Main.qml
        src/GameItem.qml
        src/Footer.qml
        src/Setting.qml
        src/fs.js
        src/main.js
        src/footer.js
        RESOURCES src/json/games.json
        RESOURCES src/game-images/th01.png src/game-images/th01_unset.png src/game-images/th02.png src/game-images/th02_unset.png src/game-images/th03.png src/game-images/th03_unset.png src/game-images/th04.png src/game-images/th04_unset.png src/game-images/th05.png src/game-images/th05_unset.png src/game-images/th06.png src/game-images/th06_unset.png src/game-images/th07.png src/game-images/th07_5.png src/game-images/th07_5_unset.png src/game-images/th07_unset.png src/game-images/th08.png src/game-images/th08_unset.png src/game-images/th09.png src/game-images/th09_5.png src/game-images/th09_5_unset.png src/game-images/th09_unset.png src/game-images/th10.png src/game-images/th10_5.png src/game-images/th10_5_unset.png src/game-images/th10_unset.png src/game-images/th11.png src/game-images/th11_unset.png src/game-images/th12.png src/game-images/th12_3.png src/game-images/th12_3_unset.png src/game-images/th12_5.png src/game-images/th12_5_unset.png src/game-images/th12_8.png src/game-images/th12_8_unset.png src/game-images/th12_unset.png src/game-images/th13.png src/game-images/th13_5.png src/game-images/th13_5_unset.png src/game-images/th13_unset.png src/game-images/th14.png src/game-images/th14_3.png src/game-images/th14_3_unset.png src/game-images/th14_5.png src/game-images/th14_5_unset.png src/game-images/th14_unset.png src/game-images/th15.png src/game-images/th15_5.png src/game-images/th15_5_unset.png src/game-images/th15_unset.png src/game-images/th16.png src/game-images/th16_5.png src/game-images/th16_5_unset.png src/game-images/th16_unset.png src/game-images/th17.png src/game-images/th17_unset.png src/game-images/th18.png src/game-images/th18_5.png src/game-images/th18_5_unset.png src/game-images/th18_unset.png src/game-images/th19.png src/game-images/th19_unset.png
        SOURCES src/FileIO.h
        SOURCES src/FileIO.cpp
        SOURCES src/GameLauncher.h
        SOURCES src/GameLauncher.cpp
        SOURCES src/AppSettings.h
)

add_subdirectory(src/MMaterial)

target_link_libraries(NineLauncher
    PRIVATE Qt6::Quick Qt::Gui MMaterialLibplugin
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(NineLauncher PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(NineLauncher
    PRIVATE Qt6::Quick
)
target_link_libraries(NineLauncher
    PRIVATE Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS NineLauncher
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

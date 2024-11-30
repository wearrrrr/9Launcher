cmake_minimum_required(VERSION 3.16)

project(nineLauncher-v2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appNineLauncher-v2
    main.cpp
)

qt_add_qml_module(appNineLauncher-v2
    URI nineLauncher-v2
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES fs.js
        QML_FILES json/games.json
        QML_FILES GameItem.qml
        RESOURCES game-images/th01.png game-images/th01_unset.png game-images/th02.png game-images/th02_unset.png game-images/th03.png game-images/th03_unset.png game-images/th04.png game-images/th04_unset.png game-images/th05.png game-images/th05_unset.png game-images/th06.png game-images/th06_unset.png game-images/th07.png game-images/th07_5.png game-images/th07_5_unset.png game-images/th07_unset.png game-images/th08.png game-images/th08_unset.png game-images/th09.png game-images/th09_5.png game-images/th09_5_unset.png game-images/th09_unset.png game-images/th10.png game-images/th10_5.png game-images/th10_5_unset.png game-images/th10_unset.png game-images/th11.png game-images/th11_unset.png game-images/th12.png game-images/th12_3.png game-images/th12_3_unset.png game-images/th12_5.png game-images/th12_5_unset.png game-images/th12_8.png game-images/th12_8_unset.png game-images/th12_unset.png game-images/th13.png game-images/th13_5.png game-images/th13_5_unset.png game-images/th13_unset.png game-images/th14.png game-images/th14_3.png game-images/th14_3_unset.png game-images/th14_5.png game-images/th14_5_unset.png game-images/th14_unset.png game-images/th15.png game-images/th15_5.png game-images/th15_5_unset.png game-images/th15_unset.png game-images/th16.png game-images/th16_5.png game-images/th16_5_unset.png game-images/th16_unset.png game-images/th17.png game-images/th17_unset.png game-images/th18.png game-images/th18_5.png game-images/th18_5_unset.png game-images/th18_unset.png game-images/th19.png game-images/th19_unset.png
        RESOURCES
        RESOURCES font/fontello.ttf
        QML_FILES Footer.qml
        QML_FILES main.js
        QML_FILES
        SOURCES FileIO.h
        SOURCES FileIO.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appNineLauncher-v2 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.app9Launcher-v2
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appNineLauncher-v2
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appNineLauncher-v2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

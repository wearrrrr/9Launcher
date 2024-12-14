cmake_minimum_required(VERSION 3.16)
include(FetchContent)

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
        src/FooterPanel.qml
        src/fs.js
        src/main.js
        src/footer.js

        RESOURCES
            src/json/games.json
            src/game-images/th01.png src/game-images/th01_unset.png src/game-images/th02.png src/game-images/th02_unset.png src/game-images/th03.png src/game-images/th03_unset.png src/game-images/th04.png src/game-images/th04_unset.png src/game-images/th05.png src/game-images/th05_unset.png src/game-images/th06.png src/game-images/th06_unset.png src/game-images/th07.png src/game-images/th07_5.png src/game-images/th07_5_unset.png src/game-images/th07_unset.png src/game-images/th08.png src/game-images/th08_unset.png src/game-images/th09.png src/game-images/th09_5.png src/game-images/th09_5_unset.png src/game-images/th09_unset.png src/game-images/th10.png src/game-images/th10_5.png src/game-images/th10_5_unset.png src/game-images/th10_unset.png src/game-images/th11.png src/game-images/th11_unset.png src/game-images/th12.png src/game-images/th12_3.png src/game-images/th12_3_unset.png src/game-images/th12_5.png src/game-images/th12_5_unset.png src/game-images/th12_8.png src/game-images/th12_8_unset.png src/game-images/th12_unset.png src/game-images/th13.png src/game-images/th13_5.png src/game-images/th13_5_unset.png src/game-images/th13_unset.png src/game-images/th14.png src/game-images/th14_3.png src/game-images/th14_3_unset.png src/game-images/th14_5.png src/game-images/th14_5_unset.png src/game-images/th14_unset.png src/game-images/th15.png src/game-images/th15_5.png src/game-images/th15_5_unset.png src/game-images/th15_unset.png src/game-images/th16.png src/game-images/th16_5.png src/game-images/th16_5_unset.png src/game-images/th16_unset.png src/game-images/th17.png src/game-images/th17_unset.png src/game-images/th18.png src/game-images/th18_5.png src/game-images/th18_5_unset.png src/game-images/th18_unset.png src/game-images/th19.png src/game-images/th19_unset.png
        
        SOURCES
            src/cpp/AppSettings.h
            src/cpp/Clipboard.h
            src/cpp/FileIO.h
            src/cpp/GameLauncher.h
            src/cpp/RPC.h
            src/cpp/Util.h

            src/cpp/Clipboard.cpp
            src/cpp/FileIO.cpp
            src/cpp/GameLauncher.cpp
            src/cpp/RPC.cpp
            src/cpp/Util.cpp
)

target_include_directories(NineLauncher
    PRIVATE src/cpp
)

FetchContent_Declare(
    MMaterial
    GIT_REPOSITORY https://github.com/MarkoStanojevic12/Material-Qt.git
    GIT_TAG        6f173119092f0900010cea5f2298508d84e5ae2a
)
FetchContent_MakeAvailable(MMaterial)

# Remove unused files from MMaterial
set(MMaterialIconsPngFiles
    ${mmaterial_SOURCE_DIR}/MMaterial/Icons/assets/png
)
set(MMaterialIconsSvgFiles
    ${mmaterial_SOURCE_DIR}/MMaterial/Icons/assets/svg
)
file(REMOVE_RECURSE ${MMaterialIconsPngFiles})
file(REMOVE_RECURSE ${MMaterialIconsSvgFiles})

add_subdirectory(${mmaterial_SOURCE_DIR}/MMaterial)

set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

set(DiscordRPC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/externals/discord-rpc)

set(DiscordRPCExamplesDir ${DiscordRPC_DIR}/examples)

file(REMOVE_RECURSE ${DiscordRPCExamplesDir})

add_subdirectory(${DiscordRPC_DIR})

target_include_directories(NineLauncher
    PRIVATE ${DiscordRPC_DIR}/include
)

target_link_libraries(NineLauncher
    PRIVATE Qt6::Quick Qt::Gui MMaterialLibplugin Qt6::QuickControls2
)

set_target_properties(NineLauncher PROPERTIES
    WIN32_EXECUTABLE TRUE
)

set(CMAKE_EXE_LINKER_FLAGS "-s")
set(CMAKE_BUILD_TYPE Release)

include(GNUInstallDirs)
install(TARGETS NineLauncher
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

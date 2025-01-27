cmake_minimum_required(VERSION 3.16)
project(nineLauncher VERSION 0.1 LANGUAGES CXX)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)

qt_add_executable(NineLauncher
    src/main.cpp
)

qt_add_qml_module(NineLauncher
    URI nineLauncher
    VERSION 1.0
    RESOURCE_PREFIX /
    QML_FILES
        src/qml/Main.qml
        src/qml/GameItem.qml
        src/qml/Footer.qml
        src/qml/Setting.qml
        src/qml/FooterPanel.qml
        src/qml/BinaryManager.qml
        
        src/qml/main.js
        src/qml/BinaryManager.js
        src/qml/fs.js
        src/qml/footer.js

        RESOURCES
            src/json/games.json
            game-images/th01.png game-images/th01_unset.png game-images/th02.png game-images/th02_unset.png game-images/th03.png game-images/th03_unset.png game-images/th04.png game-images/th04_unset.png game-images/th05.png game-images/th05_unset.png game-images/th06.png game-images/th06_unset.png game-images/th07.png game-images/th07_5.png game-images/th07_5_unset.png game-images/th07_unset.png game-images/th08.png game-images/th08_unset.png game-images/th09.png game-images/th09_5.png game-images/th09_5_unset.png game-images/th09_unset.png game-images/th10.png game-images/th10_5.png game-images/th10_5_unset.png game-images/th10_unset.png game-images/th11.png game-images/th11_unset.png game-images/th12.png game-images/th12_3.png game-images/th12_3_unset.png game-images/th12_5.png game-images/th12_5_unset.png game-images/th12_8.png game-images/th12_8_unset.png game-images/th12_unset.png game-images/th13.png game-images/th13_5.png game-images/th13_5_unset.png game-images/th13_unset.png game-images/th14.png game-images/th14_3.png game-images/th14_3_unset.png game-images/th14_5.png game-images/th14_5_unset.png game-images/th14_unset.png game-images/th15.png game-images/th15_5.png game-images/th15_5_unset.png game-images/th15_unset.png game-images/th16.png game-images/th16_5.png game-images/th16_5_unset.png game-images/th16_unset.png game-images/th17.png game-images/th17_unset.png game-images/th18.png game-images/th18_5.png game-images/th18_5_unset.png game-images/th18_unset.png game-images/th19.png game-images/th19_unset.png
        
        SOURCES
            src/cpp/AppSettings.h
            src/cpp/Clipboard.h
            src/cpp/Downloader.h
            src/cpp/FileIO.h
            src/cpp/GameLauncher.h
            src/cpp/RPC.h
            src/cpp/Util.h

            src/cpp/Clipboard.cpp
            src/cpp/Downloader.cpp
            src/cpp/FileIO.cpp
            src/cpp/GameLauncher.cpp
            src/cpp/RPC.cpp
            src/cpp/Util.cpp
)

target_include_directories(NineLauncher
    PRIVATE src/cpp
)

target_compile_options(NineLauncher PRIVATE -O3)

add_subdirectory(MMaterial)

set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

set(DiscordRPC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/externals/discord-rpc)

set(DiscordRPCExamplesDir ${DiscordRPC_DIR}/examples)
set(DiscordRPCDocumentationDir ${DiscordRPC_DIR}/documentation)

file(REMOVE_RECURSE ${DiscordRPCExamplesDir})
file(REMOVE_RECURSE ${DiscordRPCDocumentationDir})

add_subdirectory(${DiscordRPC_DIR})

target_include_directories(NineLauncher
    PRIVATE ${DiscordRPC_DIR}/include
)

set_target_properties(MMaterialLib PROPERTIES AUTOMOC ON)
target_link_libraries(NineLauncher
    PRIVATE Qt6::Quick Qt::Gui discord-rpc
)

set_target_properties(NineLauncher PROPERTIES
    WIN32_EXECUTABLE TRUE
)

set(CMAKE_EXE_LINKER_FLAGS "-s")
set(CMAKE_BUILD_TYPE Release)

install(TARGETS NineLauncher
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}}
)

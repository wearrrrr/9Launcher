cmake_minimum_required(VERSION 3.16)
project(nineLauncher VERSION 0.1 LANGUAGES CXX)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)
find_package(Qt6 COMPONENTS ShaderTools)

qt_add_executable(NineLauncher
    src/main.cpp
)

file(GLOB GAME_IMAGES RELATIVE ${CMAKE_SOURCE_DIR} "${CMAKE_SOURCE_DIR}/game-images/*.webp")

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
            ${GAME_IMAGES}

        SOURCES
            src/cpp/include/AppSettings.h
            src/cpp/include/Clipboard.h
            src/cpp/include/Downloader.h
            src/cpp/include/FileIO.h
            src/cpp/include/GameLauncher.h
            src/cpp/include/RPC.h
            src/cpp/include/Util.h

            src/cpp/Clipboard.cpp
            src/cpp/Downloader.cpp
            src/cpp/FileIO.cpp
            src/cpp/GameLauncher.cpp
            src/cpp/RPC.cpp
            src/cpp/Util.cpp
)

qt6_add_shaders(NineLauncher "ninelauncher_shaders"
    PREFIX /
    FILES 
        src/shaders/grayscale.frag
)

target_include_directories(NineLauncher
    PRIVATE src/cpp/include/
)

target_compile_options(NineLauncher PRIVATE -Oz)

add_subdirectory(MMaterial)

set(DiscordRPC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/externals/discord-rpc)

add_subdirectory(${DiscordRPC_DIR})

target_include_directories(NineLauncher
    PRIVATE ${DiscordRPC_DIR}/include
)

target_link_libraries(NineLauncher
    PRIVATE Qt6::Quick Qt::Gui MMaterialLib discord-rpc
)

set_target_properties(NineLauncher PROPERTIES
    WIN32_EXECUTABLE TRUE
)

install(TARGETS NineLauncher
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}}
)

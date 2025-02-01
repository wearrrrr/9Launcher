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

file(GLOB ICONS RELATIVE ${CMAKE_SOURCE_DIR} "${CMAKE_SOURCE_DIR}/game-images/*.png")

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
            ${ICONS}

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

target_include_directories(NineLauncher
    PRIVATE src/cpp/include/
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

install(TARGETS NineLauncher
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}}
)

cmake_minimum_required(VERSION 3.16)
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

project(nineLauncher VERSION 0.1 LANGUAGES CXX)

include(FetchContent)

FetchContent_Declare(
  zlib
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_TAG v1.3.1
)

set(ZLIB_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(zlib)

set(ZLIB_LIBRARY zlib)
set(ZLIB_INCLUDE_DIR ${zlib_SOURCE_DIR} ${zlib_BINARY_DIR})
set(ZLIB_FOUND TRUE)

FetchContent_Declare(
  libzip
  GIT_REPOSITORY https://github.com/nih-at/libzip.git
  GIT_TAG v1.11.4
)

set(BUILD_TOOLS OFF CACHE BOOL "" FORCE)
set(BUILD_REGRESS OFF CACHE BOOL "" FORCE)
set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(BUILD_DOC OFF CACHE BOOL "" FORCE)
set(ENABLE_COMMONCRYPTO OFF CACHE BOOL "" FORCE)
set(ENABLE_GNUTLS OFF CACHE BOOL "" FORCE)
set(ENABLE_MBEDTLS OFF CACHE BOOL "" FORCE)
set(ENABLE_OPENSSL OFF CACHE BOOL "" FORCE)
set(ENABLE_WINDOWS_CRYPTO OFF CACHE BOOL "" FORCE)
set(ENABLE_BZIP2 OFF CACHE BOOL "" FORCE)
set(ENABLE_LZMA OFF CACHE BOOL "" FORCE)
set(ENABLE_ZSTD OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(libzip)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_AUTOMOC ON)

set(QT_QML_GENERATE_QMLLS_INI ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (LINUX)
set(CMAKE_THREAD_LIBS_INIT "-lpthread")
set(CMAKE_HAVE_THREADS_LIBRARY 1)
set(CMAKE_USE_WIN32_THREADS_INIT 0)
set(CMAKE_USE_PTHREADS_INIT 1)
set(THREADS_PREFER_PTHREAD_FLAG ON)
endif()
find_package(Threads REQUIRED)

if (LINUX)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Os")
endif()

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2 Core Core5Compat ShaderTools)

qt_add_executable(9Launcher
    src/main.cpp
)

file(GLOB GAME_IMAGES RELATIVE ${CMAKE_SOURCE_DIR} "${CMAKE_SOURCE_DIR}/game-images/*.png")

qt_add_qml_module(9Launcher
    URI nineLauncher
    VERSION 1.0
    RESOURCE_PREFIX /
    QML_FILES
        src/qml/Main.qml
        src/qml/GameItem.qml
        src/qml/GameLaunchDialog.qml
        src/qml/ThcrapConfigDialog.qml
        src/qml/ThcrapPatchOrderDialog.qml
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
            src/json/fan_games.json
            src/json/seihou.json
            ${GAME_IMAGES}

        SOURCES
            src/cpp/include/AppSettings.h
            src/cpp/include/Clipboard.h
            src/cpp/include/Downloader.h
            src/cpp/include/FileIO.h
            src/cpp/include/GameLauncher.h
            src/cpp/include/RPC.h
            src/cpp/include/Util.h

            src/cpp/AppSettings.cpp
            src/cpp/Clipboard.cpp
            src/cpp/Downloader.cpp
            src/cpp/FileIO.cpp
            src/cpp/GameLauncher.cpp
            src/cpp/RPC.cpp
            src/cpp/Util.cpp
)

if (WIN32)
    enable_language(RC)
    target_sources(9Launcher PRIVATE assets/windows/9Launcher.rc)
endif()

qt6_add_shaders(9Launcher "ninelauncher_shaders"
    PREFIX /shaders
    FILES
        src/shaders/image_mask.frag
    OUTPUTS
        image_mask.frag.qsb
)

target_include_directories(9Launcher
    PRIVATE src/cpp/include/
)

add_subdirectory(MMaterial)


set(DiscordRPC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/externals/discord-rpc)

add_subdirectory(${DiscordRPC_DIR})

target_include_directories(9Launcher
    PRIVATE ${DiscordRPC_DIR}/include
)

set_target_properties(MMaterialLib PROPERTIES AUTOMOC ON)
target_link_libraries(9Launcher PRIVATE Qt6::Quick Qt::Gui Qt6::Core discord-rpc zip)
set_target_properties(9Launcher PROPERTIES
    WIN32_EXECUTABLE TRUE
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin"
)

install(TARGETS 9Launcher
    BUNDLE DESTINATION "${CMAKE_SOURCE_DIR}/bin"
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

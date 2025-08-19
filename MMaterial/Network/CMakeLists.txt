qt_add_qml_module(NetworkLib
    URI MMaterial.Network
    VERSION 1.0
    STATIC
    QML_FILES
        DownloadDialog.qml
    SOURCES
        src/DownloadController.h src/DownloadController.cpp
)

set_target_properties(NetworkLib PROPERTIES AUTOMOC ON)
target_link_libraries(NetworkLib PRIVATE Qt6::Quick)

target_compile_definitions(NetworkLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

target_include_directories(NetworkLib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/
)

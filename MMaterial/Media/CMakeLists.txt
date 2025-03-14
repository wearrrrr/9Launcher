list(APPEND QML_ICON_SINGLETONS
    IconFont.qml
    Icons.qml
)

list(APPEND ICON_ASSETS
    assets/icomoon.ttf
)

set_source_files_properties(
    ${QML_ICON_SINGLETONS}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(MediaLib
    URI MMaterial.Media
    VERSION 1.0
    STATIC
    QML_FILES
        ${QML_ICON_SINGLETONS}
        Icon.qml
        LightIcon.qml
        IconData.qml
        IconBase.qml
        IconSet.qml

    RESOURCES ${ICON_ASSETS}
)

set_target_properties(MediaLib PROPERTIES AUTOMOC ON)
target_link_libraries(MediaLib PRIVATE Qt6::Quick)

target_compile_definitions(MediaLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

qt_add_resources(MediaLib
    "mmaterial_icon_assets"
    BASE "${CMAKE_CURRENT_SOURCE_DIR}"
    PREFIX "MMaterial"
    BIG_RESOURCES
    FILES
        ${ICON_ASSETS}
)


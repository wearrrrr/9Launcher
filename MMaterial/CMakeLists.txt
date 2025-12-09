option(MM_PACKAGE_DEFAULT_FONTS "Include default fonts in the QML module" ON)


qt_add_qml_module(MMaterialLib
    URI MMaterial
    VERSION 1.0
    STATIC
    IMPORTS
        MMaterial.Controls
        MMaterial.UI
        MMaterial.Media

    # OPTIONAL_IMPORTS
    #     MMaterial.Charts
    #     MMaterial.Network
)

file(GLOB SVG_ASSETS "Media/assets/svg/*.svg")

qt_add_resources(MMaterialLib
    "mmaterial_assets"
    BASE "${CMAKE_CURRENT_SOURCE_DIR}"
    PREFIX "MMaterial"
    BIG_RESOURCES
    FILES
        ${SVG_ASSETS}
)

set_target_properties(MMaterialLib PROPERTIES AUTOMOC ON)
target_link_libraries(MMaterialLib PRIVATE Qt6::Quick)

add_subdirectory(Controls)
# add_subdirectory(Charts)
add_subdirectory(Media)
add_subdirectory(UI)
# add_subdirectory(Network)

target_compile_definitions(MMaterialLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

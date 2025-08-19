list(APPEND QML_UI_SINGLETONS
    Font.qml
    Theme.qml
    DarkTheme.qml
    LightTheme.qml
    ThemeList.qml
    BasicRed.qml
    BasicGreen.qml
    BasicPurple.qml
    BasicBlue.qml
    BasicOrange.qml
    BasicLightBlue.qml
    Size.qml
)

list(APPEND UI_QML_FILES
    PaletteTransparent.qml
    PaletteCommon.qml
    PaletteBackground.qml
    PaletteText.qml
    PaletteBasic.qml
    PaletteGrey.qml
    PaletteSocial.qml
    PaletteOther.qml
    PaletteAction.qml
    ThemeBase.qml
    H1.qml
    H2.qml
    H3.qml
    H4.qml
    H5.qml
    H6.qml
    Subtitle1.qml
    Subtitle2.qml
    B1.qml
    B2.qml
    Caption.qml
    Overline.qml
    BaseText.qml
    EasedAnimation.qml
    ElasticAnimation.qml
    DashedLine.qml
    Pre.qml
    Teardrop.qml
)

set_source_files_properties(
    ${QML_UI_SINGLETONS}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

set(UI_FONTS)
if(TRUE)
    list(APPEND UI_FONTS
        fonts/Public_Sans/PublicSans-VariableFont_wght.ttf
        fonts/Public_Sans/PublicSans-Italic-VariableFont_wght.ttf
        fonts/Roboto_Mono/RobotoMono-VariableFont_wght.ttf
    )
endif()

qt_add_qml_module(UILib
    URI MMaterial.UI
    VERSION 1.0
    STATIC
    QML_FILES
        ${QML_UI_SINGLETONS}
        ${UI_QML_FILES}

    RESOURCES
        ${UI_FONTS}
)

set_target_properties(UILib PROPERTIES AUTOMOC ON)
target_link_libraries(UILib PRIVATE Qt6::Quick Qt6::QuickControls2)

target_compile_definitions(UILib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

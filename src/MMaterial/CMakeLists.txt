qt_add_library(MMaterialLib STATIC)

set_target_properties(MMaterialLib PROPERTIES AUTOMOC ON)
target_link_libraries(MMaterialLib PRIVATE Qt6::Quick)

target_include_directories(MMaterialLib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ColorPicker
)

target_compile_definitions(MMaterialLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

list(APPEND MODULE_ASSETS
    # Fonts
    Fonts/Families/PublicSans/PublicSans-ExtraBold.ttf
    Fonts/Families/PublicSans/PublicSans-Bold.ttf
    Fonts/Families/PublicSans/PublicSans-SemiBold.ttf
    Fonts/Families/PublicSans/PublicSans-Medium.ttf
    Fonts/Families/PublicSans/PublicSans-Regular.ttf
    Fonts/Families/PublicSans/PublicSans-Light.ttf
    Fonts/Families/PublicSans/PublicSans-ExtraLight.ttf
    Icons/assets/icomoon.ttf
)

list(APPEND MODULE_QML_FILES
    # Fonts
    Fonts/PublicSans.qml
    Fonts/BaseFont.qml
    Fonts/Texts/H1.qml
    Fonts/Texts/H2.qml
    Fonts/Texts/H3.qml
    Fonts/Texts/H4.qml
    Fonts/Texts/H5.qml
    Fonts/Texts/H6.qml
    Fonts/Texts/Subtitle1.qml
    Fonts/Texts/Subtitle2.qml
    Fonts/Texts/B1.qml
    Fonts/Texts/B2.qml
    Fonts/Texts/Caption.qml
    Fonts/Texts/Overline.qml
    Fonts/Texts/BaseText.qml

    # Colors / Themes
    Colors/Theme.qml
    Colors/ThemeList.qml
    Colors/BaseObjects/PaletteTransparent.qml
    Colors/BaseObjects/PaletteCommon.qml
    Colors/BaseObjects/PaletteBackground.qml
    Colors/BaseObjects/PaletteText.qml
    Colors/BaseObjects/PaletteBasic.qml
    Colors/BaseObjects/PaletteGrey.qml
    Colors/BaseObjects/PaletteSocial.qml
    Colors/BaseObjects/PaletteOther.qml
    Colors/BaseObjects/PaletteAction.qml
    Colors/BaseObjects/ThemeBase.qml
    Colors/Themes/DarkTheme.qml
    Colors/Themes/LightTheme.qml
    Colors/BasicPalettes/BasicRed.qml
    Colors/BasicPalettes/BasicGreen.qml
    Colors/BasicPalettes/BasicPurple.qml
    Colors/BasicPalettes/BasicBlue.qml
    Colors/BasicPalettes/BasicOrange.qml
    Colors/BasicPalettes/BasicLightBlue.qml

    # Icons
    Icons/Icon.qml
    Icons/Icons.qml
    Icons/Images.qml
    Icons/LightIcon.qml
    Icons/IconFont.qml
    Icons/IconData.qml
    Icons/HeavyIcon.qml
    Icons/IconBase.qml

    # Components
    Components/Badge/BadgeNumber.qml
    Components/Badge/BadgeDot.qml
    Components/Badge/Badge.qml
    Components/Accordion.qml
    Components/Alerts/Alert.qml
    Components/Alerts/AlertController.qml
    Components/Avatar.qml
    Components/Pagination/Paginator.qml
    Components/Progress/MProgressBar.qml
    Components/Progress/MCircularProgressBar.qml
    Components/Progress/BusyIndicator.qml
    Components/Inputs/MTextField.qml
    Components/Inputs/MDropdown.qml
    Components/Common/MScrollIndicator.qml
    Components/Common/MToolTip.qml
    Components/Common/MLoader.qml
    Components/Common/MSlider.qml
    Components/MRectangle.qml
    Components/MBorder.qml
    Components/CornerRadii.qml
    Components/Inputs/AvatarInput.qml
    Components/Common/MaskedImage.qml
    Components/Inputs/TimePicker.qml
    Components/Inputs/MCalendar.qml
    Components/Common/Popup.qml
    Components/Inputs/DatePicker.qml
    Components/Common/ScrollBar.qml
    Components/Inputs/ColorPicker/ColorPicker.qml
    Components/Inputs/ColorPicker/ColorPreview.qml
    Components/Inputs/ColorPicker/ColorSelection.qml
    Components/Inputs/ColorPicker/ColorSlider.qml
    Components/Inputs/ColorPicker/OpacitySlider.qml


    # Settings
    Settings/Size.qml

    # Buttons
    Buttons/MButton.qml
    Buttons/MToggleButton.qml
    Buttons/MFabButton.qml
    Buttons/MCheckbox.qml
    Buttons/CheckedGroup.qml
    Buttons/Checkable.qml
    Buttons/MRadioButton.qml
    Buttons/MSwitch.qml
    Buttons/MTabButton.qml
    Buttons/MTabs.qml

    # Sidebar
    Sidebar/Sidebar.qml
    Sidebar/SidebarCategoryLabel.qml
    Sidebar/SidebarExtendedItem.qml
    Sidebar/CompactSidebar.qml
    Sidebar/MobileSidebar.qml
    Sidebar/SidebarCompactItem.qml
    Sidebar/SidebarSeparator.qml
    Sidebar/ExtendedSidebar.qml
    Sidebar/SidebarItem.qml
    Sidebar/SidebarData.qml

    # Lists
    Lists/ListItem.qml
    Lists/ListItemContact.qml
    Lists/AbstractListItem.qml

    # Pagination
    Components/Pagination/PaginatorSimple.qml
    Components/Pagination/PaginatorBubble.qml
    Components/Pagination/PaginatorArrows.qml

    # Animations
    Animations/EasedAnimation.qml
    Animations/ElasticAnimation.qml

    # Menu
    Components/Menu/Menu.qml
    Components/Menu/MenuItem.qml
    Components/Menu/MenuSeparator.qml

    # Dialogs
    Components/Dialogs/Dialog.qml
    Components/Dialogs/DialogButtonBox.qml
    Components/Dialogs/LargeImageDialog.qml
    Components/Dialogs/MediumImageDialog.qml
    Components/Dialogs/InputDialog.qml

    # Charts
    Charts/BarChart.qml
    Charts/WaterfallChart.qml
    Charts/ChartFunctions.qml
)

list(APPEND MODULE_SOURCES
    src/ChartElement.h src/ChartElement.cpp
    src/ColorPicker/ColorHistoryModel.h src/ColorPicker/ColorHistoryModel.cpp
    src/ColorPicker/ColorPickerController.h src/ColorPicker/ColorPickerController.cpp
    src/ColorPicker/ColorPickerPreview.h src/ColorPicker/ColorPickerPreview.cpp
    src/ColorPicker/ColorSliderController.h src/ColorPicker/ColorSliderController.cpp
    src/ColorPicker/ColorUtils.h src/ColorPicker/ColorUtils.cpp
    src/ColorPicker/ShadePickerController.h src/ColorPicker/ShadePickerController.cpp
)

set_source_files_properties(
    Colors/Theme.qml
    Colors/Themes/DarkTheme.qml
    Colors/Themes/LightTheme.qml
    Colors/ThemeList.qml
    Colors/BasicPalettes/BasicRed.qml
    Colors/BasicPalettes/BasicGreen.qml
    Colors/BasicPalettes/BasicPurple.qml
    Colors/BasicPalettes/BasicBlue.qml
    Colors/BasicPalettes/BasicOrange.qml
    Colors/BasicPalettes/BasicLightBlue.qml
    Charts/ChartFunctions.qml

    Icons/IconFont.qml
    Fonts/PublicSans.qml
    Icons/Icons.qml
    Icons/Images.qml
    Settings/Size.qml

    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(MMaterialLib
    URI MMaterial
    RESOURCE_PREFIX /
    VERSION 1.0
    QML_FILES ${MODULE_QML_FILES}
    RESOURCES ${MODULE_ASSETS}
    SOURCES ${MODULE_SOURCES}
)

# Read the contents of the file into a variable
file(GLOB PNG_ASSETS "Icons/assets/png/*.png")
file(GLOB JPEG_ASSETS "Icons/assets/png/*.jpeg")
file(GLOB SVG_ASSETS "Icons/assets/svg/*.svg")

qt_add_resources(MMaterialLib
    "mmaterial_icons"
    BASE "${CMAKE_CURRENT_SOURCE_DIR}"
    PREFIX "MMaterial"
    FILES
    ${PNG_ASSETS}
    ${JPEG_ASSETS}
    ${SVG_ASSETS}
)

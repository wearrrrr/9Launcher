list(APPEND CONTROLS_QML_FILES
    MButton.qml
    MToggleButton.qml
    MFabButton.qml
    MCheckbox.qml
    CheckedGroup.qml
    Checkable.qml
    MRadioButton.qml
    MSwitch.qml
    MTabButton.qml
    MTabs.qml
    BadgeNumber.qml
    BadgeDot.qml
    Badge.qml
    Accordion.qml
    Alert.qml
    AlertGenerator.qml
    Avatar.qml
    MProgressBar.qml
    MCircularProgressBar.qml
    BusyIndicator.qml
    MScrollIndicator.qml
    MToolTip.qml
    MLoader.qml
    MSlider.qml
    MRectangle.qml
    MBorder.qml
    CornerRadii.qml
    MaskedImage.qml
    Popup.qml
    ScrollBar.qml
    Menu.qml
    MenuItem.qml
    MenuSeparator.qml
    ListItem.qml
    ListItemContact.qml
    AbstractListItem.qml
    MultiStateButton.qml
    ToggleButtonGroup.qml
    SpinBox.qml
    Breadcrumbs.qml
    # SwipeBar.qml
    ScrollView.qml
)

qt_add_qml_module(ControlsLib
    URI MMaterial.Controls
    VERSION 1.0
    STATIC

    IMPORTS
        MMaterial.Controls.Inputs

    OPTIONAL_IMPORTS
        MMaterial.Controls.Dialogs
        # MMaterial.Controls.Pagination
        MMaterial.Controls.Sidebar

    QML_FILES ${CONTROLS_QML_FILES}
    SOURCES
        src/AlertController.h src/AlertController.cpp
)

set_target_properties(ControlsLib PROPERTIES AUTOMOC ON)
target_link_libraries(ControlsLib PRIVATE Qt6::Quick)

target_compile_definitions(ControlsLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

target_include_directories(ControlsLib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/
)

add_subdirectory(Dialogs)
add_subdirectory(Inputs)
# add_subdirectory(Pagination)
add_subdirectory(Sidebar)

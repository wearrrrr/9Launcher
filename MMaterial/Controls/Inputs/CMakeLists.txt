list(APPEND INPUTS_SOURCES
    src/ColorHistoryModel.h src/ColorHistoryModel.cpp
    src/ColorPickerController.h src/ColorPickerController.cpp
    src/ColorPickerPreview.h src/ColorPickerPreview.cpp
    src/ColorSliderController.h src/ColorSliderController.cpp
    src/ColorUtils.h src/ColorUtils.cpp
    src/ShadePickerController.h src/ShadePickerController.cpp
)

qt_add_qml_module(InputsLib
    URI MMaterial.Controls.Inputs
    VERSION 1.0
    STATIC
    QML_FILES
    ComboBox.qml
        TimePicker.qml
        MCalendar.qml
        AvatarInput.qml
        DatePicker.qml
        TextField.qml
        ColorPicker.qml
        ColorPreview.qml
        ColorSelection.qml
        ColorSlider.qml
        OpacitySlider.qml
        InputsBackground.qml
        TextArea.qml
    SOURCES
        ${INPUTS_SOURCES}
)

set_target_properties(InputsLib PROPERTIES AUTOMOC ON)
target_link_libraries(InputsLib PRIVATE Qt6::Quick)

target_compile_definitions(InputsLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

target_include_directories(InputsLib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/
)

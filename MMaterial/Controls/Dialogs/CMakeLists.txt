qt_add_qml_module(DialogsLib
    URI MMaterial.Controls.Dialogs
    VERSION 1.0
    STATIC
    QML_FILES
        Dialog.qml
        # DialogButtonBox.qml
        # LargeImageDialog.qml
        # MediumImageDialog.qml
        # InputDialog.qml
)

set_target_properties(DialogsLib PROPERTIES AUTOMOC ON)
target_link_libraries(DialogsLib PRIVATE Qt6::Quick)

target_compile_definitions(DialogsLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

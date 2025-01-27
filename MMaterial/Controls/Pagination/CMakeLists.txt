qt_add_qml_module(PaginationLib
    URI MMaterial.Controls.Pagination
    VERSION 1.0
    STATIC
    QML_FILES
        Paginator.qml
        PaginatorSimple.qml
        PaginatorBubble.qml
        PaginatorArrows.qml
)

set_target_properties(PaginationLib PROPERTIES AUTOMOC ON)
target_link_libraries(PaginationLib PRIVATE Qt6::Quick)

target_compile_definitions(PaginationLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

qt_add_qml_module(SidebarLib
    URI MMaterial.Controls.Sidebar
    VERSION 1.0
    STATIC
    QML_FILES
        Sidebar.qml
        SidebarCategoryLabel.qml
        SidebarExtendedItem.qml
        CompactSidebar.qml
        MobileSidebar.qml
        SidebarCompactItem.qml
        SidebarSeparator.qml
        ExtendedSidebar.qml
        SidebarItem.qml
        SidebarData.qml
)

set_target_properties(SidebarLib PROPERTIES AUTOMOC ON)
target_link_libraries(SidebarLib PRIVATE Qt6::Quick)

target_compile_definitions(SidebarLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

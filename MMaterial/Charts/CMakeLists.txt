set_source_files_properties(
    ChartFunctions.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(ChartsLib
    URI MMaterial.Charts
    VERSION 1.0
    STATIC
    QML_FILES
        BarChart.qml
        ChartFunctions.qml
        WaterfallChart.qml
    SOURCES
        src/ChartElement.h src/ChartElement.cpp
)

set_target_properties(ChartsLib PROPERTIES AUTOMOC ON)
target_link_libraries(ChartsLib PRIVATE Qt6::Quick)

target_compile_definitions(ChartsLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)

target_include_directories(ChartsLib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/
)

cmake_minimum_required(VERSION 3.16)

project(TypeTrainer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appTypeTrainer
    main.cpp
    txtreader.cpp
    txtreader.h
    resources.qrc
)

qt_add_qml_module(appTypeTrainer
    URI TypeTrainer
    VERSION 1.0
    QML_FILES Main.qml WaveEffect.qml TypingPage.qml LangChoosePage.qml RussianPage.qml EnglishPage.qml ButtonDelegate.qml LeftShiftDelegate.qml RightShiftDelegate.qml
    RESOURCES TypingPage.qml ButtonDelegate.qml LeftShiftDelegate.qml RightShiftDelegate.qml
)

set_target_properties(appTypeTrainer PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTypeTrainer
    PRIVATE Qt6::Quick
)

install(TARGETS appTypeTrainer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

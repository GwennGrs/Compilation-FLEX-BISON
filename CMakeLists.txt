# file: CMakeLists.txt
# version: 0.1.0
cmake_minimum_required(VERSION 3.0)
project(facile VERSION 0.1.0 LANGUAGES C)
# Search for the flex cmake package
find_package(FLEX)
# Definition of a scanner
flex_target(
FACILE_SCANNER
facile.lex
"${CMAKE_CURRENT_BINARY_DIR}/facile.lex.c"
)
# Creation of the "facile" executable
add_executable(facile ${FLEX_FACILE_SCANNER_OUTPUTS})
# Add flex library to the "facile" executable
target_link_libraries(facile fl)
# Add zip generator
set(CPACK_SOURCE_GENERATOR "ZIP")
set(CPACK_SOURCE_IGNORE_FILES "build;~$;${CPACK_SOURCE_IGNORE_FILES}")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
include(CPack)

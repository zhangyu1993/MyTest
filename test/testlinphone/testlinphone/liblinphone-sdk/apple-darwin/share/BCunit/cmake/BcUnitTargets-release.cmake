#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "bcunit-static" for configuration "Release"
set_property(TARGET bcunit-static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(bcunit-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libbcunit.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS bcunit-static )
list(APPEND _IMPORT_CHECK_FILES_FOR_bcunit-static "${_IMPORT_PREFIX}/lib/libbcunit.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

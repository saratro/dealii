#
# Set up deal.II specific definitions
#

SET_IF_EMPTY(DEAL_II_PACKAGE_NAME "deal.II")

SET(DEAL_II_PACKAGE_VERSION ${VERSION})
SET(DEAL_II_PACKAGE_STRING
  "${DEAL_II_PACKAGE_NAME} ${DEAL_II_PACKAGE_VERSION}"
  )

SET_IF_EMPTY(DEAL_II_PACKAGE_BUGREPORT "dealii@dealii.org")
SET_IF_EMPTY(DEAL_II_PACKAGE_TARNAME ${DEAL_II_PACKAGE_NAME}) #TODO
SET_IF_EMPTY(DEAL_II_PACKAGE_URL "http://www.dealii.org")

STRING(REGEX REPLACE
  "^([0-9]+)\\..*" "\\1" DEAL_II_VERSION_MAJOR "${VERSION}"
  )
STRING(REGEX REPLACE
  "^[0-9]+\\.([0-9]+).*" "\\1" DEAL_II_VERSION_MINOR "${VERSION}"
  )

#
# Set the library and project name depending on build type:
#
IF(CMAKE_BUILD_TYPE MATCHES "Debug")
  SET_IF_EMPTY(DEAL_II_BASE_NAME "deal_II.g")
  SET_IF_EMPTY(DEAL_II_PROJECT_CONFIG_NAME "${DEAL_II_PACKAGE_NAME}_DEBUG")
ELSE()
  SET_IF_EMPTY(DEAL_II_BASE_NAME "deal_II")
  SET_IF_EMPTY(DEAL_II_PROJECT_CONFIG_NAME "${DEAL_II_PACKAGE_NAME}")
ENDIF()

SET(DEAL_II_PATH ${CMAKE_INSTALL_PREFIX})

IF(DEAL_II_COMPONENT_COMPAT_FILES)
  #
  # The good, old directory structure:
  #
  SET_IF_EMPTY(DEAL_II_DOCUMENTATION_RELDIR "doc")
  SET_IF_EMPTY(DEAL_II_EXAMPLES_RELDIR "examples")
  SET_IF_EMPTY(DEAL_II_INCLUDE_RELDIR "include")
  SET_IF_EMPTY(DEAL_II_LIBRARY_RELDIR "lib")
  SET_IF_EMPTY(DEAL_II_PROJECT_CONFIG_RELDIR ".")

ELSE()
  #
  # IF DEAL_II_COMPONENT_COMPAT_FILES is not set, we assume that we have to
  # obey the FSHS...
  #
  SET_IF_EMPTY(DEAL_II_DOCUMENTATION_RELDIR "share/doc/${DEAL_II_PACKAGE_NAME}/html")
  SET_IF_EMPTY(DEAL_II_EXAMPLES_RELDIR "share/doc/${DEAL_II_PACKAGE_NAME}/examples")
  SET_IF_EMPTY(DEAL_II_INCLUDE_RELDIR "include")
  SET_IF_EMPTY(DEAL_II_LIBRARY_RELDIR "lib${LIB_SUFFIX}")
  SET_IF_EMPTY(DEAL_II_PROJECT_CONFIG_RELDIR "${DEAL_II_LIBRARY_RELDIR}/cmake/${DEAL_II_PROJECT_CONFIG_NAME}")
ENDIF()

LIST(APPEND DEAL_II_INCLUDE_DIRS
  "${CMAKE_INSTALL_PREFIX}/${DEAL_II_INCLUDE_RELDIR}"
  )

#
# The library name:
#
IF(BUILD_SHARED_LIBS)
  SET(DEAL_II_LIBRARY_NAME
    ${CMAKE_SHARED_LIBRARY_PREFIX}${DEAL_II_BASE_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}
    )
ELSE()
  SET(DEAL_II_LIBRARY_NAME
    ${CMAKE_STATIC_LIBRARY_PREFIX}${DEAL_II_BASE_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX}
    )
ENDIF()

LIST(APPEND DEAL_II_LIBRARIES
  "${CMAKE_INSTALL_PREFIX}/${DEAL_II_LIBRARY_RELDIR}/${DEAL_II_LIBRARY_NAME}"
  )


cmake_minimum_required(VERSION 3.16)

project(OCSDL)

enable_language(OBJC)
set(CMAKE_OBJC_FLAGS "-fobjc-runtime=gnustep-2.0 -fobjc-arc")

include_directories(${GNUSTEP_PATH}/include)
link_directories(${GNUSTEP_PATH}/lib)

add_library(
        OCSDL
        OCSDL/src/OCSDL.m
        OCSDL/src/OCSDLBase.m
        OCSDL/src/OCSDLEvent.m
        OCSDL/src/OCSDLSurface.m
        OCSDL/src/OCSDLRenderer.m
        OCSDL/src/OCSDLTexture.m
        OCSDL/src/OCSDLSprite.m
        OCSDL/src/OCSDLWindow.m
)
include_directories(OCSDL/include)

add_executable(
        TestOCSDL
        Main.m
        Application.m
)

target_link_libraries(TestOCSDL OCSDL objc gnustep-base SDL2 SDL2_image)

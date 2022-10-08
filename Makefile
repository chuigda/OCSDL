OCFLAGS = \
	-fobjc-runtime=gnustep-2.0 \
 	-fconstant-string-class=NSConstantString \
 	-std=c11 \
 	-I/home/icey/program/c4/gnustep-libobjc2/include \
 	-I/home/icey/program/c4/gnustep-make/include \
 	-fobjc-arc

INCLUDE_FILES = \
	Application.h \
	OCSDL.h \
	OCSDLSurface.h \
	OCSDLWindow.h \
	OCSDLEvent.h \
	OCUtil.h \
	Sinkrate.h

.PHONY: all
all: OCSDLTest libOCSDL.a Main.o Application.o OCSDLSurface.o OCSDLWindow.o OCSDLEvent.o

.PHONY: run
run: OCSDLTest
	./OCSDLTest

OCSDLTest: Main.o Application.o libOCSDL.a
	clang Main.o \
		Application.o \
		-fobjc-runtime=gnustep-2.0 \
		-o OCSDLTest \
		-L. \
		-L/home/icey/program/c4/gnustep-libobjc2/lib \
		-L/home/icey/program/c4/gnustep-make/lib \
		-lobjc \
		-lgnustep-base \
		-fconstant-string-class=NSConstantString \
		-lSDL2 \
		-lOCSDL

libOCSDL.a: OCSDL.o OCSDLSurface.o OCSDLWindow.o OCSDLEvent.o $(INCLUDE_FILES)
	ar rcs libOCSDL.a OCSDL.o OCSDLSurface.o OCSDLWindow.o OCSDLEvent.o

Main.o: Main.m $(INCLUDE_FILES)
	clang Main.m $(OCFLAGS) -c

Application.o: Application.m $(INCLUDE_FILES)
	clang Application.m $(OCFLAGS) -c

OCSDL.o: OCSDL.m $(INCLUDE_FILES)
	clang OCSDL.m $(OCFLAGS) -c

OCSDLSurface.o: OCSDLSurface.m $(INCLUDE_FILES)
	clang OCSDLSurface.m $(OCFLAGS) -c

OCSDLWindow.o: OCSDLWindow.m $(INCLUDE_FILES)
	clang OCSDLWindow.m $(OCFLAGS) -c

OCSDLEvent.o: OCSDLEvent.m $(INCLUDE_FILES)
	clang OCSDLEvent.m $(OCFLAGS) -c

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.a
	rm -f OCSDLTest

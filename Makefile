OCFLAGS = -fconstant-string-class=NSConstantString -I/usr/include/GNUstep -std=c11
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
	cc Main.o \
		Application.o \
		-o OCSDLTest \
		-L/usr/lib/GNUstep \
		-L. \
		-lobjc \
		-lgnustep-base \
		-fconstant-string-class=NSConstantString \
		-lSDL2 \
		-lOCSDL

libOCSDL.a: OCSDL.o OCSDLSurface.o OCSDLWindow.o OCSDLEvent.o $(INCLUDE_FILES)
	ar rcs libOCSDL.a OCSDL.o OCSDLSurface.o OCSDLWindow.o OCSDLEvent.o

Main.o: Main.m $(INCLUDE_FILES)
	cc Main.m $(OCFLAGS) -c

Application.o: Application.m $(INCLUDE_FILES)
	cc Application.m $(OCFLAGS) -c

OCSDL.o: OCSDL.m $(INCLUDE_FILES)
	cc OCSDL.m $(OCFLAGS) -c

OCSDLSurface.o: OCSDLSurface.m $(INCLUDE_FILES)
	cc OCSDLSurface.m $(OCFLAGS) -c

OCSDLWindow.o: OCSDLWindow.m $(INCLUDE_FILES)
	cc OCSDLWindow.m $(OCFLAGS) -c

OCSDLEvent.o: OCSDLEvent.m $(INCLUDE_FILES)
	cc OCSDLEvent.m $(OCFLAGS) -c

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.a
	rm -f OCSDLTest

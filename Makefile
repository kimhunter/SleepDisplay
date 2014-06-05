

LEO_PROJECT=SleepDisplay_10.5.xcodeproj
LION_PROJECT=SleepDisplay_objc.xcodeproj
SWIFT_PROJECT=SleepDisplay.xcodeproj

VERSION=$(shell cat version)

swift:
	 xcodebuild -project $(SWIFT_PROJECT) -configuration Release -derivedDataPath build \
	 -scheme SleepDisplay

x64:
	 xcodebuild -project $(LION_PROJECT) -configuration Release

ub:
	 xcodebuild -project $(LEO_PROJECT) -configuration Release
    
dist_swift: swift 
	mkdir -p  dist/$(VERSION)/x64swift/
	mv build/Build/Products/Release/SleepDisplay dist/$(VERSION)/x64swift/

dist_x64: x64
	mkdir -p  dist/$(VERSION)/x64/
	mv build/Release/SleepDisplay dist/$(VERSION)/x64/

dist_ub: ub
	mkdir -p  dist/$(VERSION)/ub/
	mv build/Release/SleepDisplay dist/$(VERSION)/ub/

all_dist: dist_x64 dist_swift

install: x64
	cp build/Release/SleepDisplay /usr/local/bin/SleepDisplay
    
clean:
	rm -rf build

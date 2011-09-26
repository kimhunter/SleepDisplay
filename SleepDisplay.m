#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>


int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	io_registry_entry_t entry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
	if(entry)
	{
		IORegistryEntrySetCFProperty(entry, CFSTR("IORequestIdle"), kCFBooleanTrue);
		IOObjectRelease(entry);
	}
	
	
	
    [pool drain];
    return 0;
}

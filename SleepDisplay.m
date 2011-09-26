#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#import <string.h>

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    BOOL shouldWake = NO;

    if (argc > 1)
    {
        NSString *flag = [NSString stringWithUTF8String:argv[1]];
        shouldWake = [flag isEqualToString:@"-wake"];
    }
    
	io_registry_entry_t entry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
	if(entry)
	{
		IORegistryEntrySetCFProperty(entry, CFSTR("IORequestIdle"), shouldWake ? kCFBooleanFalse : kCFBooleanTrue);
		IOObjectRelease(entry);
	}
	
    [pool drain];
    return 0;
}

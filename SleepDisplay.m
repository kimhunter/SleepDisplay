/**
 * SleepDisplay
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>. 
 */

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSArray *params = [[NSProcessInfo processInfo] arguments];
    BOOL shouldWake = NO;

    for (NSString *arg in params)
    {
        if([arg isEqualToString:@"-wake"] || [arg isEqualToString:@"--wake"] || [arg isEqualToString:@"-w"])
        {
            shouldWake = YES;
        }
        
        if([arg isEqualToString:@"-h"] || [arg isEqualToString:@"--help"] || [arg isEqualToString:@"-help"])
        {
            printf("%s", [@"usage: SleepWake [-w]\n" UTF8String]);
            printf("%s", [@"Without options, sleeps the display (not system sleep)\n" UTF8String]);
            printf("%s", [@"use with the -w (--wake) option to wake\n" UTF8String]);
        }
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

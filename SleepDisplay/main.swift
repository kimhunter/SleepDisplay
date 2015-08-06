/**
* SleepDisplay
*
* Created by Kim Hunter on 5/6/2014.
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

import Foundation

var shouldWake = false

if let downcastArgs = NSProcessInfo.processInfo().arguments as? [String] {
    for arg in downcastArgs {
        switch arg {
        case "-wake", "--wake", "-w":
            shouldWake = true
        case "-help", "--help", "-h":
            println("usage: SleepDisplay [-w]");
            println("Without options, sleeps the display (not system sleep)");
            println("use with the -w (--wake) option to wake");
            exit(0);
        default:
            continue
        }
    }
}

let entry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler")
IORegistryEntrySetCFProperty(entry, "IORequestIdle", shouldWake ? kCFBooleanFalse : kCFBooleanTrue);
IOObjectRelease(entry);

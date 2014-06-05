//
//  main.swift
//  SleepDisplaySwift
//
//  Created by Kim Hunter on 5/6/2014.
//
//

import Foundation

var args: String[] = []
var shouldWake = false

if let downcastArgs = NSProcessInfo.processInfo().arguments as? String[] {
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

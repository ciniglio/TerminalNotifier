//
//  main.m
//  TestNotify
//
//  Created by Alejandro Ciniglio on 7/27/12.
//  Copyright (c) 2012 Alejandro Ciniglio. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AECAppDelegate.h"

int main(int argc, char *argv[])
{
    //return NSApplicationMain(argc, (const char **)argv);
    AECAppDelegate *delegate = [[AECAppDelegate alloc] init];
    NSApplication *application = [NSApplication sharedApplication];
    ProcessSerialNumber psn = {0, kCurrentProcess}; //not sure what this syntax magic is {}
    TransformProcessType(&psn, kProcessTransformToBackgroundApplication);
    [application setDelegate:delegate];
    [NSApp run];
    return 0;
}

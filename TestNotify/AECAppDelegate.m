//
//  AECAppDelegate.m
//  TestNotify
//
//  Created by Alejandro Ciniglio on 7/27/12.
//  Copyright (c) 2012 Alejandro Ciniglio. All rights reserved.
//

#import "AECAppDelegate.h"

@implementation AECAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSApp setApplicationIconImage:[NSImage imageNamed:NSImageNameComputer]];
    NSUserNotification *n = [[NSUserNotification alloc] init];
    [n setHasActionButton:YES];
    [n setActionButtonTitle:@"WHOA"];
    [n setTitle:@"Alejandro"];
    [n setSubtitle:@"Testing"];

    NSUserNotificationCenter *nc = [NSUserNotificationCenter defaultUserNotificationCenter];
    [nc deliverNotification:n];
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    [[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/Utilities/Terminal.app"];
    [center removeDeliveredNotification:notification];
}

- (IBAction)buttonPushed:(id)sender {
    NSLog(@"button pushed");
    NSUserNotification *n = [[NSUserNotification alloc] init];
    [n setTitle:@"Alejandro"];
    [n setSubtitle:@"Testing"];
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:n];
}


@end

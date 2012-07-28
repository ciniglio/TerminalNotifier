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
//    NSUserNotification *n = [[NSUserNotification alloc] init];
//    [n setHasActionButton:YES];
//    [n setActionButtonTitle:@"WHOA"];
//    [n setTitle:@"Alejandro"];
//    [n setSubtitle:@"Testing"];
    NSUserNotification *notification = [self createUserNotificationFromArguments];

    [[NSUserNotificationCenter defaultUserNotificationCenter]deliverNotification:notification];
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    [[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/Utilities/Terminal.app"];
    [center removeDeliveredNotification:notification];
}

- (NSUserNotification *)createUserNotificationFromArguments
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    NSString *title = [arguments objectAtIndex:0] == nil ? [arguments objectAtIndex:0] : @"Ruby Notifier";
    [notification setTitle:title];
    NSString *subtitle = [arguments objectAtIndex:1] == nil ? [arguments objectAtIndex:1] : @"Ruby Notifier";
    [notification setSubtitle:subtitle];
    
    return notification;
}

@end

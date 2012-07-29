//
//  AECAppDelegate.m
//  TestNotify
//
//  Created by Alejandro Ciniglio on 7/27/12.
//  Copyright (c) 2012 Alejandro Ciniglio. All rights reserved.
//

#import "AECAppDelegate.h"
#import "AECArgumentParser.h"

@implementation AECAppDelegate

void cleaner()
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications];
    [[NSApplication sharedApplication] terminate:NSApp];
}

- (void)handleActiveAppNotification:(NSNotification *)notification
{
    NSLog(@"Got notified: %@", notification);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSUserNotification *notification = [self createUserNotificationFromArguments];
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(handleActiveAppNotification) name:@"NSWorkspaceDidDeactivateApplicationNotification" object:nil];
    
    signal(SIGINT, &cleaner);
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    NSUserNotification *user_notification = [self createUserNotificationFromArguments];
    [[NSUserNotificationCenter defaultUserNotificationCenter]deliverNotification:user_notification];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    [[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/Utilities/Terminal.app"];
    [center removeDeliveredNotification:notification];
    [[NSApplication sharedApplication] terminate:self];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications];
    return NSTerminateNow;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications];
}

- (void)setSoundForNotification:(NSUserNotification *)notification
{
    NSString * title = [notification title];
    if ([title rangeOfString:@"fail" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [notification setSoundName:@"Ping"];
    }
    else if ([title rangeOfString:@"warn" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [notification setSoundName:@"Ping"];
    }
    else {
        [notification setSoundName:@"Glass"];
    }
    
}

- (NSUserNotification *)createUserNotificationFromArguments
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    NSString *title = [arguments objectAtIndex:1] != nil ? [arguments objectAtIndex:1] : @"Terminal";
    [notification setTitle:title];
    NSString *subtitle = [arguments objectAtIndex:2] != nil ? [arguments objectAtIndex:2] : @"Done!";
    [notification setSubtitle:subtitle];
    NSString *info_text = [arguments objectAtIndex:3] != nil ? [arguments objectAtIndex:3] : @"Your long-running process has finished";
    [notification setInformativeText:info_text];
    [self setSoundForNotification:notification];

    
    return notification;
}

@end

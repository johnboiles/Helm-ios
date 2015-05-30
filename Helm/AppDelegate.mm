//
//  AppDelegate.m
//  Helm
//
//  Created by John Boiles on 3/21/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "AppDelegate.h"
#import "ConnectionController.h"
#import "ControlsViewController.h"
#import "NMEAMessage.h"
#import "SeaTalkMessage.h"


@interface AppDelegate () <ConnectionControllerDelegate>
@property UINavigationController *navigationController;
@property ConnectionController *connectionController;
@end

@implementation AppDelegate

+ (AppDelegate *)sharedDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.connectionController = [ConnectionController new];
    self.connectionController.delegate = self;

    ControlsViewController *controlsViewController = [ControlsViewController new];
    controlsViewController.title = @"Helm";
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:controlsViewController];
    self.window = [UIWindow new];
    self.window.frame = [[UIScreen mainScreen] bounds];
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];

    [self.connectionController connectToHost:@"192.168.42.1" port:2000];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark ConnectionControllerDelegate

- (void)connectionController:(ConnectionController *)connectionController didGetNMEAMessage:(NSString *)NMEAMessage {
//    NSLog(@"RX: %@", NMEAMessage);
    if ([NMEAMessage hasPrefix:@"$STSEA"]) {
        const char *messageString = [NMEAMessage cStringUsingEncoding:NSASCIIStringEncoding];
        NMEAMessageSEA message = NMEAMessageSEA(messageString);

        if ([NMEAMessage hasPrefix:@"$STSEA,10"]) {
            SeaTalkMessageWindAngle seaTalkMessage = SeaTalkMessageWindAngle(message.seaTalkMessage());
            NSLog(@"Wind angle: %f", seaTalkMessage.windAngle());
        } else if ([NMEAMessage hasPrefix:@"$STSEA,84"]) {
            SeaTalkMessageCompassHeadingAutopilotCourseRudderPosition seaTalkMessage = SeaTalkMessageCompassHeadingAutopilotCourseRudderPosition(message.seaTalkMessage());
            NSLog(@"Autopilot heading: %d", seaTalkMessage.autopilotCourse());
            NSLog(@"Autopilot autoMode: %d", seaTalkMessage.isAutoMode());
        }
    }
}

@end

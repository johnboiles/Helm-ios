//
//  AppDelegate.h
//  Helm
//
//  Created by John Boiles on 3/21/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConnectionController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) ConnectionController *connectionController;

+ (AppDelegate *)sharedDelegate;

@end


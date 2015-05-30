//
//  AppStyle.m
//  Helm
//
//  Created by John Boiles on 5/29/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "AppStyle.h"
#import "HMButton.h"

@implementation AppStyle

+ (HMButton *)newButtonWithTitle:(NSString *)title {
    HMButton *button = [HMButton new];
    UIImage *backgroundImage = [[UIImage imageNamed:@"black_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (HMButton *)newRedButtonWithTitle:(NSString *)title {
    HMButton *button = [self newButtonWithTitle:title];
    UIImage *backgroundImage = [[UIImage imageNamed:@"red_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    return button;
}

@end

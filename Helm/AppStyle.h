//
//  AppStyle.h
//  Helm
//
//  Created by John Boiles on 5/29/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMButton;

@interface AppStyle : NSObject

+ (HMButton *)newButtonWithTitle:(NSString *)title;

+ (HMButton *)newRedButtonWithTitle:(NSString *)title;

@end

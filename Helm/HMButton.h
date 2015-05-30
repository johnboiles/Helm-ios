//
//  HMButton.h
//  Helm
//
//  Created by John Boiles on 3/24/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMButton : UIButton

@property (nonatomic, copy) void (^targetBlock)();

@end

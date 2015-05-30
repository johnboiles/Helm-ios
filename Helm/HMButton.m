//
//  HMButton.m
//  Helm
//
//  Created by John Boiles on 3/24/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "HMButton.h"

@implementation HMButton

- (void)setTargetBlock:(void (^)())targetBlock {
    _targetBlock = [targetBlock copy];
    [self removeTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUpInside {
    if (self.targetBlock) {
        self.targetBlock();
    }
}

@end

//
//  AutopilotView.h
//  Helm
//
//  Created by John Boiles on 5/29/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import <YOLayout/YOView.h>
@class HMButton;

@interface AutopilotView : YOView
@property (readonly) HMButton *minusOneButton;
@property (readonly) HMButton *plusOneButton;
@property (readonly) HMButton *minusTenButton;
@property (readonly) HMButton *plusTenButton;
@property (readonly) HMButton *standbyButton;
@property (readonly) HMButton *autoButton;
@end

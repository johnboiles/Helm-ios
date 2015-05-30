//
//  ControlsView.h
//  Helm
//
//  Created by John Boiles on 3/21/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import <YOLayout/YOView.h>
@class AutopilotView;
@class HeadingIndicatorView;

@interface ControlsView : YOView

@property (readonly) AutopilotView *autopilotView;
@property (readonly) HeadingIndicatorView *headingIndicatorView;

@end

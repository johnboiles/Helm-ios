//
//  HeadingIndicatorView.h
//  Helm
//
//  Created by John Boiles on 5/30/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import <YOLayout/YOView.h>

@interface HeadingIndicatorView : YOView

@property (readonly) UILabel *headingLabel;
@property (readonly) UILabel *speedLabel;
@property (nonatomic) BOOL autopilotHeadingHidden;

- (void)setWindDirection:(CGFloat)windDirection;

- (void)setAutopilotHeading:(CGFloat)autopilotHeading;

@end

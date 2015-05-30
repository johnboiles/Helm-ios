//
//  HeadingIndicatorView.m
//  Helm
//
//  Created by John Boiles on 5/30/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "HeadingIndicatorView.h"

@interface HeadingIndicatorView ()

@property UIImageView *windIndicatorView;
@property UIImageView *autopilotHeadingIndicatorView;
@property UILabel *headingLabel;
@property UILabel *speedLabel;
@end

@implementation HeadingIndicatorView

- (void)setRotationPoint:(CGPoint)rotationPoint forView:(UIView *)view {
    CGFloat minX = CGRectGetMinX(view.frame);
    CGFloat minY = CGRectGetMinY(view.frame);
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat height = CGRectGetHeight(view.frame);
    CGPoint anchorPoint = CGPointMake((rotationPoint.x - minX) / width, (rotationPoint.y - minY) / height);
    view.layer.anchorPoint = anchorPoint;
    view.layer.position = rotationPoint;
}

- (void)viewInit {
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heading_indicator.png"]];
    [self addSubview:backgroundView];

    self.windIndicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangle.png"]];
    [self addSubview:self.windIndicatorView];

    self.autopilotHeadingIndicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick_mark.png"]];
    [self addSubview:self.autopilotHeadingIndicatorView];
    
    self.headingLabel = [UILabel new];
    self.headingLabel.font = [UIFont fontWithName:@"Avenir-Black" size:20];
    self.headingLabel.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
    self.headingLabel.textAlignment = NSTextAlignmentCenter;
    self.headingLabel.numberOfLines = 0;
    self.headingLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.headingLabel.alpha = 1;
    [self addSubview:self.headingLabel];
    
    self.speedLabel = [UILabel new];
    self.speedLabel.font = [UIFont fontWithName:@"Avenir-Black" size:20];
    self.speedLabel.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
    self.speedLabel.textAlignment = NSTextAlignmentCenter;
    self.speedLabel.numberOfLines = 0;
    self.speedLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.speedLabel.alpha = 1;
    [self addSubview:self.speedLabel];
    
    __weak typeof(self) weakSelf = self;
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        CGSize backgroundViewSize = [layout setFrame:CGRectMake(0, 0, size.width, size.height) view:backgroundView options:YOLayoutOptionsSizeToFit].size;

        [layout setFrame:CGRectMake(0, -14, size.width, 0) view:weakSelf.windIndicatorView options:YOLayoutOptionsSizeToFit | YOLayoutOptionsAlignCenterHorizontal];

        [layout setFrame:CGRectMake(0, 0, size.width, 0) view:weakSelf.autopilotHeadingIndicatorView options:YOLayoutOptionsSizeToFit | YOLayoutOptionsAlignCenterHorizontal];

        if (![layout isSizing]) {
            [weakSelf setRotationPoint:CGPointMake(0, 0) forView:weakSelf.windIndicatorView];
            [weakSelf setRotationPoint:CGPointMake(0, 0) forView:weakSelf.autopilotHeadingIndicatorView];
        }

        [layout setFrame:CGRectMake(64, 73, 84, 23) view:weakSelf.headingLabel];

        [layout setFrame:CGRectMake(64, 119, 84, 23) view:weakSelf.speedLabel];

        return backgroundViewSize;
    }];
}

- (void)setWindDirection:(CGFloat)windDirection {
    CGFloat radians = -(windDirection / 360.0) * 2 * M_PI;
  
    CGFloat distanceToRotationPoint = self.frame.size.height / 2;
    CATransform3D rotation = CATransform3DMakeTranslation(distanceToRotationPoint, distanceToRotationPoint, 0.0);
    rotation = CATransform3DRotate(rotation, -radians, 0.0, 0.0, 1.0);
    rotation = CATransform3DTranslate(rotation, -distanceToRotationPoint, -distanceToRotationPoint, 0.0);
    
    self.windIndicatorView.layer.transform = rotation;
}

- (void)setAutopilotHeading:(CGFloat)autopilotHeading {
    CGFloat radians = -(autopilotHeading / 360.0) * 2 * M_PI;
    
    CGFloat distanceToRotationPoint = self.frame.size.height / 2;
    CATransform3D rotation = CATransform3DMakeTranslation(distanceToRotationPoint, distanceToRotationPoint, 0.0);
    rotation = CATransform3DRotate(rotation, -radians, 0.0, 0.0, 1.0);
    rotation = CATransform3DTranslate(rotation, -distanceToRotationPoint, -distanceToRotationPoint, 0.0);
    
    self.autopilotHeadingIndicatorView.layer.transform = rotation;
}

- (void)setAutopilotHeadingHidden:(BOOL)autopilotHeadingHidden {
    self.autopilotHeadingIndicatorView.hidden = autopilotHeadingHidden;
}

@end

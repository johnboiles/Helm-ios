//
//  AutopilotView.m
//  Helm
//
//  Created by John Boiles on 5/29/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "AutopilotView.h"
#import "AppStyle.h"
#import "HMButton.h"

@interface AutopilotView ()
@property HMButton *minusOneButton;
@property HMButton *plusOneButton;
@property HMButton *minusTenButton;
@property HMButton *plusTenButton;
@property HMButton *standbyButton;
@property HMButton *autoButton;
@end

@implementation AutopilotView

- (void)viewInit {
    // OK so maybe this is a bit hokie
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"autopilot.png"]];
    [self addSubview:backgroundView];

    self.minusOneButton = [AppStyle newButtonWithTitle:nil];
    [self addSubview:self.minusOneButton];

    self.plusOneButton = [AppStyle newButtonWithTitle:nil];
    [self addSubview:self.plusOneButton];

    self.minusTenButton = [AppStyle newButtonWithTitle:nil];
    [self addSubview:self.minusTenButton];

    self.plusTenButton = [AppStyle newButtonWithTitle:nil];
    [self addSubview:self.plusTenButton];

    self.standbyButton = [AppStyle newRedButtonWithTitle:nil];
    [self addSubview:self.standbyButton];

    self.autoButton = [AppStyle newRedButtonWithTitle:nil];
    [self addSubview:self.autoButton];
    
    __weak typeof(self) weakSelf = self;
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        CGSize backgroundViewSize = [layout setFrame:CGRectMake(0, 0, size.width, size.height) view:backgroundView options:YOLayoutOptionsSizeToFit].size;

        [layout setFrame:CGRectMake(83, 117, 69, 44) view:weakSelf.minusOneButton];

        [layout setFrame:CGRectMake(194, 117, 69, 44) view:weakSelf.plusOneButton];

        [layout setFrame:CGRectMake(83, 184, 69, 44) view:weakSelf.minusTenButton];

        [layout setFrame:CGRectMake(194, 184, 69, 44) view:weakSelf.plusTenButton];

        [layout setFrame:CGRectMake(83, 251, 69, 44) view:weakSelf.standbyButton];

        [layout setFrame:CGRectMake(194, 251, 69, 44) view:weakSelf.autoButton];

        return backgroundViewSize;
    }];
}

@end

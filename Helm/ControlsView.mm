//
//  ControlsView.m
//  Helm
//
//  Created by John Boiles on 3/21/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "ControlsView.h"
#import "HMButton.h"
#import "NMEAMessage.h"
#import "AppDelegate.h"
#import "ConnectionController.h"
#import "AutopilotView.h"

@interface ControlsView ()
//@property UIButton *lampButton;
@property NSMutableArray *buttons;
@end

@implementation ControlsView

- (HMButton *)newButtonWithTitle:(NSString *)title {
    HMButton *button = [HMButton new];
    UIImage *backgroundImage = [[UIImage imageNamed:@"black_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (void)viewInit {
    self.backgroundColor = [UIColor colorWithRed:0.86 green:0.88 blue:0.89 alpha:1];

    AutopilotView *autopilotView = [AutopilotView new];
    [self addSubview:autopilotView];
    
    autopilotView.minusOneButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,861105FA*0B\r\n"];
    };
    autopilotView.plusOneButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,861107F8*0B\r\n"];
    };
    autopilotView.minusTenButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,861106F9*0B\r\n"];
    };
    autopilotView.plusTenButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,861108F7*0B\r\n"];
    };
    autopilotView.autoButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,862101FE*73\r\n"];
    };
    autopilotView.standbyButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,862102FD*71\r\n"];
    };

    HMButton *lampOnButton = [self newButtonWithTitle:@"Lamp On"];
    lampOnButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,30000C*0C\r\n"];
    };
    [self addSubview:lampOnButton];

    HMButton *lampOffButton = [self newButtonWithTitle:@"Lamp Off"];
    lampOffButton.targetBlock = ^{
        [[AppDelegate sharedDelegate].connectionController sendMessage:@"$STSEA,300000*7F\r\n"];
    };
    [self addSubview:lampOffButton];
    
    __weak typeof(self) weakSelf = self;
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        CGFloat x = 10;
        CGFloat y = 10 + 64;
        
        CGRect autopilotRect = [layout setFrame:CGRectMake(0, y, size.width, 0) view:autopilotView options:YOLayoutOptionsSizeToFit | YOLayoutOptionsAlignCenterHorizontal];
        x = autopilotRect.origin.x;
        y += autopilotRect.size.height;
        y += 10;
        
        x += [layout setFrame:CGRectMake(x, y, 100, 50) view:lampOnButton].size.width;
        x += 10;

        [layout setFrame:CGRectMake(x, y, 100, 50) view:lampOffButton];
        return size;
    }];
}

- (void)buttoDidTap:(UIButton *)button {
    
}

@end

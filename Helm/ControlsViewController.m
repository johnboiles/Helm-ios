//
//  ControlsViewController.m
//  Helm
//
//  Created by John Boiles on 3/21/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "ControlsViewController.h"
#import "ControlsView.h"

@interface ControlsViewController ()
@property ControlsView *contentView;
@end

@implementation ControlsViewController

- (void)loadView {
    self.contentView = [[ControlsView alloc] init];
    self.view = self.contentView;
}

@end

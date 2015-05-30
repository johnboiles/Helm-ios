//
//  ConnectionController.h
//  Helm
//
//  Created by John Boiles on 3/24/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ConnectionController;

@protocol ConnectionControllerDelegate <NSObject>
- (void)connectionController:(ConnectionController *)connectionController didGetNMEAMessage:(NSString *)NMEAMessage;
@end

@interface ConnectionController : NSObject

@property (weak) id<ConnectionControllerDelegate> delegate;
@property (readonly, getter=isConnected) BOOL connected;

- (void)connectToHost:(NSString *)host port:(uint16_t)port;

- (void)sendMessage:(NSString *)message;

@end

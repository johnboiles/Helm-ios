//
//  ConnectionController.m
//  Helm
//
//  Created by John Boiles on 3/24/15.
//  Copyright (c) 2015 johnboiles. All rights reserved.
//

#import "ConnectionController.h"
#import <GCDAsyncSocket.h>
#import "NMEAParser.h"

@interface ConnectionController () {}
@property GCDAsyncSocket *socket;
@property NMEAParser *parser;
@end

@implementation ConnectionController

- (id)init {
    self = [super init];
    if (self) {
        self.parser = new NMEAParser();
    }
    return self;
}

- (void)connectToHost:(NSString *)host port:(uint16_t)port {
    NSError *error = nil;
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    if (![self.socket connectToHost:host onPort:port error:&error]) {
        NSLog(@"Error opening socket: %@", error);
    }
}

- (BOOL)isConnected {
    return self.socket.isConnected;
}

- (void)sendMessage:(NSString *)message {
    NSData *data = [message dataUsingEncoding:NSASCIIStringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:0];
}

#pragma mark GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(UInt16)port {
    [socket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)socket didReadData:(NSData *)data withTag:(long)tag {
    [socket readDataWithTimeout:-1 tag:0];
    for (NSInteger i = 0; i < data.length; i++) {
        bool gotMessage = self.parser->parse(((char *)data.bytes)[i]);
        if (gotMessage) {
            NSString *NMEAMessage = [[NSString alloc] initWithBytes:self.parser->message() length:self.parser->messageLength() encoding:NSASCIIStringEncoding];
            [self.delegate connectionController:self didGetNMEAMessage:NMEAMessage];
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"Wrote data");
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"Socket disconnect");
}

- (void)socket:(GCDAsyncSocket *)socket didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    [socket readDataWithTimeout:-1 tag:0];
    NSLog(@"Got new socket");
}

@end

//
//  NetWorkingManager.m
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/14.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "NetWorkingManager.h"

static NetWorkingManager * _manager = nil;

@implementation NetWorkingManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (!_manager) {
            [self configManager];
        }
    });
    return _manager;
}

+ (void)configManager{
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPMaximumConnectionsPerHost = 10;
    sessionConfiguration.timeoutIntervalForRequest = 10;

    _manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:@""] sessionConfiguration:sessionConfiguration];
}

@end

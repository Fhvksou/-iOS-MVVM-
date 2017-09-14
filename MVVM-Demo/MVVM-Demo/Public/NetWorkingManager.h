//
//  NetWorkingManager.h
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/14.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetWorkingManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end

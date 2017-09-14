//
//  TestListViewModel.h
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/8.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestListViewModel : NSObject

@property (nonatomic ,strong) RACCommand * requestDataCommand;

@property (nonatomic ,strong) RACSubject * updateViewsSubject;

@property (nonatomic ,strong) RACSubject * pushSubject;

@end

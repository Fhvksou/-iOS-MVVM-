//
//  TestListViewModel.m
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/8.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "TestListViewModel.h"
#import "TestModel.h"

#define kNet_Limit @"http://iappfree.candou.com:8080/free/applications/limited"

@interface TestListViewModel ()

@property (nonatomic ,strong) NSMutableArray * dataArr;

@end

@implementation TestListViewModel

- (instancetype)init{
    if (self = [super init]) {
        // 订阅数据请求完毕的信号
        @weakify(self);
        [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray * x) {
            @strongify(self);
            // 发送更新UI的信号
            [self.updateViewsSubject sendNext:x];
        }];
    }
    return self;
}

#pragma mark lazyLoad
// 注册信号
- (RACSubject *)updateViewsSubject{
    if (!_updateViewsSubject) {
        _updateViewsSubject = [RACSubject subject];
    }
    return _updateViewsSubject;
}

- (RACSubject *)pushSubject{
    if (!_pushSubject) {
        _pushSubject = [RACSubject subject];
    }
    return _pushSubject;
}

- (RACCommand *)requestDataCommand{
    if (!_requestDataCommand) {

        _requestDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {

            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                // 请求数据
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                [dic setObject:@"rmb" forKey:@"currency"];
                [dic setObject:@"1" forKey:@"page"];
                
                NetWorkingManager * manager = [NetWorkingManager sharedManager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                [manager GET:kNet_Limit parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSError *jsonError;
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError ];
                    if (jsonError == nil ) {
                        NSLog(@"返回数据 ----- %@",[DataTurn toJSONData:dict]);
                        NSMutableArray * data = [DataTurn getObjArrByJsonStr:[dict objectForKey:@"applications"] ClassName:@"TestModel"];
                        //数据接收完成，发送信号
                        [subscriber sendNext:data];
                    }
                    [subscriber sendCompleted];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

@end

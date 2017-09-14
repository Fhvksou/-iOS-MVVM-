//
//  TestCellViewModel.m
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "TestCellViewModel.h"
#import "TestModel.h"

@interface TestCellViewModel ()

@end

@implementation TestCellViewModel

- (instancetype)init{
    if (self = [super init]) {
        @weakify(self);
        [self.updateDataSubject subscribeNext:^(id x) {
            @strongify(self);
            TestModel * model = (TestModel *)x;
            self.iconUrl = model.iconUrl;
            self.name = model.name;
            self.shares = [NSString stringWithFormat:@"分享：%@",model.shares];
            self.favorites = [NSString stringWithFormat:@"收藏：%@",model.favorites];
            self.downloads = [NSString stringWithFormat:@"下载：%@",model.downloads];
            self.updateDate = model.updateDate;
        }];
    }
    return self;
}

- (RACSubject *)updateDataSubject{
    if (!_updateDataSubject) {
        _updateDataSubject = [RACSubject subject];
    }
    return _updateDataSubject;
}

@end

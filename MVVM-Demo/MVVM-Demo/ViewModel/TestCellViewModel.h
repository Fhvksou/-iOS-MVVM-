//
//  TestCellViewModel.h
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestCellViewModel : NSObject

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString * iconUrl;

@property (nonatomic ,copy) NSString *shares;

@property (nonatomic ,copy) NSString *favorites;

@property (nonatomic ,copy) NSString *downloads;

@property (nonatomic ,copy) NSString *updateDate;

@property (nonatomic ,strong) RACSubject * updateDataSubject;

@property (nonatomic ,strong) UIImage * iconImage;

@end

//
//  TestListView.h
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/8.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestListViewModel.h"

@interface TestListView : UIView

- (instancetype)initWithFrame:(CGRect)frame ViewModel:(TestListViewModel *)viewModel;

@end

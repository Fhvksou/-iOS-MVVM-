//
//  TestTableViewCell.h
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCellViewModel.h"

@interface TestTableViewCell : UITableViewCell

@property (nonatomic ,strong) TestCellViewModel * viewModel;

@end

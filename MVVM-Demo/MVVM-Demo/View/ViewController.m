//
//  ViewController.m
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/7.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//                     郑力铭喜欢的
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..

#import "ViewController.h"
#import "TestListView.h"
#import "TestListViewModel.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic ,strong) TestListView * testVc;
@property (nonatomic ,strong) TestListViewModel * viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.testVc];
        
    @weakify(self);
    // 订阅跳转页面的信号
    [self.viewModel.pushSubject subscribeNext:^(id x) {
        @strongify(self);
        DetailViewController * vc = [[DetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark LazyLoad

- (TestListView *)testVc{
    if (!_testVc) {
        _testVc = [[TestListView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) ViewModel:self.viewModel];
    }
    return _testVc;
}

- (TestListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[TestListViewModel alloc]init];
    }
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

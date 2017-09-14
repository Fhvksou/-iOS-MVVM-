//
//  DetailViewController.m
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "DetailViewController.h"
#import "TestListView.h"
#import "TestListViewModel.h"

@interface DetailViewController ()

@property (nonatomic ,strong) TestListView * testVc;
@property (nonatomic ,strong) TestListViewModel * viewModel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.testVc];
    
    // 订阅跳转页面的信号
    [self.viewModel.pushSubject subscribeNext:^(id x) {
//        DetailViewController * vc = [[DetailViewController alloc]init];
//        [self_weak_.navigationController pushViewController:vc animated:YES];
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

- (void)dealloc{
    NSLog(@"释放成功");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

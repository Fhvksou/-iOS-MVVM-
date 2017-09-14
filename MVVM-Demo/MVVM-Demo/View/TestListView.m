//
//  TestListView.m
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/8.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "TestListView.h"
#import "TestTableViewCell.h"

#define kViewHeight self.frame.size.height
#define kViewWidth self.frame.size.width

@interface TestListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) TestListViewModel * viewModel;
@property (nonatomic ,strong) NSMutableArray * data;

@end

@implementation TestListView

- (instancetype)initWithFrame:(CGRect)frame ViewModel:(TestListViewModel *)viewModel{
    if (self = [super initWithFrame:frame]) {
        _viewModel = viewModel;
        [self addSubview:self.tableView];
        
        // 发送信号去请求数据
        [self.viewModel.requestDataCommand execute:nil];

        // 订阅更新UI的信号
        @weakify(self);
        [self.viewModel.updateViewsSubject subscribeNext:^(NSMutableArray * x) {
            @strongify(self);
            [self.data addObjectsFromArray:x];
            [self.tableView reloadData];
        }];
        
    }
    return self;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 发送跳转信号
    [self.viewModel.pushSubject sendNext:nil];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"ZHENGLIMINGDASHABI";
    TestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[TestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.viewModel.updateDataSubject sendNext:[self.data objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark lazyLoad

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [[NSMutableArray alloc]init];
    }
    return _data;
}

@end

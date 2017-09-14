//
//  TestTableViewCell.m
//  MVVM-Demo
//
//  Created by fhkvsou on 17/9/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell ()

@property (nonatomic ,strong) UIImageView * iconImageVc;
@property (nonatomic ,strong) UILabel * title;
@property (nonatomic ,strong) UILabel * shares;
@property (nonatomic ,strong) UILabel * collections;
@property (nonatomic ,strong) UILabel * downLoads;
@property (nonatomic ,strong) UILabel * date;

@end

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
        
        RAC(self.title,text) = RACObserve(self, self.viewModel.name);
        
        RAC(self.shares,text) = RACObserve(self, self.viewModel.shares);
        
        RAC(self.collections,text) = RACObserve(self, self.viewModel.favorites);
        
        RAC(self.downLoads,text) = RACObserve(self, self.viewModel.downloads);
        
        RAC(self.date,text) = RACObserve(self, self.viewModel.updateDate);
        
        @weakify(self);
        RAC(self.iconImageVc,tag) = [RACObserve(self, self.viewModel.iconUrl) map:^id(NSString * value) {
            @strongify(self);
            [self.iconImageVc sd_setImageWithURL:[NSURL URLWithString:value]];
            return @1;
        }];
    }
    return self;
}

- (void)initViews{
    _iconImageVc = [[UIImageView alloc]init];
    _iconImageVc.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_iconImageVc];
    
    _title = [[UILabel alloc]init];
    _title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_title];
    
    _shares = [[UILabel alloc]init];
    _shares.textAlignment = NSTextAlignmentCenter;
    _shares.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_shares];

    _collections = [[UILabel alloc]init];
    _collections.textAlignment = NSTextAlignmentCenter;
    _collections.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_collections];

    _downLoads = [[UILabel alloc]init];
    _downLoads.textAlignment = NSTextAlignmentCenter;
    _downLoads.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_downLoads];
    
    _date = [[UILabel alloc]init];
    _date.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_date];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _iconImageVc.frame = CGRectMake(15, 15, self.frame.size.height - 50, self.frame.size.height - 50);
    _title.frame = CGRectMake(CGRectGetMaxX(_iconImageVc.frame) + 15, 15, self.frame.size.width - 15 - self.frame.size.height + 50 - 15, 20);
    
    _shares.frame = CGRectMake(15, CGRectGetMaxY(_iconImageVc.frame) + 5, (self.frame.size.width - 30) / 3, 20);
    
    _collections.frame = CGRectMake(CGRectGetMaxX(_shares.frame), CGRectGetMaxY(_iconImageVc.frame) + 5, (self.frame.size.width - 30) / 3, 20);
    _downLoads.frame = CGRectMake(CGRectGetMaxX(_collections.frame), CGRectGetMaxY(_iconImageVc.frame) + 5, (self.frame.size.width - 30) / 3, 20);
    
    _date.frame = CGRectMake(CGRectGetMaxX(_iconImageVc.frame) + 15, CGRectGetMaxY(_title.frame) + 5, self.frame.size.width - 30 - CGRectGetMaxX(_iconImageVc.frame) - 15, 20);
}

- (TestCellViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[TestCellViewModel alloc]init];
    }
    return _viewModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

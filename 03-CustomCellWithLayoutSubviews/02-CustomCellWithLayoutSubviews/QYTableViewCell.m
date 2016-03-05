//
//  QYTableViewCell.m
//  02-CustomCellWithLayoutSubviews
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTableViewCell.h"

@interface QYTableViewCell ()
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@end

@implementation QYTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *items = @[@"first",@"second"];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        [self.contentView addSubview:segmentedControl];
        _segmentControl = segmentedControl;
    }
    return self;
}


// 继承UITableViewCell，在子类实现的时候重写子视图布局方法
// 记住要在继承的时候改写原有子视图的布局，直接在使用的时候改写布局无效
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(10, 10, 200, 40);
    self.detailTextLabel.frame = CGRectMake(10, 50, 200, 40);
    self.imageView.frame = CGRectMake(375 - 10 - 80, 10, 80, 80);
    _segmentControl.frame = CGRectMake(200, 40, 80, 20);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

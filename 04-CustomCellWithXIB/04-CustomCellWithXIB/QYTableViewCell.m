//
//  QYTableViewCell.m
//  04-CustomCellWithXIB
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYModel.h"
@implementation QYTableViewCell


-(void)setModel:(QYModel *)model{
    _model = model;
    
    self.titleLabel.text = model.name;
    self.detailTitleLabel.text = model.sex;
    self.sw.on = model.ison;
    self.imgView.image = [UIImage imageNamed:model.icon];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

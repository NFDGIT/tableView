//
//  QYTableViewCell.h
//  05-CustomCellWithSB
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYModel;
@interface QYTableViewCell : UITableViewCell
@property (nonatomic, strong) QYModel *model;
@end

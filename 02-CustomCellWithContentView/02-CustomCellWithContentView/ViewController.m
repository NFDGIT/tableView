//
//  ViewController.m
//  02-CustomCellWithContentView
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

-(void)configDatas{
    _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tianqi"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configDatas];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 100;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //在contentView上添加子视图，来自定单元格
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
        [cell.contentView addSubview:titleLabel];
        titleLabel.tag = 101;
        
        UILabel *detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), CGRectGetHeight(titleLabel.frame))];
        [cell.contentView addSubview:detailTitleLabel];
        detailTitleLabel.tag = 102;
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(tableView.frame) - 10 - 80, 10, 80, 80)];
        [cell.contentView addSubview:iconView];
        iconView.tag = 103;
    }
    
    UILabel *titleLabel = [cell.contentView viewWithTag:101];
    UILabel *detailTitleLabel = [cell.contentView viewWithTag:102];
    UIImageView *iconView = [cell.contentView viewWithTag:103];
    
    titleLabel.text = self.datas[indexPath.row];
    detailTitleLabel.text = self.datas[indexPath.row];
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row];
    iconView.image = [UIImage imageNamed:iconName];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

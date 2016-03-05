//
//  ViewController.m
//  02-CustomCellWithLayoutSubviews
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "QYTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tianqi"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    //设置代理和数据源
    tableView.delegate = self;
    tableView.dataSource = self;
    //行高
    tableView.rowHeight = 100;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.datas[indexPath.row];
    cell.detailTextLabel.text = self.datas[indexPath.row];
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:iconName];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

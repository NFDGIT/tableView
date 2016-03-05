//
//  ViewController.m
//  01-UITableViewCellDemo
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController
static NSString *qyIdentifier = @"qycell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tianqi"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    //设置数据源和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.rowHeight = 80;
    
    //注册单元格（从重用队里里取Cell的时候，如果为nil，自动创建一个新Cell）
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:qyIdentifier];
    
    tableView.allowsMultipleSelection = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//组中行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#if 1
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:indexPath.row % 4 reuseIdentifier:identifier];
        //选中的风格
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //背景
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:0.6944 green:0.8196 blue:0.2246 alpha:0.5];
        cell.backgroundView = bgView;
        
        //多选时背景
        UIView *selectedBgView = [[UIView alloc] init];
        selectedBgView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.8];
        cell.multipleSelectionBackgroundView = selectedBgView;
        
        //辅助视图
        //cell.accessoryType = indexPath.row % 5;
        UISwitch *sw = [[UISwitch alloc] init];
        cell.accessoryView = sw;
        
    }
#else
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:qyIdentifier forIndexPath:indexPath];
#endif
    
    cell.textLabel.text = self.datas[indexPath.row];
    cell.detailTextLabel.text = @"这个人有点懒";
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:iconName];
    
    //更改imageView的frame
    CGRect iconFrame = cell.imageView.frame;
    iconFrame.origin.x += 200;
    cell.imageView.frame = iconFrame;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"section:%ld",section];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

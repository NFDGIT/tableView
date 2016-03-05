//
//  ViewController.m
//  04-CustomCellWithXIB
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "QYModel.h"
#import "QYTableViewCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController
static NSString *identifier = @"cell";
//懒加载datas
-(NSArray *)datas{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"datas" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYModel *model = [QYModel modelWithDictionary:dict];
            [models addObject:model];
        }
        _datas = models;
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    //设置数据源和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.rowHeight = 100;
    //注册单元格
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITableViewDataSource
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
#if 0
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"QYTableViewCell" owner:self options:nil];
        cell = views.firstObject;
    }
    
#else
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
#endif
    
    QYModel *model = self.datas[indexPath.row];
    
#if 0
    cell.titleLabel.text = model.name;
    cell.detailTitleLabel.text = model.sex;
    cell.sw.on = model.ison;
    cell.imgView.image = [UIImage imageNamed:model.icon];
#else
    cell.model = model;
#endif
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

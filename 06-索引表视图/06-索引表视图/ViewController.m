//
//  ViewController.m
//  06-索引表视图
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *keys;            //索引
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
static NSString *identifier = @"indexCell";

-(NSDictionary *)dict{
    if (_dict == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
        _dict = [NSDictionary dictionaryWithContentsOfFile:path];
        //取出_dict中所有的键（按顺序排列）
        _keys = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //取出当前section对应的key
    NSString *key = _keys[section];
    //根据key获取section对应的array
    NSArray *array = self.dict[key];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //取出当前section对应的key
    NSString *key = _keys[indexPath.section];
    //根据key获取section对应的array
    NSArray *array = self.dict[key];
    
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

//section的头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _keys[section];
}

//设置索引
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _keys;
}

//当点击索引的时候返回索引
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

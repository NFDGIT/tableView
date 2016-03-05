//
//  ViewController.m
//  07-编辑表视图
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSArray *keys;            //索引
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
static NSString *identifier = @"indexCell";

-(NSMutableDictionary *)dict{
    if (_dict == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
        _dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        //取出_dict中所有的键（按顺序排列）
        _keys = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加rightBarBtnItem
    UIBarButtonItem *rightBarbtnItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = rightBarbtnItem;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)editAction:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        [_tableView setEditing:YES animated:YES];
    }else{
        [_tableView setEditing:NO animated:YES];
        item.title = @"编辑";
    }
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

#pragma mark -编辑（添加和删除）

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//指定编辑样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2) {
        return UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

//提交编辑（注意：更改的时候 数据层面 和 UI层面）
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出当前section对应的key
    NSString *key = _keys[indexPath.section];
    //根据key获取section对应的array
    NSMutableArray *array = self.dict[key];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        //数据源
        [array removeObjectAtIndex:indexPath.row];
        //UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        //插入
        //数据
        [array insertObject:@"青云1512最棒" atIndex:indexPath.row];
        //UI
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark -编辑（移动）

//允许移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//移动单元格
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath{
    
    //取出源单元格所在的section的数据
    //取出当前section在字典中的对应的key
    NSString *sourceKey = self.keys[sourceIndexPath.section];
    //取出当前section对应的数组
    NSMutableArray *sourceArray = self.dict[sourceKey];
    //取出当前移动的单元格对应的数据
    NSString *sourceString = sourceArray[sourceIndexPath.row];
    //把(新娘)从数组中移除
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    
    //取出目标的单元格所在的section的数组
    //取出目标section在字典中的对应的键
    NSString *destinationKey = self.keys[destinationIndexPath.section];
    //取出目标section的数组
    NSMutableArray *destinationArray = self.dict[destinationKey];
    //把（新娘）放进数据
    [destinationArray insertObject:sourceString atIndex:destinationIndexPath.row];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row + 1 inSection:proposedDestinationIndexPath.section];
}

//rowAction
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *rowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
    }];
    rowAction1.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    
    UITableViewRowAction *rowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"标记未读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"标记未读");
        tableView.editing = NO;
    }];
    
    rowAction2.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.5];
    return @[rowAction1,rowAction2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  QYModel.m
//  04-CustomCellWithXIB
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYModel.h"

@implementation QYModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
@end

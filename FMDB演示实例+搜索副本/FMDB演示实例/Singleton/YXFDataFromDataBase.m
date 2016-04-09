//
//  YXFDataFromDataBase.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/17.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import "YXFDataFromDataBase.h"

@implementation YXFDataFromDataBase

+ (YXFDataFromDataBase *)shareFromDataBase
{
    static YXFDataFromDataBase *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (sharedInstance == nil) {
            sharedInstance = [[YXFDataFromDataBase alloc] init];
        }
        
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _nameFromClass = @"";
        _ageFromClass = @"";
        _IDFromClass = @"";
        _nameArrayFromClass = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end

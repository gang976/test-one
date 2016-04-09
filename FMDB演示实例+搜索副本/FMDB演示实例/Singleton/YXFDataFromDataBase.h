//
//  YXFDataFromDataBase.h
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/17.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXFDataFromDataBase : NSObject

@property(retain,nonatomic) NSString *nameFromClass;

@property(retain,nonatomic)NSString *ageFromClass;

@property(retain,nonatomic)NSString *IDFromClass;

@property(retain,nonatomic)NSMutableArray *nameArrayFromClass;

+(YXFDataFromDataBase *)shareFromDataBase;

@end

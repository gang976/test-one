//
//  YXFAddUserViewController.h
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/17.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXFAddUserViewController : UIViewController

{
    NSInteger operateType1;//保存操作类型，0是添加，1是修改
}
@property (nonatomic, strong) NSMutableArray *textFieldArray;

@property (nonatomic, strong) NSString *dbPath;

@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UITextField *ageTextField;

@property (nonatomic, strong) UITextField *IDTextField;

@property (nonatomic, assign) NSInteger operateType;

@end

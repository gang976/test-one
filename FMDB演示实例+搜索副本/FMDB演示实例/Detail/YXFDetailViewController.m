//
//  YXFDetailViewController.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/18.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import "YXFDetailViewController.h"

#import "FMDatabase.h"
#import "XFNotices.h"

@interface YXFDetailViewController ()

@end

@implementation YXFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"详细信息";
    NSArray *array = [NSArray arrayWithObjects:@"姓名:",@"年龄:",@"ID:", nil];
    NSArray *array2 = [NSArray arrayWithObjects:self.nameStr,self.ageStr,self.IDsStr, nil];
    
    for (int i = 0; i < 3 ; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( 70,i * 40 + 134, 100, 30)];
        label.text = [array objectAtIndex:i];
        [self.view addSubview:label];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(140, i * 40 +135, 100, 30)];
        label2.text = [array2 objectAtIndex:i];
        [self.view addSubview:label2];
    }
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:@"USER.sqlite"];
    self.dbpath = path;
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteFromDatabase)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
}

- (void)deleteFromDatabase//从数据库删除信息
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbpath];
    if ([db open]) {
        NSString *sql = @"DELETE FROM USER WHERE name = ? and age = ? and idcode = ?";
        if (self.nameStr.length != 0&&self.ageStr.length != 0&&self.IDsStr.length !=0){
            BOOL rs = [db executeUpdate:sql,self.nameStr,self.ageStr,self.IDsStr]; //后面跟的三个参数就是sql语句里的三个问号对应
            if (rs) {
                [XFNotices noticesWithTitle:@"删除成功" Time:1 View:self.view Style:(XFNoticesStyleSuccess)];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [XFNotices noticesWithTitle:@"删除失败" Time:1 View:self.view Style:(XFNoticesStyleFail)];
            }
        }
    }
    [db close];
}


@end

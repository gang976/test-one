//
//  YXFAddressViewController.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/17.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import "YXFAddressViewController.h"
#import "XFNotices.h"
#import "FMDatabase.h"

#import "FMDatabaseQueue.h"

#import "YXFAddressViewCell.h"

#import "YXFDataFromDataBase.h"

#import "YXFAddUserViewController.h"

@interface YXFAddressViewController ()

@end

@implementation YXFAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[YXFAddressViewCell class] forCellReuseIdentifier:@"cell"];
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(modifyDatabase)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:@"USER.sqlite"];
    self.paths = path;
//注意以上三句话是获取数据库路径必不可少的，在viewDidload之前就已经准备好了
    self.nameArray = [[NSMutableArray alloc]init];
    self.ageArray = [[NSMutableArray alloc]init];
    self.IDArray = [[NSMutableArray alloc]init];
    [self createTable];
    [self getAllDatabase];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count + 1;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return nil;
    }else
    {
        return indexPath;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXFAddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (indexPath.row == 0) {
        cell.nameLabel.text = @"姓名";
        cell.ageLabel.text = @"年龄";
        cell.ID.text = @"ID";
    }else
    {
        cell.nameLabel.text = [self.nameArray objectAtIndex:indexPath.row -1];
        cell.ageLabel.text = [self.ageArray objectAtIndex:indexPath.row - 1];
        cell.ID.text = [self.IDArray objectAtIndex:indexPath.row - 1];
    }
    
    
    return cell;
}

- (void)createTable
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.paths]) {
        NSLog(@"表不存在，创建表");
        FMDatabase *db =[FMDatabase databaseWithPath:self.paths];
        if ([db open]) {
            NSString *sql = @"CREATE TABLE 'USER'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(20),'age' VARCHAR(20),'idcode' VARCHAR(30))    ";//sql语句
            BOOL success = [db executeUpdate:sql];
            if (!success) {
                NSLog(@"error when create table ");
            }else{
                NSLog(@"create table succeed");
            }
            [db close];
        }else{
            NSLog(@"database open error");
        }
    }
}

- (void)getAllDatabase//从数据库中获得所有数据
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.paths];
    if ([db open]) {
        NSString *sql = @"SELECT * FROM USER";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            NSString *age = [rs stringForColumn:@"age"];
            NSString *ID = [rs stringForColumn:@"idcode"];
            
            [self.nameArray addObject:name];
            [self.ageArray addObject:age];
            [self.IDArray addObject:ID];
        }
        [[YXFDataFromDataBase shareFromDataBase].nameArrayFromClass arrayByAddingObjectsFromArray:self.nameArray];
        NSLog(@"self.nameArray==%@",self.nameArray);
        [db close];
        [self.tableView reloadData];
    }
    
}

//选中相应的行，进入更新界面，注意这里没有对数据库进行操作
- (void)modifyDatabase
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if (indexPath == nil) {

        [XFNotices noticesWithTitle:@"数据更新" Time:1.5 View:self.view Style:(XFNoticesStyleSuccess)];
        
        return;
    }
    else{
        YXFAddUserViewController *addUser = [[YXFAddUserViewController alloc]init];
        addUser.operateType = 1;
        //下面的方法是将选中的行的数据存进单例，再传到另一个类里面
        [YXFDataFromDataBase shareFromDataBase].nameFromClass = [self.nameArray objectAtIndex:(indexPath.row-1)];
        [YXFDataFromDataBase shareFromDataBase].IDFromClass = [self.IDArray objectAtIndex:(indexPath.row-1)];
        [YXFDataFromDataBase shareFromDataBase].ageFromClass = [self.ageArray objectAtIndex:(indexPath.row-1)];
        NSLog(@"datafromdatabase.nameFromClass==%@",[YXFDataFromDataBase shareFromDataBase].nameFromClass);
        //跳转到修改页面
        [self.navigationController pushViewController:addUser animated:YES];
    }
}


@end

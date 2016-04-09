//
//  YXFAddUserViewController.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/17.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import "YXFAddUserViewController.h"

#import "YXFDataFromDataBase.h"
#import "FMDatabase.h"
#import "XFNotices.h"

@interface YXFAddUserViewController () <UITextFieldDelegate>

@end

@implementation YXFAddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [doc stringByAppendingPathComponent:@"user.sqlite"];
    NSLog(@"path===%@",path);
    self.dbPath = path;
    
    NSArray *array = [NSArray arrayWithObjects:@"姓名",@"年龄",@"ID", nil];
    for (int i = 0; i < 3 ; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( 70,i * 40 + 134, 100, 30)];
        label.text = [array objectAtIndex:i];
        [self.view addSubview:label];
    }
    
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 138, 100, 30)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.delegate = self;
    [self.view addSubview:_nameTextField];
    _ageTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 178, 100, 30)];
    _ageTextField.borderStyle = UITextBorderStyleRoundedRect;
    _ageTextField.placeholder = @"请输入年龄";
    _ageTextField.delegate = self;
    [self.view addSubview:_ageTextField];
    _IDTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 218, 100, 30)];
    _IDTextField.borderStyle = UITextBorderStyleRoundedRect;
    _IDTextField.placeholder = @"请输入ID";
    _IDTextField.delegate = self;
    [self.view addSubview:_IDTextField];
    if (_operateType == 1) {//operateType == 1时为修改
        
        _nameTextField.text = [YXFDataFromDataBase shareFromDataBase].nameFromClass;
        _IDTextField.text = [YXFDataFromDataBase shareFromDataBase].IDFromClass;
        _ageTextField.text = [YXFDataFromDataBase shareFromDataBase].ageFromClass;
        _IDTextField.enabled = NO;
        NSLog(@"datafromdatabase.nameFromClass=%@",[YXFDataFromDataBase shareFromDataBase].nameFromClass);
        
    }
    NSLog(@"operateType==%ld",operateType1);
    if (_operateType == 0){
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewUserInfo)];
        self.navigationItem.rightBarButtonItem = addBtn;
    }
    if(_operateType == 1){//这里是后来添加的，其实可以放到上面
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addNewUserInfo)];
        self.navigationItem.rightBarButtonItem = addBtn;
        
    }
    
}

//添加详细信息
- (void)addNewUserInfo
{
    FMDatabase *db = [[FMDatabase alloc]initWithPath:self.dbPath];
    if ([db open]) {
        
        if (_nameTextField.text.length == 0||_ageTextField.text.length == 0||_IDTextField.text.length == 0){
            
            [XFNotices noticesWithTitle:@"请完成填写信息" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
        }else{
            NSLog(@"姓名==%@,年龄==%@,ID==%@",_nameTextField.text,_ageTextField.text,_IDTextField.text);
            NSString *sql= nil;
            if (self.operateType == 0){//执行插入操作
                sql = @"INSERT INTO USER (name,age,idcode) VALUES (?,?,?) ";
            }else if(_operateType == 1)//执行更新操作
            {
                sql = @"UPDATE USER  SET name = ? , age = ? where idcode = ?";
                
            }
            
            BOOL res = [db executeUpdate:sql,_nameTextField.text,_ageTextField.text,_IDTextField.text];
            if (!res) {
                [XFNotices noticesWithTitle:@"数据插入错误" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
            }else{
                [XFNotices noticesWithTitle:@"数据插入成功" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
            }
        }
    }else{
        NSLog(@"数据库打开失败") ;
    }
    if (operateType1 == 0)//如果是添加就留在该页，如果是修改就跳回上一页
    {
        [_nameTextField resignFirstResponder];
        [_ageTextField resignFirstResponder];
        [_IDTextField resignFirstResponder];
        _nameTextField.text = @"";
        _ageTextField.text = @"";
        _IDTextField.text = @"";
        [self.navigationController popViewControllerAnimated:YES];
    }
    [db close];
}

//让键盘隐藏
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    [_IDTextField resignFirstResponder];
}


//页面将要消失的时候执行，将UITextField清空
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    _nameTextField.text = nil;
    _ageTextField.text = nil;
    _IDTextField.text = nil;
}

@end

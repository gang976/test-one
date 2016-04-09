//
//  LSTThirdViewController.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LSTThirdViewController.h"
#import "AFNetworking.h"
#import "MagicalRecord.h"
#import "LSTThirdViewModel.h"
#import "LSTThirdViewCell.h"

#define kLSTThirdUrl @"http://guide.selftravel.com.cn/api/v3/get_route_detail/"

@interface LSTThirdViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation LSTThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //注册cell:
    [self.tableView registerNib:[UINib nibWithNibName:@"LSTThirdViewCell" bundle:nil] forCellReuseIdentifier:@"tcell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self hiddenNavigationBar];
    [self loadDataFromServce];
}

- (void)loadDataFromServce
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kLSTThirdUrl parameters:@{@"id":self.fid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            LSTThirdViewModel *lstf = [LSTThirdViewModel MR_createEntity];
            [lstf setValuesForKeysWithDictionary:responseObject[@"data"]];
            [self.dataSource addObject:lstf];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSTThirdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tcell" forIndexPath:indexPath];
    [cell refreshModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 667;
}


- (void)hiddenNavigationBar
{
    UIImage *image = [[UIImage imageNamed:@"backm"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image2 = [[UIImage imageNamed:@"sharem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickBack:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:nil action:nil];
}

//回调方法
- (void)clickBack:(UIBarButtonItem *)bbt
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    self.tabBarController.tabBar.hidden = YES;
    
}

//数据源懒加载
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end

//
//  LSTFirstViewController.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LSTFirstViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MagicalRecord.h"
#import "LSTFirstViewCell.h"
#import "LSTFirstViewModel.h"
#import "LSTSecondViewController.h"

#define kFisrtUrl @"http://guide.selftravel.com.cn/api/v3/get_main/"

@interface LSTFirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign) NSInteger page; //页数
@end

@implementation LSTFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hiddenNavigationBar];
    // 创建一个tableView对象:
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
    
    //注册cell:
    [self.tableView registerNib:[UINib nibWithNibName:@"LSTFirstViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
   
    [self updownRefreUI];
    
}


//上下拉刷新
-(void)updownRefreUI
{
    self.page = 1;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadDataFromServce];
        });
    
    }];
    [self loadDataFromLocal];
}

//本地下载数据
- (void)loadDataFromLocal
{
    [self.dataSource addObjectsFromArray:[LSTFirstViewModel MR_findAll]];
    [self.tableView reloadData];
    [self startMonitorNetWork];  //网络检测;
}
//网络检测
- (void)startMonitorNetWork
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            self.page = 1;
            [self loadDataFromServce];
        }
    }];
}

- (void)loadDataFromServce
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kFisrtUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self.tableView.footer isRefreshing] == NO) {
            [self.dataSource removeAllObjects];
            [[NSManagedObjectContext MR_defaultContext] MR_deleteObjects:[LSTFirstViewModel MR_findAll]];
        }
        for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
            LSTFirstViewModel *lstf = [LSTFirstViewModel MR_createEntity];
            [lstf setValuesForKeysWithDictionary:dict];
            [self.dataSource addObject:lstf];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
       });
        
        [self.tableView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSTFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell refreshModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSTSecondViewController *lvc = [[LSTSecondViewController alloc]initWithNibName:@"LSTSecondViewController" bundle:nil];
    lvc.cityName = [self.dataSource[indexPath.row] name];
    
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)hiddenNavigationBar
{
    UIImage *image = [[UIImage imageNamed:@"home_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.tabBarController.tabBar.hidden = NO;
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

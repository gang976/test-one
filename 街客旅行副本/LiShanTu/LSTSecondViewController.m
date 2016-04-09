//
//  LSTSecondViewController.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LSTSecondViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MagicalRecord.h"
#import "LSTSecondViewModel.h"
#import "LSTSecondViewCell.h"
#import "LSTThirdViewController.h"

#define kLSTSecUrl @"http://guide.selftravel.com.cn/api/v3/get_routes_list/"

@interface LSTSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger count;


@end

@implementation LSTSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.cityName;
    //注册cell:
    [self.tableView registerNib:[UINib nibWithNibName:@"LSTSecondViewCell" bundle:nil] forCellReuseIdentifier:@"scell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
    UIImage *image = [[UIImage imageNamed:@"NaviBtn_Backm"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickBack:)];
    
    [self updownRefreUI];
}

//上下拉刷新
-(void)updownRefreUI
{
    self.page = 1;
    self.count = 0;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadDataFromServce];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        self.count += 10;
        [self loadDataFromServce];
    }];
    [self loadDataFromLocal];
}

//本地下载数据
- (void)loadDataFromLocal
{
    //先判断数组不为空
    if ([LSTSecondViewModel MR_findByAttribute:@"name" withValue:self.cityName].count != 0) {
     //根据第一个页面的Model的关键字“name” 来 添加第二个页面的 dataSource
     // 不能MR_findAll ,根据关键字“name”
        [self.dataSource addObjectsFromArray:[LSTSecondViewModel MR_findByAttribute:@"name" withValue:self.cityName]];
        [self.tableView reloadData];
    }
    
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
    [manager GET:kLSTSecUrl parameters:@{@"offset":[NSString stringWithFormat:@"%ld",self.count],@"city":self.cityName,@"ctype":@"0",@"limit":@"10"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self.tableView.footer isRefreshing] == NO) {
            //先判断数组不为空
            if ([LSTSecondViewModel MR_findByAttribute:@"name" withValue:self.cityName].count != 0) {
        //不能removeAllObjects, 只能根据第一个页面的关键字“name” 来查找删除
                 [self.dataSource removeObjectsInArray:[LSTSecondViewModel MR_findByAttribute:@"name" withValue:self.cityName]];
            }
        // 只能根据第一个页面的关键字“name” 来查找删除,否则没有缓存效果
            [[NSManagedObjectContext MR_defaultContext] MR_deleteObjects:[LSTSecondViewModel MR_findByAttribute:@"name" withValue:self.cityName]];
        }
        for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
            LSTSecondViewModel *lstf = [LSTSecondViewModel MR_createEntity];
            [lstf setValuesForKeysWithDictionary:dict]; 

//            lstf.avatar = dict[@"avatar"];
//            lstf.cover = dict[@"cover"];
//            lstf.price = dict[@"price"];
//            lstf.route_id = dict[@"route_id"];
//            lstf.title = dict[@"title"];
            lstf.name = self.cityName;
            
            [self.dataSource addObject:lstf];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSTSecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scell" forIndexPath:indexPath];
    [cell refrshModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSTThirdViewController *lvc = [[LSTThirdViewController alloc]initWithNibName:@"LSTThirdViewController" bundle:nil];
    lvc.fid = [self.dataSource[indexPath.row] route_id];
    [self.navigationController pushViewController:lvc animated:YES];
}

//回调方法
- (void)clickBack:(UIBarButtonItem *)bbt
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"空的"] forBarMetrics:UIBarMetricsDefault];
    [self.tableView reloadData];
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

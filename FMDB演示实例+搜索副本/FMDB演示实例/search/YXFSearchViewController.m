//
//  YXFSearchViewController.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/18.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import "YXFSearchViewController.h"
#import "YXFAddUserViewController.h"
#import "YXFAddressViewController.h"
#import "FMDatabase.h"
#import "YXFDetailViewController.h"
@interface YXFSearchViewController () <UISearchBarDelegate,UISearchControllerDelegate>

@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation YXFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //搜索比较复杂，既要初始化UISearchBar，又要初始化UISearchDisplayController，然后还要写UITableViewDelegate里的-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath和-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section方法，还要设置一大堆代理，慢慢往下看
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width -50, 44)];
    search.placeholder = @"请输入姓名";
    search.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错，貌似没啥用
    search.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;//所有字母大写 ，也没啥用
    
    search.showsScopeBar = YES;
    search.delegate = self;//UISearchBar设置代理
    search.keyboardType = UIKeyboardTypeNamePhonePad;
    self.tableView.tableHeaderView = search;
    self.tableView.dataSource = self;
    
    _searchController = [[UISearchDisplayController alloc]initWithSearchBar:search contentsController:self];
    _searchController.active = NO;
    
    _searchController.delegate = self;//UISearchDisplayController设置代理
    
    _searchController.searchResultsDelegate=self;//还是代理
    
    _searchController.searchResultsDataSource = self;//有完没完
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:@"user.sqlite"];
    NSLog(@"path==%@",path);
    self.dbpath = path;
    self.tableView.delegate = self;//tableView的代理，为什么这么写，因为这个类是继承UITableView的，要注意！不是继承UIViewController的！
    self.tableView.dataSource = self;
    _nameArray = [[NSMutableArray alloc]initWithCapacity:0];
    _ageArray = [[NSMutableArray alloc]initWithCapacity:0];
    _IDArray= [[NSMutableArray alloc]initWithCapacity:0];
    
    [self getAllDatabase];
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)getAllDatabase
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbpath];
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
        self.searchResults = [[NSMutableArray alloc]initWithArray:_nameArray copyItems:YES];
        self.searchAgeResults = [[NSMutableArray alloc]initWithArray:_ageArray copyItems:YES];
        self.searchIDResult = [[NSMutableArray alloc]initWithArray:_IDArray copyItems:YES];
        NSLog(@"search from nameArray==%@",self.nameArray);
        [db close];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger row = 0;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {//记住这个格式，如果当前的table就是用于显示所搜信息的table的话。因为UISearchDisplayController这货自带一个table
        row = [self.searchResults count];
    }else{
        [self.nameArray count];
    }
    return row;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        cell.textLabel.text = [_searchResults objectAtIndex:indexPath.row];
        //        cell.detailTextLabel.text = [NSString stringWithFormat:@"电话：%@",[searchResults objectAtIndex:indexPath.row]];//不知道为什么不显示cell.detailTextLabel.text ，有人知道的话告诉我一下
    }else{
        cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXFDetailViewController *detailInfo = [[YXFDetailViewController alloc]init];
    detailInfo.nameStr = [self.searchResults objectAtIndex:indexPath.row];
    detailInfo.ageStr = [self.searchAgeResults objectAtIndex:indexPath.row];
    detailInfo.IDsStr = [self.searchIDResult objectAtIndex:indexPath.row];
    NSLog(@"self.namestr==%@",self.namestr);
    
    NSArray *array = [self.navigationController viewControllers];//先获取视图控制器数组
    UINavigationController *nav = [array objectAtIndex:[array count] - 1];//获取当前的导航试图控制器
    [nav.navigationController pushViewController:detailInfo animated:YES];//跳转到删除页面
}


#pragma mark -UISearchControllerDisplay-//设置搜索范围
//下面注意了，下面的方法是实现搜索功能的，后面两个长得很像的方法是UISearchControllerDisplay代理里的方法，我也搞不懂是干什么用的，他们的格式很固定，大家记住就行了。

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self searchBarSearchButtonClicked:self.searchDisplayController.searchBar];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar//从数据库搜索
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbpath];
    if ([db open]) {
        
        [_searchResults removeAllObjects];
        [_searchAgeResults removeAllObjects];
        [_searchIDResult removeAllObjects];
        NSString *sql = @"SELECT * FROM USER WHERE name like ?";
        FMResultSet *rs = [db executeQuery:sql,searchBar.text];
        while ([rs next]) {
            self.namestr = [rs stringForColumn:@"name"];
            self.agestr = [rs stringForColumn:@"age"];
            self.IDstr = [rs stringForColumn:@"idcode"];
            
            [self.searchResults addObject:_namestr];
            [self.searchAgeResults addObject:_agestr];
            [self.searchIDResult addObject:_IDstr];
        }
        
        NSLog(@"searchResults == %@",_searchResults);
        NSLog(@"searchAgeResults==%@",_searchAgeResults);
        NSLog(@"searchIDResult==%@",_searchIDResult);
        NSLog(@"search===%@",searchBar.text);
        
    }
    [db close];
    
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods设置代理方法

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];

    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

@end

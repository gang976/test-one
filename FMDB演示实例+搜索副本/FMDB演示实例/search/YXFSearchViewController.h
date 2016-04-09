//
//  YXFSearchViewController.h
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/18.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXFSearchViewController : UITableViewController

@property (nonatomic, strong) NSString *dbpath;
/*
 用于保存搜索出姓名的结果
 */
@property (nonatomic, strong) NSMutableArray *searchResults;
/*
 用来保存搜索的年龄信息
 */
@property (nonatomic, strong) NSMutableArray *searchAgeResults;
/*
 用来保存搜索的ID信息
 */
@property (nonatomic, strong) NSMutableArray *searchIDResult;
/*
 保存搜索之前的姓名信息
 */
@property (nonatomic, strong) NSMutableArray *nameArray;
/*
 保存搜索之前的年龄信息
 */
@property (nonatomic,strong) NSMutableArray *ageArray;

/*
 保存搜索之前的ID信息
 */
@property (nonatomic,strong) NSMutableArray *IDArray;
/*
 用来保存搜索的年龄信息
 */
@property (nonatomic,assign) BOOL searchWasActive;
/*
 这个好像没用了
 */
@property (nonatomic,assign) NSString *savedSearchTerm;

@property (nonatomic,retain) NSString *namestr;
@property (nonatomic,retain) NSString *agestr;
@property (nonatomic,retain) NSString *IDstr;

@end

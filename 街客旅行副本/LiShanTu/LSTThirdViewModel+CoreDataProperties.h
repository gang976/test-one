//
//  LSTThirdViewModel+CoreDataProperties.h
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LSTThirdViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTThirdViewModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cover;
@property (nullable, nonatomic, retain) NSString *guide_name;
@property (nullable, nonatomic, retain) NSString *guide_avatar;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) id label;
@property (nullable, nonatomic, retain) NSString *language;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *all_time;
@property (nullable, nonatomic, retain) NSNumber *comment_num;
@property (nullable, nonatomic, retain) NSNumber *bring_num;
@property (nullable, nonatomic, retain) id start_time;
@property (nullable, nonatomic, retain) NSNumber *is_activity;

@end

NS_ASSUME_NONNULL_END

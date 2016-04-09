//
//  LSTSecondViewModel+CoreDataProperties.h
//  LiShanTu
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LSTSecondViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTSecondViewModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *avatar;
@property (nullable, nonatomic, retain) NSString *cover;
@property (nullable, nonatomic, retain) NSNumber *guide_id;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSNumber *route_id;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END

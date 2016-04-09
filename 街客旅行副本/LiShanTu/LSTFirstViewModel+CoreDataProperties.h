//
//  LSTFirstViewModel+CoreDataProperties.h
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LSTFirstViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTFirstViewModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSNumber *guide;
@property (nullable, nonatomic, retain) NSNumber *route;

@end

NS_ASSUME_NONNULL_END

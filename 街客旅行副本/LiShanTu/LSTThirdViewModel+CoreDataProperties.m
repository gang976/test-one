//
//  LSTThirdViewModel+CoreDataProperties.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LSTThirdViewModel+CoreDataProperties.h"

@implementation LSTThirdViewModel (CoreDataProperties)

@dynamic cover;
@dynamic guide_name;
@dynamic guide_avatar;
@dynamic title;
@dynamic label;
@dynamic language;
@dynamic price;
@dynamic all_time;
@dynamic comment_num;
@dynamic bring_num;
@dynamic start_time;
@dynamic is_activity;



-(void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    for (NSString *key in keyedValues) {
        [self setValue:keyedValues[key] forKey:key];
    }
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

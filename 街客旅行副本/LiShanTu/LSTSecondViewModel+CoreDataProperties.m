//
//  LSTSecondViewModel+CoreDataProperties.m
//  LiShanTu
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LSTSecondViewModel+CoreDataProperties.h"

@implementation LSTSecondViewModel (CoreDataProperties)

@dynamic avatar;
@dynamic cover;
@dynamic guide_id;
@dynamic price;
@dynamic route_id;
@dynamic title;
@dynamic name;


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

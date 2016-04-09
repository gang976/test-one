//
//  LSTFirstViewModel+CoreDataProperties.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LSTFirstViewModel+CoreDataProperties.h"

@implementation LSTFirstViewModel (CoreDataProperties)

@dynamic name;
@dynamic image;
@dynamic guide;
@dynamic route;



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

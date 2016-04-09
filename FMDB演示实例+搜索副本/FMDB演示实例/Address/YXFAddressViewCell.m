//
//  YXFAddressViewCell.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/17.
//  Copyright © 2015年 袁新峰. All rights reserved.
//



#import "YXFAddressViewCell.h"

@implementation YXFAddressViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame) / 3, CGRectGetHeight(self.contentView.frame))];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    
    self.ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 0, CGRectGetWidth(self.contentView.frame) / 3, CGRectGetHeight(self.contentView.frame))];
    self.ageLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_ageLabel];
    
    self.ID = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ageLabel.frame), 0, CGRectGetWidth(self.contentView.frame) / 3, CGRectGetHeight(self.contentView.frame))];
    self.ID.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_ID];
    
}

@end

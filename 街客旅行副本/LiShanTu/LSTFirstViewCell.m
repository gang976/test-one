//
//  LSTFirstViewCell.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LSTFirstViewCell.h"
#import "UIImageView+WebCache.h"

@interface LSTFirstViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;

@end

@implementation LSTFirstViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)refreshModel:(LSTFirstViewModel *)model
{
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.nameLabel.text = model.name;
    self.guideLabel.text = [model.guide stringValue];
    self.routeLabel.text = [model.route stringValue];
}

@end

//
//  LSTSecondViewCell.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LSTSecondViewCell.h"
#import "UIImageView+WebCache.h"


@interface LSTSecondViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end


@implementation LSTSecondViewCell

- (void)awakeFromNib {
    // Initialization code
    self.smallImage.layer.cornerRadius = 28.0f;
    self.smallImage.clipsToBounds = YES;
}

- (void)refrshModel:(LSTSecondViewModel *)model
{
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    [self.smallImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.titleLabel.text = model.title;
    self.priceLabel.text = model.price;
}

@end

//
//  LSTThirdViewCell.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LSTThirdViewCell.h"
#import "UIImageView+WebCache.h"

@interface LSTThirdViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIImageView *guide_avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *guide_nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *lixiBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//===================

@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UILabel *start_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel2;
@property (weak, nonatomic) IBOutlet UILabel *start_timeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *start_timeLabel3;

//===============================
@property (weak, nonatomic) IBOutlet UILabel *all_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bring_numLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *is_activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@end



@implementation LSTThirdViewCell

- (void)awakeFromNib {
    // Initialization code
    self.guide_avatarImage.layer.cornerRadius = 35.0f;
    self.guide_avatarImage.clipsToBounds = YES;
    
    self.lixiBtn.layer.cornerRadius = 15.0f;
    self.lixiBtn.clipsToBounds = YES;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
   
    
    
}

- (void)refreshModel:(LSTThirdViewModel *)model
{
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    [self.guide_avatarImage sd_setImageWithURL:[NSURL URLWithString:model.guide_avatar]];
    self.guide_nameLabel.text = model.guide_name;
    self.titleLabel.text = model.title;
    
    self.is_activityLabel.text = [model.is_activity stringValue];
    
    self.all_timeLabel.text = model.all_time;
    self.bring_numLabel.text = [model.bring_num stringValue];
    self.languageLabel.text = model.language;
    
    self.priceLabel.text = model.price;
    
    
    if ([self.languageLabel.text containsString:@"、"]) {
        NSArray *arr1 = [self.languageLabel.text componentsSeparatedByString:@"、"];
        self.languageLabel.text = [arr1 componentsJoinedByString:@"/"];
    }
    
    if ([model.label count] < 2 && [model.label count] > 0) {
        self.labelLabel.text = model.label[0];
        self.labelLabel2.hidden = YES;
    }else if([model.label count] == 0){
        self.labelLabel.hidden = YES;
        self.labelLabel2.hidden = YES;
    }else if([model.label count] >= 2){
    for (int i = 0; i < [model.label count]; i++) {
        self.labelLabel.text = model.label[0];
        self.labelLabel2.text = model.label[1];
       
        }
    }
    
    
    
    if ([model.start_time count] < 3 &&[model.start_time count] >= 2 ) {
        for (int i = 0; i < [model.start_time count]; i++) {
            self.start_timeLabel.text = model.start_time[0][@"date"];
            self.start_timeLabel2.text = model.start_time[1][@"date"];
            self.start_timeLabel3.hidden = YES;
        }
      
    }else if ([model.start_time count] > 1 && [model.start_time count] < 2){
        self.start_timeLabel.text = model.start_time[0][@"date"];
        self.start_timeLabel2.hidden = YES;
        self.start_timeLabel3.hidden = YES;
    }else if([model.start_time count] >= 3){
        for (int i = 0; i < [model.start_time count]; i++) {
            self.start_timeLabel.text = model.start_time[0][@"date"];
            self.start_timeLabel2.text = model.start_time[1][@"date"];
            self.start_timeLabel3.text = model.start_time[2][@"date"];
        }
    }
    
    

    
}


@end

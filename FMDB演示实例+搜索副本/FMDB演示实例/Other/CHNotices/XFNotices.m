//
//  XFNotices.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/18.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import "XFNotices.h"

@interface XFNotices ()

@property (nonatomic, strong)UIImageView *image;
@property (nonatomic, strong)UILabel *message;
@property (nonatomic, strong)NSDictionary *dic;

@end

@implementation XFNotices

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dc_setupView];
        
    }
    return self;
}

- (void)dc_setupView
{
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
    self.image = [[UIImageView alloc]init];
    _image.frame = CGRectMake(34, 10, 32, 32);
    _image.image = [UIImage imageNamed:@"success"];
    [self addSubview:_image];
    
    
    
    self.message = [[UILabel alloc]init];
    _message.frame = CGRectMake(10, 45, 80, 30);
    _message.textAlignment = NSTextAlignmentCenter;
    _message.textColor = [UIColor whiteColor];
    _message.numberOfLines = 0;
    //_message.backgroundColor = [UIColor blueColor];
    [self addSubview:_message];
    
}

+(void)noticesWithTitle:(NSString *)title Time:(NSTimeInterval)time View:(UIView *)view Style:(XFNoticesStyle)style
{
    XFNotices *notices = [[XFNotices alloc]initWithFrame:CGRectMake(0,0, 100, 80)];
    switch (style) {
        case 0:
            notices.image.image = [UIImage imageNamed:@"success"];
            break;
        case 1:
            notices.image.image = [UIImage imageNamed:@"fail"];
        default:
            break;
    }
    notices.center = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height/2 - 100);
    notices.layer.masksToBounds = YES;
    notices.layer.cornerRadius = 15;
    notices.dic = [NSDictionary dictionaryWithObject:notices forKey:@"dd"];
    notices.message.text = title;
    notices.message.font = [UIFont systemFontOfSize:12];
    notices.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        notices.center = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height/2 - 100);
        [view addSubview:notices];
        notices.alpha = 0.7;
    }];
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timeAction:) userInfo:notices.dic repeats:NO];
    
}


+ (void)timeAction:(NSTimer *)sender
{
    XFNotices *notices = [[sender userInfo] valueForKey:@"dd"];
    [UIView animateWithDuration:0.5 animations:^{
        notices.alpha = 0;
    } completion:^(BOOL finished) {
        [notices removeFromSuperview];
    }];
    
}


@end

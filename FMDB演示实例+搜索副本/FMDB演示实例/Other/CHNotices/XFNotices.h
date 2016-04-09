//
//  XFNotices.h
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/18.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XFNoticesStyle) {
    XFNoticesStyleSuccess  = 0,
    XFNoticesStyleFail     = 1,
};

@interface XFNotices : UIView

+(void)noticesWithTitle:(NSString *)title Time:(NSTimeInterval)time View:(UIView *)view Style:(XFNoticesStyle)style;

@end

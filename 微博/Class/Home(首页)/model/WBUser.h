//
//  WBUser.h
//  微博
//
//  Created by llairen on 15/11/10.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject



/** 字符串型的用户UID*/
@property(nonatomic ,copy)NSString *idstr;

/** 用户昵称*/
@property(nonatomic ,copy)NSString *screen_name;

/** 用户头像地址（中图），50×50像素*/
@property(nonatomic ,copy)NSString *profile_image_url;
/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

@end

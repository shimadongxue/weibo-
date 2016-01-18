//
//  WBAccount.h
//  微博
//
//  Created by llairen on 15/11/5.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject<NSCoding>
/**
 "access_token" = "2.00I8IHDGFi8hJE29d387de53HXK5fD";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5542826730;
 
 */
/** access_token 用于调用access_token，接口获取授权后的access token。*/
@property(nonatomic ,copy) NSString * access_token;
/** access_token的生命周期，单位是秒数。*/
@property(nonatomic ,copy) NSNumber * expires_in;

/** 当前授权用户的UID。*/
@property(nonatomic ,copy) NSString * uid;
/** 当前用户的昵称。*/
@property(nonatomic ,copy) NSString * name;

/** 帐号创建时间*/
@property(nonatomic ,strong) NSDate *created_time;

+(instancetype)accountWithDict:(NSDictionary *)dict;
@end

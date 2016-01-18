//
//  OAuthResultModel.h
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthResultModel : NSObject
/**
 
 返回值字段	字段类型	字段说明
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	string	当前授权用户的UID。
 */
/**
 用于调用access_token，接口获取授权后的access token。*/

/**
 用于调用access_token，接口获取授权后的access token
 */
@property (nonatomic, strong)NSString *access_token;
/**
 access_token的生命周期，单位是秒数
 */
@property (nonatomic, copy)NSString *expires_in;
/**
 access_token的生命周期（该参数即将废弃，开发者请使用expires_in）
 */
@property (nonatomic, copy)NSString *remind_in;
/**
 当前授权用户的UID
 */
@property (nonatomic, copy)NSString *uid;

@end

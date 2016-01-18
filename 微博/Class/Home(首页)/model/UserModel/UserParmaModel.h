//
//  UserParmaModel.h
//  个人客户端
//
//  Created by llairen on 16/1/13.
//  Copyright © 2016年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserParmaModel : NSObject

@property (nonatomic, copy) NSString *access_token;
/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;
@end

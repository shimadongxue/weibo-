//
//  WBStatus.h
//  微博
//
//  Created by llairen on 15/11/10.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"

@interface WBStatus : NSObject
/**    微博创建时间    */
@property(nonatomic ,copy) NSString * created_at;

/**    字符串型的微博ID   */
@property(nonatomic ,copy) NSString * idstr;

/**    微博信息内容   */
@property(nonatomic ,copy) NSString * text;

/**    微博来源   */
@property(nonatomic ,copy) NSString * source;

/**    缩略图片地址，没有时不返回此字段   */
@property(nonatomic ,copy) NSString * thumbnail_pic;

//bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
//original_pic
@property(nonatomic ,copy) NSString * bmiddle_pic;
@property(nonatomic ,copy) NSString * original_pic;

/**    转发数   */
@property(nonatomic ,assign)int reposts_count;

/**    返回ID比since_id大的微博   */
@property(nonatomic ,assign)NSNumber *since_id;

/**    返回ID小于或等于max_id的微博，   */
@property(nonatomic ,assign)NSNumber *max_id;


/**    评论数   */
@property(nonatomic ,assign)int comments_count;

/**    表态数   */
@property(nonatomic ,assign)int attitudes_count;

/** 图片数组 */
@property (nonatomic, strong)NSArray *pic_urls;
/**微博作者的用户信息字段 详细*/
@property (nonatomic, strong)WBUser *user;
/**被转发的原微博*/
@property (nonatomic, strong)WBStatus *retweeted_status;


/**

 favorited	boolean	是否已收藏，true：是，false：否
 thumbnail_pic	string	缩略图片地址，没有时不返回此字段
 bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
 original_pic	string	原始图片地址，没有时不返回此字段

 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。

 */
@end

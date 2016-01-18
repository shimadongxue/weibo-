//
//  StatusFrame.h
//  微博
//
//  Created by 赵武灵王 on 15/11/15.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBStatus.h"




// 昵称字体
#define StatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define StatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define StatusCellSourceFont StatusCellTimeFont
// 正文字体
#define StatusCellContentFont [UIFont systemFontOfSize:14]

// 被转发正文字体
#define RetweetedStatusContentFont [UIFont systemFontOfSize:14]
@interface StatusFrame : NSObject
@property (strong, nonatomic) WBStatus *status;

/** 原创整体*/
@property (assign, nonatomic) CGRect originalViewF;

/** 头像*/
@property (assign, nonatomic) CGRect iconViewF;
/** vip像*/
@property (assign, nonatomic) CGRect vipViewF;
/** 配头*/
@property (assign, nonatomic) CGRect photosViewF;

/** 昵称*/
@property (assign, nonatomic) CGRect nameLabelF;
/** 时间*/
@property (assign, nonatomic) CGRect timeLabelF;
/** 来源*/
@property (assign, nonatomic) CGRect sourceLabelF;
/** 正文*/
@property (assign, nonatomic) CGRect contentLabelF;

/** 被转发微博整体*/
@property (assign, nonatomic) CGRect retweetedViewF;

/** 被转发微博正文*/
@property (assign, nonatomic) CGRect retweetedContentF;

/** 被转发微博配头*/
@property (assign, nonatomic) CGRect retweetedPhotosF;

/** 工具条*/
@property (assign, nonatomic) CGRect ToolBarF;
/** cell*/
@property (assign, nonatomic) CGFloat cellHeight;

@end

//
//  StatuesPhotosView.h
//  微博
//
//  Created by 赵武灵王 on 15/11/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatuesPhotosView : UIView
@property (strong, nonatomic) NSArray *photos;

/** 图片张数算相册的size*/
+(CGSize)sizeWithCount:(int )count;



@end

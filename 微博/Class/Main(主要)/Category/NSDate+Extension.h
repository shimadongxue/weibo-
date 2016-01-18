//
//  NSDate+Extension.h
//  微博
//
//  Created by 赵武灵王 on 15/11/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/** 判断是不是今年*/
-(BOOL)isThisYear;

/** 判断是不是今天*/
-(BOOL)isToday;

/** 判断是不是昨天*/
-(BOOL)isYesterday;
@end

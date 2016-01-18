//
//  NSDate+Extension.m
//  微博
//
//  Created by 赵武灵王 on 15/11/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/** 判断是不是今年*/
-(BOOL)isThisYear
{
    NSCalendar * calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear;
   NSDateComponents *creatDate= [calendar components:unit fromDate:self];
    NSDateComponents * nowDate=[calendar components:unit fromDate:[NSDate date]];
    return creatDate.year=nowDate.year;
    
}

/** 判断是不是今天*/
-(BOOL)isToday;
{
    NSDate *now=[NSDate date];
    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    NSLocale * LOCAL=[NSLocale currentLocale];
    format.locale=LOCAL;
    format.dateFormat=@"yyyy-MM-dd";
    
    NSString * create=[format stringFromDate:self];
    NSString * nowDate=[format stringFromDate:now];
    return [create isEqualToString:nowDate];

}

/** 判断是不是昨天*/
-(BOOL)isYesterday
{
    NSDate *now=[NSDate date];
    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    NSLocale * LOCAL=[NSLocale currentLocale];
    format.locale=LOCAL;
    format.dateFormat=@"yyyy-MM-dd";
    
    NSString * create=[format stringFromDate:self];
    NSString * nowDate=[format stringFromDate:now];
    
    NSDate *createDate=[format dateFromString:create];
    now=[format dateFromString:nowDate];
    
    NSCalendar * calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay;
    NSDateComponents * compo=[calendar components:unit fromDate:createDate toDate:now options:0];
    return compo.year==0 && compo.month==0 && compo.day==1;
}
@end

//
//  WBStatus.m
//  微博
//
//  Created by llairen on 15/11/10.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBStatus.h"
#import "PhotoMode.h"
#import "MJExtension.h"


@implementation WBStatus
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : @"PhotoMode"};
}

-(NSString *)created_at
{
     NSDate * now=[NSDate date];
    // Sun Nov 22 11:00:03 +0800 2015
   // EEE MMM dd HH:mm:ss Z yyyy
    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    format.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    
    format.dateFormat=@"EEE MM dd HH:mm:ss Z yyyy";
    
    NSDate * create=[format dateFromString:_created_at];
   
    NSCalendar * calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit= NSCalendarUnitHour | NSCalendarUnitMinute ;
    NSDateComponents * compoent=[calendar components:unit fromDate:create toDate:now options:0];
    

    
    
    if ([create isThisYear])
    {
        if ([create isToday])
        {
            if (compoent.hour>1)
            {
                return [NSString stringWithFormat:@"%ld小时前",(long)compoent.hour];
            }
            else if (compoent.minute>1)
            {
                return [NSString stringWithFormat:@"%ld分钟前",(long)compoent.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else if ([create isYesterday])
        {
            format.dateFormat=@"昨天 HH:mm";
            return [format stringFromDate:create];
        }
        else
        {
            format.dateFormat=@"MM-dd";
            return [format stringFromDate:create];
        }
        
    }
    
        
        format.dateFormat=@"yyyy-MM-dd";
        return [format stringFromDate:create];
   
   
}

-(void)setSource:(NSString *)source
{
    
    
    NSRange rang;
    rang.location=[source rangeOfString:@">"].location+1;
    rang.length=[source rangeOfString:@"</"].location-rang.location;
    
    
    _source=[NSString stringWithFormat:@"来自 %@",[source substringWithRange:rang]];
   
}
@end

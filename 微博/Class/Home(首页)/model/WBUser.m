//
//  WBUser.m
//  微博
//
//  Created by llairen on 15/11/10.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}
@end

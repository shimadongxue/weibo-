//
//  ComposeTabBarButton.m
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "ComposeTabBarButton.h"

@implementation ComposeTabBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}


-(void)setHighlighted:(BOOL)highlighted
{
    
}
@end

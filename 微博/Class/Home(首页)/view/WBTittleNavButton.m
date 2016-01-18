//
//  WBTittleNavButton.m
//  微博
//
//  Created by llairen on 15/11/6.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "WBTittleNavButton.h"
#define MarginWidth 5
@implementation WBTittleNavButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        //初始化button
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x=CGRectGetMaxX(self.imageView.frame);
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame)+3;
    
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
-(void)setFrame:(CGRect)frame
{
    
    frame.size.width +=MarginWidth;
    [super setFrame:frame];
}
@end

//
//  EmojiBtnView.m
//  个人客户端
//
//  Created by llairen on 15/12/18.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "EmojiBtnView.h"

@implementation EmojiBtnView

+(instancetype)emojiBtnView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"EmojiBtnView" owner:nil options:nil] lastObject];
}

//-(void)setEmoji:(EmojiModel *)emoji
//{
//    _emoji=emoji;
//    self.emojiBtn.emoji=emoji;
//}
-(void)showFrom:(EmojiBtn *)emojibtn
{
    if (emojibtn==nil) return;
    
    _emojiBtn.emoji=emojibtn.emoji;
    
    
    
    UIWindow * window=[[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    //把btn坐标转移为window的坐标
    CGRect frameBtn=[emojibtn convertRect:emojibtn.bounds toView:nil];
    self.y=CGRectGetMidY(frameBtn)-self.height;
    self.centerX=CGRectGetMidX(frameBtn);
}
@end

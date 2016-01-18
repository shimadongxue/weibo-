//
//  EmojiBtn.m
//  个人客户端
//
//  Created by llairen on 15/12/18.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "EmojiBtn.h"

@implementation EmojiBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}
/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}

/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib
{
    
}
-(void)setEmoji:(EmojiModel *)emoji
{
    _emoji=emoji;
    if (emoji.png)
    {
        [self setImage:[UIImage imageNamed:emoji.png] forState:UIControlStateNormal];
    }
    else if (emoji.code)
    {
        [self setTitle:emoji.code.emoji forState:UIControlStateNormal];
        
    }
    
}

@end

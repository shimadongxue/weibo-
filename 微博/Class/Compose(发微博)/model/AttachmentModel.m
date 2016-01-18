//
//  AttachmentModel.m
//  个人客户端
//
//  Created by llairen on 15/12/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "AttachmentModel.h"
#import "EmojiModel.h"
@implementation AttachmentModel


-(void)setEmoji:(EmojiModel *)emoji
{
    _emoji=emoji;
    self.image=[UIImage imageNamed:emoji.png];
}
@end

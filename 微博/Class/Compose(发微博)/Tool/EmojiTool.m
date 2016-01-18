//
//  EmojiTool.m
//  个人客户端
//
//  Created by llairen on 15/12/23.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "EmojiTool.h"




#define EmojiPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"arrayEmoji.archive"]
@implementation EmojiTool

static NSMutableArray  * emojis;
+(void)initialize
{
    emojis=[NSKeyedUnarchiver unarchiveObjectWithFile:EmojiPath];
    if (emojis==nil)
    {
        emojis=[NSMutableArray array];
    }
}

+(void)addEmoji:(EmojiModel *)emoji
{
    [emojis removeObject:emoji];
    
    [emojis insertObject:emoji atIndex:0];
    [NSKeyedArchiver archiveRootObject:emojis toFile:EmojiPath];
}

+(NSArray *)emojiArr
{
    
    return  emojis;
}
@end

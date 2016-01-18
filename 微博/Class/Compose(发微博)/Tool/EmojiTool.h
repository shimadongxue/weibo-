//
//  EmojiTool.h
//  个人客户端
//
//  Created by llairen on 15/12/23.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EmojiModel;
@interface EmojiTool : NSObject


+(void)addEmoji:(EmojiModel *)emoji;
+(NSArray *)emojiArr;
@end

//
//  EmojiTextView.h
//  个人客户端
//
//  Created by llairen on 15/12/21.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "ComposTextView.h"
@class EmojiModel;
@interface EmojiTextView : ComposTextView


-(NSString *)fullText;
-(void)insertEmojiModel:(EmojiModel *)emoji;
@end

//
//  EmojiTextView.m
//  个人客户端
//
//  Created by llairen on 15/12/21.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "EmojiTextView.h"
#import "EmojiModel.h"
#import "AttachmentModel.h"

#import "UITextView+Extension.h"
@implementation EmojiTextView

-(void)insertEmojiModel:(EmojiModel *)emoji
{
     if (emoji.code)
     {
         [self insertText:emoji.code.emoji];
     }
     else if (emoji.png)
    {
        AttachmentModel * attach=[[AttachmentModel alloc]init];
        attach.emoji=emoji;
//        NSTextAttachment * attach=[[NSTextAttachment alloc]init];
//        attach.image=[UIImage imageNamed:emoji.png];
        NSAttributedString * imageStr=[NSAttributedString attributedStringWithAttachment:attach];
        
        
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
     
    }
}

-(NSString *)fullText
{
    NSMutableString * fullText=[NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        AttachmentModel * attch=attrs[@"NSAttachment"];
        if (attch)
        {
            [fullText appendString:attch.emoji.chs];
        }
        else
        {
            NSAttributedString * text=[self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:text.string];
        }
    }];
    return fullText;
}

@end

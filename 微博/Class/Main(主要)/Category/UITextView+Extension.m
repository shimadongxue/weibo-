//
//  UITextView+Extension.m
//  个人客户端
//
//  Created by llairen on 15/12/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)



-(void)insertAttributedText:(NSAttributedString *)text
{
    [self insertAttributedText:text settingBlock:nil];
}

-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString * attributedStr=[[NSMutableAttributedString alloc]init];
    [attributedStr appendAttributedString:self.attributedText];
    
    NSUInteger loc=self.selectedRange.location;
    
    
    
    [attributedStr replaceCharactersInRange:self.selectedRange withAttributedString:text];
    if (settingBlock)
    {
        settingBlock(attributedStr);
    }
    self.attributedText=attributedStr;
    
    self.selectedRange=NSMakeRange(loc+1, 0);
    
}
@end

//
//  UITextView+Extension.h
//  个人客户端
//
//  Created by llairen on 15/12/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)


-(void)insertAttributedText:(NSAttributedString *)text;
-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *attributedText))settingBlock;
@end

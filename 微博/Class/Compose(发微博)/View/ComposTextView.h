//
//  ComposTextView.h
//  微博
//
//  Created by llairen on 15/11/30.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposTextView : UITextView
/**默认文本文字*/
@property(nonatomic ,strong) NSString * placehoderStr;

/**默认文本颜色*/
@property (nonatomic, strong)UIColor *phaceColor;
@end

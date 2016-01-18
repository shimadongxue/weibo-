//
//  StatueToolBar.h
//  微博
//
//  Created by llairen on 15/11/20.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBStatus.h"
@interface StatueToolBar : UIView
@property (nonatomic, strong)WBStatus *status;
+(instancetype)statueToolBar;
@end

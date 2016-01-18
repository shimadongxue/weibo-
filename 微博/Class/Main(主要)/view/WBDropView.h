//
//  WBDropView.h
//  微博
//
//  Created by llairen on 15/10/29.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBDropView;
@protocol WBDropViewDelegate <NSObject>

@optional
-(void)dropDismissMenuView:(WBDropView *)menu;
-(void)dropMenuViewDidShow:(WBDropView *)menu;

@end

@interface WBDropView : UIView
@property (nonatomic,weak)id<WBDropViewDelegate>delegate;
+(instancetype)menu;
-(void)dismiss;
-(void)showFrom:(UIView *)form;

@property (nonatomic, strong)UIView *content;

@property (nonatomic, strong)UIViewController *contentController;
@end

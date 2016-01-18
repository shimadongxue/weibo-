//
//  EmotionTabBar.h
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum{
    EmotionTabBarButtonTypeRecent, // 最近
    EmotionTabBarButtonTypeDefault, // 默认
    EmotionTabBarButtonTypeEmoji, // emoji
    EmotionTabBarButtonTypeLxh,
} EmotionTabBarButtonType;

@class EmotionTabBar;
@protocol  EmotionTabBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(EmotionTabBar *)tabBar didSeletcedBtn:(EmotionTabBarButtonType) btnType;

@end
@interface EmotionTabBar : UIView

@property (nonatomic, weak)id<EmotionTabBarDelegate> delegate;
@end

//
//  ComposeToolBar.h
//  微博
//
//  Created by llairen on 15/11/30.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ComposeToolBarButtonCamera,  // 拍照
    ComposeToolBarButtonPicture, // 相册
    ComposeToolBarButtonMention, // @
    ComposeToolBarButtonTrend, // #
    ComposeToolBarButtonEmotion // 表情
    
}ComposeToolBarButtonType;


@class ComposeToolBar;

@protocol ComposeToolBarDelegate <NSObject>

@optional
-(void)composeToolBar:(ComposeToolBar *)toolBar didClickBtn:(ComposeToolBarButtonType)buttonType;

@end




@interface ComposeToolBar : UIView
@property (nonatomic, weak)id<ComposeToolBarDelegate> delegate;



/**添加bool 用来转化表情与键盘的按钮*/
@property (nonatomic , assign)BOOL showKeyboardBtn;
@end

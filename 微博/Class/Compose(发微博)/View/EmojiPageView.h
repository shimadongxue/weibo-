//
//  EmojiPageView.h
//  个人客户端
//
//  Created by llairen on 15/12/18.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EmojiBtnMaxCol 7
#define EmojiBtnMaxRow 3
#define EmojiPageNum ((EmojiBtnMaxCol*EmojiBtnMaxRow)-1)


@interface EmojiPageView : UIView



/**被截的emoji模型数组*/
@property (nonatomic, strong)NSArray  *emojiArr;;
@end

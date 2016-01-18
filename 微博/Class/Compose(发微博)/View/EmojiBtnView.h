//
//  EmojiBtnView.h
//  个人客户端
//
//  Created by llairen on 15/12/18.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiBtn.h"
#import "EmojiModel.h"
@interface EmojiBtnView : UIView
@property (weak, nonatomic) IBOutlet EmojiBtn *emojiBtn;

@property (nonatomic, strong)EmojiModel *emoji;
+(instancetype)emojiBtnView;



-(void)showFrom:(EmojiBtn *)emojibtn;
@end

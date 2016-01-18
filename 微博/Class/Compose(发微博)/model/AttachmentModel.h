//
//  AttachmentModel.h
//  个人客户端
//
//  Created by llairen on 15/12/22.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmojiModel;
@interface AttachmentModel : NSTextAttachment
@property (nonatomic, strong)EmojiModel *emoji;
@end

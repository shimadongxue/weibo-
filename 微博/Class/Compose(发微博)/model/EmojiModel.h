//
//  EmojiModel.h
//  个人客户端
//
//  Created by llairen on 15/12/16.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmojiModel : NSObject<NSCoding>
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;
@end

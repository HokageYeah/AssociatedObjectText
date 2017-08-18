//
//  UIColor+Util.h
//  AssociatedObjectText
//
//  Created by 余晔 on 2017/4/1.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)
/* 从十六进制字符串获取颜色 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

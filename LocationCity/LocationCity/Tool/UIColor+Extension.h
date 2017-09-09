//
//  UIColor+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/10.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)


/**
 *从十六进制字符串获取颜色
 */
+(UIColor*)colorWithhexString:(NSString *)hexString;

/**
 *从十六进制字符串获取颜色
 */
+(UIColor*)colorWithhexString:(NSString *)hexString alpha:(float)alpha;

@end

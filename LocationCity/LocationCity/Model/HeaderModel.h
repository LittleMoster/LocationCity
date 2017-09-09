//
//  HeaderModel.h
//  Artisan
//
//  Created by cguo on 2017/8/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject



/** 标识这组是否需要展开,  YES : 展开 ,  NO : 关闭 */
@property (nonatomic, assign, getter = isOpend) BOOL opend;

@end

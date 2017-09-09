//
//  Header.h
//  LocationCity
//
//  Created by cguo on 2017/9/9.
//  Copyright © 2017年 zjq. All rights reserved.
//

//
//  Confil.h
//  Artisan
//
//  Created by cguo on 2017/6/21.
//  Copyright © 2017年 zjq. All rights reserved.
//
#import "UIColor+Extension.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define iPhone4sHight 480
#define iPhone5sHight 568
#define iPhone5sWigtht 320
#define iPhone6sHight 667
#define iPhone6sWidth 375
#define MainColor [UIColor colorWithhexString:@"#ffcf38"]  //APP主体颜色
#define DisColor [UIColor colorWithhexString:@"#8e8e8e"] //APP中未选中的颜色
#define LinkColor [UIColor colorWithhexString:@"#dedede"]  //APP分割线颜色
#define BgColor [UIColor colorWithhexString:@"#f5f7fa"]//背景颜色
#define GraylblColor [UIColor colorWithhexString:@"#bbbcbe"]//灰色的文字颜色

#define HeigheScale  ScreenHeight/iPhone6sHight
#define WidthScale   ScreenWidth/iPhone6sWidth
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MminLabelFont [UIFont systemFontOfSize:12]
#define MinLabelFont [UIFont systemFontOfSize:13]//字体大小
#define MidLabelFont [UIFont systemFontOfSize:15]//中等字体大小
#define BigLabelFont [UIFont systemFontOfSize:17]//中等字体大小

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

//判断是否是ios7系统
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f
#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.f
#define IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.f)

#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]






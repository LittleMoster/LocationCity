//
//  CityCellHeaderView.h
//  Artisan
//
//  Created by cguo on 2017/8/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderModel;

@protocol CityHeaderDelegate <NSObject>

-(void)HeaderClick:(NSInteger)section;

@end
@interface CityCellHeaderView : UIView

@property (nonatomic, strong) HeaderModel *model;
@property (nonatomic, assign) id<CityHeaderDelegate> delegate;


-(instancetype)GetHeaderWithArr:(NSArray*)Arr Withsection:(NSInteger)section;
@end

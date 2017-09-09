//
//  CityCollectionCell.m
//  Artisan
//
//  Created by cguo on 2017/7/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "CityCollectionCell.h"
#import "UIView+Extension.h"

@implementation CityCollectionCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initCollectCell];
    }
    return self;
}


-(void)initCollectCell
{
    self.backgroundColor=[UIColor clearColor];
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0f;
    bgView.clipsToBounds = YES;
    
    [self addSubview:bgView];
    
    self.titLbl =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.titLbl.textAlignment=NSTextAlignmentCenter;
    self.titLbl.font=[UIFont systemFontOfSize:15];
    self.titLbl.textColor=[UIColor blackColor];
    //    self.titLbl.text=@"cehngshi";
    [self addSubview:self.titLbl];
    
    
}

@end

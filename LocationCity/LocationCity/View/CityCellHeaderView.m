//
//  CityCellHeaderView.m
//  Artisan
//
//  Created by cguo on 2017/8/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "CityCellHeaderView.h"
#import "HeaderModel.h"
#import "Header.h"
#import "UIView+Extension.h"

@interface CityCellHeaderView ()

@end

@implementation CityCellHeaderView



-(instancetype)GetHeaderWithArr:(NSArray*)Arr Withsection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc]init];
    label.text=Arr[section];
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=GraylblColor;
    label.font=[UIFont systemFontOfSize:15];
    UIButton *btn=[[UIButton alloc]init];
    btn.tag=section;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    if (section==0) {
        label.text=@"热门城市";
    }
    
    
    
    CityCellHeaderView *headerView=[[CityCellHeaderView alloc]init];
    
    if (section==0) {
        headerView.frame=CGRectMake(0, 0, ScreenWidth, 40);
        btn.frame=headerView.frame;
        label.frame=CGRectMake(20, 0, ScreenWidth-20, 40);
    }else
    {
        headerView.frame=CGRectMake(0, 0, ScreenWidth, 25);
        btn.frame=headerView.frame;
        label.frame=CGRectMake(20, 0, ScreenWidth-20, 25);
        
    }
    headerView.backgroundColor=BgColor;
    
    [headerView addSubview:label];
    [headerView addSubview:btn];
    return headerView;
    
}

-(void)btnClick:(UIButton*)btn
{
    self.model.opend = !self.model.isOpend;
    
    if (_delegate !=nil && [_delegate respondsToSelector:@selector(HeaderClick:)]) {
        [_delegate HeaderClick:btn.tag];
    }
    
}


-(void)setModel:(HeaderModel *)model
{
    _model=model;
}
@end

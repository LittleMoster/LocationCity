//
//  CityViewCell.m
//  Artisan
//
//  Created by cguo on 2017/7/10.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "CityViewCell.h"
#import "WaterflowLayout.h"
#import "CityCollectionCell.h"
#import "Header.h"
#import "UIView+Extension.h"
#import "MBProgressHUD+TVAssistant.h"

@interface CityViewCell ()<WaterflowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectView;


@end
static NSString *const collectId=@"collectViewCellID";

@implementation CityViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//-(NSArray *)cityArr
//{
//    if (_cityArr==nil) {
//        _cityArr=@[@"北京",@"广州",@"广州",@"广州",@"广州",@"广州",@"广州",@"广州"];
//    }
//    return _cityArr;
//}

-(void)setCityArr:(NSArray *)cityArr
{
    _cityArr=cityArr;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initcellView];
        
    }
    return self;
}


-(void)initcellView
{
    
    WaterflowLayout *layout=[[WaterflowLayout alloc]init];
    layout.delegate=self;
    
    self.collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 150) collectionViewLayout:layout];
    
    self.collectView.delegate=self;
    self.collectView.dataSource=self;
    self.collectView.backgroundColor=[UIColor clearColor];
    self.collectView.alwaysBounceVertical = NO;
    self.collectView.showsHorizontalScrollIndicator=NO;
    
    [self.collectView registerClass:[CityCollectionCell class] forCellWithReuseIdentifier:collectId];
    [self addSubview:self.collectView];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectView.size.width/3, 35);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _cityArr.count;
}
//列边距
- (CGFloat)columnMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout
{
    return 15;
}

//行边距
- (CGFloat)rowMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout
{
    return 15;
}
- (CGFloat)columnCountInWaterflowLayout:(WaterflowLayout *)waterflowLayout
{
    return 3;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}
- (CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return 35;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:collectId forIndexPath:indexPath];
    
    cell.titLbl.text=_cityArr[indexPath.item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了右边的按钮");
    
    [MBProgressHUD showToastToView:self.viewController.view withText:_cityArr[indexPath.item]];
}

@end

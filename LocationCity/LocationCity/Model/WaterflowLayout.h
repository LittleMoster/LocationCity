//
//  WaterflowLayout.h
//  CollectionViewLayout
//
//  Created by cguo on 2017/5/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterflowLayout;

@protocol WaterflowLayoutDelegate <NSObject>
@required
/**
 *  返回item高度
 *
 *  @param waterflowLayout 布局方式
 *  @param index           第几个item
 *  @param itemWidth       item的宽度
 *
 *  @return item的高度
 */
- (CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional

/**
 *  用于返回列数
 *
 *  @param waterflowLayout 布局方式
 *
 *  @return  返回列数
 */
- (CGFloat)columnCountInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
/**
 *  用于返回列边距
 *
 *  @param waterflowLayout 布局方式
 *
 *  @return 返回列边距
 */
- (CGFloat)columnMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
/**
 *  用于返回行边距
 *
 *  @param waterflowLayout 布局方式
 *
 *  @return 返回行边距
 */
- (CGFloat)rowMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
/**
 *  用于返回collectionView的上下左右边距
 *
 *  @param waterflowLayout 布局方式
 *
 *  @return  collectionView的上下左右边距
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
@end

@interface WaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<WaterflowLayoutDelegate> delegate;

@end

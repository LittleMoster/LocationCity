//
//  WaterflowLayout.m
//  CollectionViewLayout
//
//  Created by cguo on 2017/5/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "WaterflowLayout.h"

/** 默认的列数 */
static const NSInteger DefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat DefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat DefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets DefaultEdgeInsets = {10, 10, 10, 10};

@interface WaterflowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;
//方法的申明
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
@end

@implementation WaterflowLayout

#pragma mark - 常见数据处理（代理返回数据封装成get方法处理）
//item行距
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return DefaultRowMargin;
    }
}
//item列间距
- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return DefaultColumnMargin;
    }
}
//列数
- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
        
    } else {
        return DefaultColumnCount;
    }
}
//item边缘距离
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return DefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
/** 存放所有列的当前高度 */
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
/** 存放所有cell的布局属性 */
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    //    清空内容高度
    self.contentHeight = 0;
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置布局属性的frame，取出每列的宽度
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    //取出每列的高度
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        //        比较取出最短那列
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    //    最短那列的y值
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {//如果不是第一列就添加行距
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度，已有新的item添加到该列，所以要更新该列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 记录内容最高的高度，用最高的高度为CollectionView的内容高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}
//返回collectionView的内容宽和高
- (CGSize)collectionViewContentSize
{
    //    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    //    for (NSInteger i = 1; i < self.columnCount; i++) {
    //        // 取得第i列的高度
    //        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
    //
    //        if (maxColumnHeight < columnHeight) {
    //            maxColumnHeight = columnHeight;
    //        }
    //    }
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}


@end

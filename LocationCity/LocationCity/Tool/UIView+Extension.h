//
//  UIView+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    Random,                     //随机
} AnimationType;



typedef enum : NSUInteger {
    
    TransitionFromBottom,  //下
    TransitionFromTop,     //上
    TransitionFromLeft,    //左
    TransitionFromRight,   //右
    RandomFrom,            //随机
}kCATransitionFrom;
@interface UIView (Extension)

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property (nonatomic, assign) CGSize size;
/**  该方法用于判断当前视图是否显示在Window上*/
- (BOOL)isShowingOnKeyWindow;

/**
 *用于播放动画
 */
-(void)beginAnimationWithType:(AnimationType)animationType withTransition:(kCATransitionFrom)transitionFrom animateWithDuration:(CGFloat)duration;

/**
 * 延迟播放动画
 */
-(void)beginAnimationWithType:(AnimationType)animationType withTransition:(kCATransitionFrom)transitionFrom animateWithDuration:(CGFloat)duration afterTime:(float)time;
/**
 * 为view添加点击事件
 */
-(void)addTarget:(id)target Action:(SEL)action;
/**
 * 设置push控制器时有动画
 */
-(void)pushToNavtionViewController:(UIViewController*)ViewCtl anitam:(AnimationType)animatType;

/**
 * UIView的push跳转
 */
-(void)pushToNavtionViewController:(UIViewController*)ViewCtl animated:(BOOL)animated;

-(void)popToRootNavtionViewControllerAnimted:(BOOL)animted;
/**
 *获取view所在的控制器
 */
- (UIViewController*)viewController;

/**
 *背景色渐变--设置渐变的方向
 */
-(void)setColorGradientWithstartPoint:(CGPoint)startpoint endpoint:(CGPoint)endpoint withSize:(CGSize)size;

@end

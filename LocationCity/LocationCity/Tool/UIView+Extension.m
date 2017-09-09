//
//  UIView+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>
#import <objc/message.h>

CA_EXTERN NSString * const kCATransitionFromRight
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCATransitionFromLeft
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCATransitionFromTop
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCATransitionFromBottom
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
@implementation UIView (Extension)

-(void)popToRootNavtionViewControllerAnimted:(BOOL)animted
{
    [self.viewController.navigationController popToRootViewControllerAnimated:animted];
}
-(void)pushToNavtionViewController:(UIViewController*)ViewCtl animated:(BOOL)animated
{
    [self.viewController.navigationController pushViewController:ViewCtl animated:animated];
}
-(void)pushToNavtionViewController:(UIViewController*)ViewCtl anitam:(AnimationType)animatType
{
    [self.viewController.navigationController pushViewController:ViewCtl animated:NO];
    
    ViewCtl.navigationController.navigationBarHidden=YES;
    [ViewCtl.view beginAnimationWithType:animatType withTransition:TransitionFromLeft animateWithDuration:0.9];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ViewCtl.navigationController.navigationBarHidden=NO;
    });
    
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)addTarget:(id)target Action:(SEL)action
{
    self.v_target=NSStringFromClass([target class]);
    self.v_selAction=NSStringFromSelector(action);
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    
    
    [self addGestureRecognizer:tapgesture];
    
}

-(void)viewCilck:(UITapGestureRecognizer*)tap
{
    if (tap.state==UIGestureRecognizerStateBegan) {
        
        if (self.v_selAction !=nil && self.v_target !=nil) {
//            objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([self.v_target  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([self.v_selAction UTF8String])) ;
        }
        
    }
}

//target成员属性
-(void)setV_target:(id)object {
    objc_setAssociatedObject(self, @selector(v_target), object,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (NSString*)v_target {
    return objc_getAssociatedObject(self, @selector(v_target));
}
//事件的成员属性
- (void)setV_selAction:(id)object {
    objc_setAssociatedObject(self, @selector(v_selAction),object,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (NSString *)v_selAction {
    return objc_getAssociatedObject(self, @selector(v_selAction));
}

-(void)beginAnimationWithType:(AnimationType)animationType withTransition:(kCATransitionFrom)transitionFrom animateWithDuration:(CGFloat)duration
{
    //不延迟会导致动画无法执行
    [self beginAnimationWithType:animationType withTransition:transitionFrom animateWithDuration:duration afterTime:0.1];
}

-(void)beginAnimationWithType:(AnimationType)animationType withTransition:(kCATransitionFrom)transitionFrom animateWithDuration:(CGFloat)duration afterTime:(float)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *subtypeString;
        if (transitionFrom==RandomFrom) {
            int num=arc4random()%4;
            NSLog(@"%d",num);
            switch (num) {
                case 0:
                    subtypeString=kCATransitionFromTop;
                    break;
                case 1:
                    subtypeString=kCATransitionFromBottom;
                    break;
                case 2:
                    subtypeString=kCATransitionFromLeft;
                    break;
                case 3:
                    subtypeString=kCATransitionFromRight;
                    break;
                default:
                    break;
            }
        }else{
            
            if (transitionFrom==TransitionFromTop) {
                subtypeString=kCATransitionFromTop;
                
            }else  if (transitionFrom==TransitionFromBottom) {
                subtypeString=kCATransitionFromBottom;
                
            }else  if (transitionFrom==TransitionFromLeft) {
                subtypeString=kCATransitionFromLeft;
                
            }else  if (transitionFrom==TransitionFromRight) {
                subtypeString=kCATransitionFromRight;
                
            }
        }
        if (animationType==Random) {
            int num=arc4random()%16;
            NSLog(@"%d",num);
            switch (num) {
                case 0:
                    [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 1:
                    [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 2:
                    [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 3:
                    [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 4:
                    [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 5:
                    [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 6:
                    [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 7:
                    [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 8:
                    [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 9:
                    [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 10:
                    [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case 11:
                    [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:self animateWithDuration:duration];
                    break;
                    
                case 12:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionCurlDown animateWithDuration:duration];
                    break;
                    
                case 13:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionCurlUp animateWithDuration:duration];
                    break;
                    
                case 14:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft animateWithDuration:duration];
                    break;
                    
                case 15:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionFlipFromRight animateWithDuration:duration];
                    break;
                    
                default:
                    break;
                    
            }
            
            
        }
        else
        {
            switch (animationType) {
                case Fade:
                    [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case Push:
                    [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case Reveal:
                    [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case MoveIn:
                    [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case Cube:
                    [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case SuckEffect:
                    [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case OglFlip:
                    [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case RippleEffect:
                    [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case PageCurl:
                    [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case PageUnCurl:
                    [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case CameraIrisHollowOpen:
                    [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self animateWithDuration:self.zy_duration];
                    break;
                    
                case CameraIrisHollowClose:
                    [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:self animateWithDuration:duration];
                    break;
                    
                case CurlDown:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionCurlDown animateWithDuration:duration];
                    break;
                    
                case CurlUp:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionCurlUp animateWithDuration:duration];
                    break;
                    
                case FlipFromLeft:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft animateWithDuration:duration];
                    break;
                    
                case FlipFromRight:
                    [self animationWithView:self WithAnimationTransition:UIViewAnimationTransitionFlipFromRight animateWithDuration:duration];
                    break;
                    
                default:
                    break;
            }
        }
        
        
    });
    
}



#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view animateWithDuration:(CGFloat)duration
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = duration;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}



#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition animateWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}


-(void)setColorGradientWithstartPoint:(CGPoint)startpoint endpoint:(CGPoint)endpoint withSize:(CGSize)size
{
    
    CAGradientLayer *gradientNavLayer = [CAGradientLayer layer];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width , size.height)];
    [self addSubview:view];
    [self  sendSubviewToBack:view];
    gradientNavLayer.frame =CGRectMake(0, 0, size.width , size.height);
    NSLog(@"%f-%f",size.width,size.height);
    //设置渐变色（即颜色数组）
    
    gradientNavLayer.colors = @[(id)[UIColor colorWithRed:249.0/255.0 green:223.0/255.0 blue:102.0/255.0 alpha:1].CGColor,
                                (id)[UIColor colorWithRed:244.0/255.0 green:221.0/255.0 blue:88.0/255.0 alpha:1].CGColor,
                                (id)[UIColor colorWithRed:235.0/255.0 green:202.0/255.0 blue:68.0/255.0 alpha:1].CGColor];
    
    //    gradientLayer.colors = @[(id)[UIColor blueColor].CGColor,(id)[UIColor redColor].CGColor];
    //变化位置或变化点
    gradientNavLayer.locations =@[@(0.1f),@(0.6f)];
    
    //渐变方向
    gradientNavLayer.startPoint =startpoint;
    gradientNavLayer.endPoint = endpoint;
    [view.layer addSublayer:gradientNavLayer];
}


/**
 *  该方法用于判断当前视图是否显示在Window上
 *
 *  @return YES表示在，NO表示不在
 */

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

- (void)setZy_duration:(float)duration {
    objc_setAssociatedObject(self, @selector(zy_duration), @(duration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (float)zy_duration {
    return [objc_getAssociatedObject(self, @selector(zy_duration))floatValue];
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
-(void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(void)setY:(CGFloat)y
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
-(CGFloat)centerX
{
    return self.center.x;
}
-(CGFloat)centerY
{
    return self.center.y;
}
-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


@end

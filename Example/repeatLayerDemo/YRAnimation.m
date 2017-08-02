//
//  YRAnimation.m
//  repeatLayerDemo
//
//  Created by 　yangrui on 2017/8/2.
//  Copyright © 2017年 TangchangTomYang. All rights reserved.
//

#import "YRAnimation.h"

@implementation YRAnimation

#pragma mark- 动画
+(CABasicAnimation *)scaleAnimation{

//    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    
//    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0, 0, 0)];
//    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0,1.0,0)];
//    
//    return scaleAnim;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    return scale;
    
    
    
}

+(CABasicAnimation *)scaleAnimationOne{
    

    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    scaleAnim.autoreverses = YES;
    scaleAnim.repeatCount = HUGE;
    scaleAnim.duration = 0.6;
    

    return scaleAnim;
    
}

+(CABasicAnimation *)alphaAnimation{

    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    alphaAnim.fromValue = @(1.0);
    alphaAnim.toValue = @(0);
    
    return alphaAnim;
}

+(CABasicAnimation *)rotationAnimation:(CGFloat)transX{

    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, 0, 0, 0,0)];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, transX, 0, 0)];
    
    scaleAnim.autoreverses = NO;
    scaleAnim.repeatCount = HUGE;
    scaleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnim.duration = 0.8;
    
    return scaleAnim;
    
    
//    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
//    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
//    scale.fromValue = [NSValue valueWithCATransform3D:fromValue];
//    
//    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0.0, 0.0);
//    toValue = CATransform3DRotate(toValue,120.0*M_PI/180.0, 0.0, 0.0, 1.0);
//    
//    scale.toValue = [NSValue valueWithCATransform3D:toValue];
//    scale.autoreverses = NO;
//    scale.repeatCount = HUGE;
//    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    scale.duration = 0.8;
//    return scale;
//
    
}


#pragma mark- 图层
+ (CALayer *)replicatorLayer_Circle{
    
    CGRect frame = CGRectMake(0, 0, 80, 80);
    

    //1. 形状图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = frame;
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:frame ].CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.opacity = 1;
    
    
    //2. 形状图层添加组动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self alphaAnimation], [self scaleAnimation]];
    animationGroup.duration = 4.0;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = HUGE; //无穷大
    [shapeLayer addAnimation:animationGroup forKey:@"animationGroup"];
    
//    shapeLayer.backgroundColor = [UIColor orangeColor].CGColor;
    //3. 形状图层添加到 replicatorlayer上
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = frame;
    replicatorLayer.instanceDelay = 0.5;
    replicatorLayer.instanceCount = 8;
    [replicatorLayer addSublayer:shapeLayer];
    
//    replicatorLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    return replicatorLayer;
    
}

+ (CALayer *)replicatorLayer_Wave{
    
    CGFloat between = 5.0;
    CGFloat radius = (100 - 2*between)/3.0;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, (100 - radius) * 0.5 , radius, radius);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.backgroundColor = [UIColor greenColor].CGColor;
    [shapeLayer addAnimation:[self scaleAnimationOne] forKey:@"scaleAnimation"];
    
    
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame  = CGRectMake(0, 0, 100, 100);
    replicatorLayer.instanceDelay = 0.2;
    // 重复多少个
    replicatorLayer.instanceCount = 5;
    // 重复的实例 间距  (决定重复的 子实例 的排布情况)
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(between * 2 +20 + radius,0, 0);
    [replicatorLayer addSublayer:shapeLayer];
    
    return replicatorLayer;
    
}

+ (CALayer *)replicatorLayer_Triangle{
    
    CGFloat radius = 100 / 4;
    CGFloat transX = 100 - radius;
    
    
    CGRect frame = CGRectMake(0, 0, radius, radius);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = frame;
    
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    
    shapeLayer.lineWidth = 1.0;
    
    [shapeLayer addAnimation:[self rotationAnimation:transX] forKey:@"rotateAnimation"];
    
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = frame;
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 3;
    
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120.0  * M_PI / 180.0, 0, 0, 1.0);
    replicatorLayer.instanceTransform = trans3D;
    
    [replicatorLayer addSublayer:shapeLayer];
//    replicatorLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    return replicatorLayer;
    
}

+ (CALayer *)replicatorLayer_Grid{
    
    NSInteger column = 3;
    CGFloat between = 5.0;
    
    CGFloat radius = (100 - between * (column -1))/column;
    CGRect frame = CGRectMake(0, 0, radius, radius);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = frame ;
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:frame].CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[[self scaleAnimationOne], [self alphaAnimation]];
    animGroup.duration = 2.0;
    animGroup.autoreverses = YES;
    animGroup.repeatCount = HUGE;
    [shapeLayer addAnimation:animGroup forKey:@"groupAnimation"];
    
    
    // x 方向重复
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = column;
    replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius + between, 0, 0);
    [replicatorLayerX addSublayer:shapeLayer];
    
    
    // y 方向重复 x 排布
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
    [replicatorLayerY addSublayer:replicatorLayerX];
    

    
    return replicatorLayerY;
    
}


@end

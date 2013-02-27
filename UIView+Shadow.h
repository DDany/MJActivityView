//
//  UIView+Shadow.h
//  ShadowDemo
//
//  Created by navy on 12-12-24.
//  Copyright (c) 2012年 navy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Shadow)

- (void)addShadow:(UIColor *)shadowColor;
- (void)removeShadow;

@end

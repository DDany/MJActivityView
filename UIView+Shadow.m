//
//  UIView+Shadow.m
//  ShadowDemo
//
//  Created by navy on 12-12-24.
//  Copyright (c) 2012年 navy. All rights reserved.
//

#import "UIView+Shadow.h"


@implementation UIView (Shadow)

- (void)addShadow:(UIColor *)shadowColor
{
#if 0
    // Notice: Bad performance here, when do animations. Do as below instead.
    // http://stackoverflow.com/questions/10133109/fastest-way-to-do-shadows-on-ios/10133182#10133182
    [[self layer] setShadowOffset:CGSizeMake(0, 2)];
    [[self layer] setShadowRadius:8];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowColor:[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
#else
    self.layer.shadowRadius = 8.0;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    CGPathRef path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowPath = path;
    self.layer.shouldRasterize = YES;
    // Don't forget the rasterization scale
    // I spent days trying to figure out why retina display assets weren't working as expected
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
#endif
}

- (void)removeShadow
{
    [[self layer] setShadowOffset:CGSizeZero];
    //[[self layer] setShadowRadius:0];
    [[self layer] setShadowOpacity:0];
    [[self layer] setShadowColor:nil];
}

@end

//
//  MJNavDropView.m
//  DolphinSharing
//
//  Created by Zheng Wang on 13-1-30.
//  Copyright (c) 2013年 Zheng Wang. All rights reserved.
//

#import "MJNavDropView.h"
#import "UIView+Shadow.h"

#define DropDuration  0.3

@interface MJNavDropView ()

@end

@implementation MJNavDropView
{
    BOOL    isShowing;
    BOOL    isAnimating;
    BOOL    isDimBackground;
    BOOL    isBorderShadow;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (id)initWithContainer:(id)container {
    self = [super init];
    if (self) {
        // Initialization code
        self.container = container;
        [self initialize];
    }
    return self;
}

- (void)dealloc {
    self.container = nil;
}

#pragma mark - init
- (void)initialize {
    self.frame = CGRectMake(0, 0, 320, 568);
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    
    [self prepareForContainer];
}

#pragma mark - Private
- (void)prepareForContainer {
    UIView *view = [self containerView];
    
    if (view) {
        view.frame = [self hideFrame];
        
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self addSubview:view];
    }
}

#pragma mark
- (UIView *)containerView {
    if (!self.container) {
        return nil;
    }
    
    if ([self.container isKindOfClass:[UIViewController class]]) {
        return ((UIViewController *)self.container).view;
    }
    
    if ([self.container isKindOfClass:[UIView class]]) {
        return self.container;
    }
    
    return nil;
}

- (CGRect)hideFrame {
    UIView *view = [self containerView];
    
    if (view) {
        CGRect bounds = view.bounds;
        CGRect frame = CGRectMake((self.bounds.size.width - bounds.size.width)/2.0, - bounds.size.height - 20, bounds.size.width, bounds.size.height);
        
        return frame;
    }
    
    return CGRectZero;
}

- (CGRect)showFrame {
    UIView *view = [self containerView];
    
    if (view) {
        CGRect bounds = view.bounds;
        CGRect frame = CGRectMake((self.bounds.size.width - bounds.size.width)/2.0, 0, bounds.size.width, bounds.size.height);
        
        return frame;
    }
    
    return CGRectZero;
}

#pragma mark - Touch handle
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    if (isShowing && !isAnimating
        && !CGRectContainsPoint([self containerView].frame, [[touches anyObject] locationInView:self])) {
        [self hide];
    }
}

#pragma mark - Public
- (void)setContainer:(id)container {
    _container = container;
    
    [self prepareForContainer];
}

- (void)setIsDimBackground:(BOOL)hasDimBackground {
    isDimBackground = hasDimBackground;
}

- (void)setIsBorderShadow:(BOOL)hasBorderShadow {
    isBorderShadow = hasBorderShadow;
}

- (BOOL)isShowing {
    return isShowing;
}

#pragma mark
- (void)show {
    UIView *view = [self containerView];
    
    if (view) {
        view.frame = [self hideFrame];
        isShowing = NO;
        isAnimating = YES;
        self.userInteractionEnabled = YES;
        if (isDimBackground) {
            self.backgroundColor = [UIColor clearColor];
        }
        if (isBorderShadow) {
            [view addShadow:nil];
        }
        [UIView animateWithDuration:DropDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = [self showFrame];
            if (isDimBackground) {
                self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
            }
        } completion:^(BOOL finished) {
            if (finished) {
                isShowing = YES;
                isAnimating = NO;
            }
        }];
    }
}

- (void)hide {
    if (!isShowing) {
        return;
    }
    
    UIView *view = [self containerView];
    
    if (view) {
        view.frame = [self showFrame];
        isShowing = YES;

        isAnimating = YES;
        if (isDimBackground) {
            self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
        }
        [UIView animateWithDuration:DropDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = [self hideFrame];
            if (isDimBackground) {
                self.backgroundColor = [UIColor clearColor];
            }
        } completion:^(BOOL finished) {
            if (finished) {
                self.userInteractionEnabled = NO;
                isShowing = NO;
                isAnimating = NO;
                if (isBorderShadow) {
                    [view removeShadow];
                }
            }
        }];
    }
}

- (void)action {
    if (isShowing) {
        [self hide];
    }else {
        [self show];
    }
}

@end

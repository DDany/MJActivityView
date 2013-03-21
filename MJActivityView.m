//
//  MJNavDropView.m
//  DolphinSharing
//
//  Created by Zheng Wang on 13-1-30.
//  Copyright (c) 2013年 Zheng Wang. All rights reserved.
//

#import "MJActivityView.h"
#import <QuartzCore/QuartzCore.h>

#define DropDuration  0.3

@interface MJActivityView ()

@end

@implementation MJActivityView
{
    BOOL            isShowing;
    BOOL            isAnimating;
    BOOL            isDimBackground;
    BOOL        	isBorderShadow;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code
        _type = MJActivityType_Top;
        [self initialize];
    }
    return self;
}

- (id)initWithContainer:(id)container {
    self = [self init];
    if (self) {
        // Initialization code
        _container = container;
    }
    return self;
}

- (id)initWithContainer:(id)container withType:(MJActivityType)type {
    self = [self initWithContainer:container];
    if (self) {
        _type = type;
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

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.frame = self.superview.bounds;
    
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
        switch (self.type) {
            case MJActivityType_Top:
                return CGRectMake((self.bounds.size.width - bounds.size.width)/2.0,
                                  - bounds.size.height - 20,
                                  bounds.size.width,
                                  bounds.size.height);
                break;
            case MJActivityType_Left:
                return CGRectMake(- bounds.size.width - 20,
                                  (self.bounds.size.height - bounds.size.height)/2.0,
                                  bounds.size.width,
                                  bounds.size.height);
                break;
            case MJActivityType_Bottom:
                return CGRectMake((self.bounds.size.width - bounds.size.width)/2.0,
                                  self.bounds.size.height + 20,
                                  bounds.size.width,
                                  bounds.size.height);
                break;
            case MJActivityType_Right:
                return CGRectMake(self.bounds.size.width + bounds.size.width + 20,
                                  (self.bounds.size.height - bounds.size.height)/2.0,
                                  bounds.size.width,
                                  bounds.size.height);
                break;
            default:
                break;
        }
    }
    
    return CGRectZero;
}

- (CGRect)showFrame {
    UIView *view = [self containerView];
    
    if (view) {
        CGRect bounds = view.bounds;
        switch (self.type) {
            case MJActivityType_Top:
                return CGRectMake((self.bounds.size.width - bounds.size.width)/2.0, 0, bounds.size.width, bounds.size.height);
                break;
            case MJActivityType_Left:
                return CGRectMake(0,
                                  (self.bounds.size.height - bounds.size.height)/2.0,
                                  bounds.size.width,
                                  bounds.size.height);
                break;
            case MJActivityType_Bottom:
                return CGRectMake((self.bounds.size.width - bounds.size.width)/2.0,
                                  self.bounds.size.height - bounds.size.height,
                                  bounds.size.width,
                                  bounds.size.height);
                break;
            case MJActivityType_Right:
                return CGRectMake(self.bounds.size.width - bounds.size.width,
                                  (self.bounds.size.height - bounds.size.height)/2.0,
                                  bounds.size.width,
                                  bounds.size.height);
                break;
            default:
                break;
        }
    }
    
    return CGRectZero;
}

#pragma mark - Action delegate
- (void)willShow {
    if (self.delegate && [self.delegate respondsToSelector:@selector(willShowActivityView:)]) {
        [self.delegate willShowActivityView:self];
    }
}

- (void)didShow {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didShowActivityView:)]) {
        [self.delegate didShowActivityView:self];
    }
}

- (void)willHide {
    if (self.delegate && [self.delegate respondsToSelector:@selector(willHideActivityView:)]) {
        [self.delegate willHideActivityView:self];
    }
}

- (void)didHide {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHideActivityView:)]) {
        [self.delegate didHideActivityView:self];
    }
}

#pragma mark - View shadow
- (void)addShadow {
    UIView *view = [self containerView];
    
    view.layer.shadowRadius = 8.0;
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    CGPathRef path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    view.layer.shadowPath = path;
    view.layer.shouldRasterize = YES;
    // Don't forget the rasterization scale
    // I spent days trying to figure out why retina display assets weren't working as expected
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)removeShadow {
    UIView *view = [self containerView];

    [view.layer setShadowOffset:CGSizeZero];
    [view.layer setShadowOpacity:0];
    [view.layer setShadowColor:nil];
}

#pragma mark - Touch handle
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    if (isShowing && !isAnimating
        && !CGRectContainsPoint([self containerView].frame, [[touches anyObject] locationInView:self])) {
        [self hide];
    }
}

#pragma mark - Public
- (void)setIsDimBackground:(BOOL)hasDimBackground {
    isDimBackground = hasDimBackground;
}

- (void)setIsBorderShadow:(BOOL)hasBorderShadow {
    isBorderShadow = hasBorderShadow;
}

- (void)setType:(MJActivityType)type {
    _type = type;
    
    [self prepareForContainer];
}

- (void)setContainer:(id)container {
    _container = container;
    
    [self prepareForContainer];
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
            [self addShadow];
        }
        
        [self willShow];
        
        [UIView animateWithDuration:DropDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = [self showFrame];
            if (isDimBackground) {
                self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
            }
        } completion:^(BOOL finished) {
            if (finished) {
                isShowing = YES;
                isAnimating = NO;
                
                [self didShow];
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

        [self willHide];
        
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
                    [self removeShadow];
                }
                
                [self didHide];
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

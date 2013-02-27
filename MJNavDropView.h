//
//  MJNavDropView.h
//  DolphinSharing
//
//  Created by Zheng Wang on 13-1-30.
//  Copyright (c) 2013年 Zheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJNavDropView : UIView

////////////////////////////////////////////////////////
// Your best init method.
- (id)initWithContainer:(id)container;

////////////////////////////////////////////////////////
// should show drop view with dim background
// Should be invoked before [- (void)show] method.
- (void)setIsDimBackground:(BOOL)hasDimBackground;

////////////////////////////////////////////////////////
// should add border shadow for container
// Should be invoked before [- (void)show] method.
- (void)setIsBorderShadow:(BOOL)hasBorderShadow;

////////////////////////////////////////////////////////
// current state
- (BOOL)isShowing;

////////////////////////////////////////////////////////
// show animated
- (void)show;

////////////////////////////////////////////////////////
// hide animated
- (void)hide;

////////////////////////////////////////////////////////
// do one action according to current state animted.
// isShowing = YES >> hide
// isShowing = NO  >> show
- (void)action;

@end

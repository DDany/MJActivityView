//
//  MJNavDropView.h
//  DolphinSharing
//
//  Created by Zheng Wang on 13-1-30.
//  Copyright (c) 2013年 Zheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MJActivityType_Top,                             // top-outside in, ex. drop down from navigation bar.
    MJActivityType_Left,                            // left-outside in
    MJActivityType_Bottom,                          // bottom-outside in, just like action sheet
    MJActivityType_Right,                           // right-outside in
    MJActivityType_Custom DEPRECATED_ATTRIBUTE      // do custom action, unfinished
}MJActivityType;

@protocol MJActivityViewDelegate;

@interface MJActivityView : UIView

@property (nonatomic, weak) id<MJActivityViewDelegate> delegate;
@property (nonatomic, strong) id container;             // UIViewController or UIView
@property (nonatomic, assign) MJActivityType type;      // enum MJActivityType
@property (nonatomic, assign) UIEdgeInsets showInsets DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) UIEdgeInsets hideInsets DEPRECATED_ATTRIBUTE;

////////////////////////////////////////////////////////
// Init method.
- (id)initWithContainer:(id)container;
- (id)initWithContainer:(id)container withType:(MJActivityType)type;

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

- (BOOL)isAnimating;

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

@protocol MJActivityViewDelegate <NSObject>
@optional
- (void)willShowActivityView:(MJActivityView *)activityView;
- (void)didShowActivityView:(MJActivityView *)activityView;
- (void)willHideActivityView:(MJActivityView *)activityView;
- (void)didHideActivityView:(MJActivityView *)activityView;
@end

//
//  RateView.h
//  RatePopup
//
//  Created by Anatoli Petrosyants on 8/19/15.
//  Copyright (c) 2015 Anatoli Petrosyants. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OpinionzAlertIconInfo = 1,
    OpinionzAlertIconWarning,
    OpinionzAlertIconSuccess,
    OpinionzAlertIconQuestion,
    OpinionzAlertIconStar,
    OpinionzAlertIconHeart
} OpinionzAlertIcon;

@class OpinionzAlertView;
@protocol OpinionzAlertViewDelegate;

typedef void (^OpinionzPopupViewTapButtonBlock)(OpinionzAlertView *alertView, NSInteger buttonIndex);

@interface OpinionzAlertView : UIView

@property (nonatomic, assign) id<OpinionzAlertViewDelegate> delegate;
@property (nonatomic, copy) OpinionzPopupViewTapButtonBlock buttonDidTappedBlock;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, assign) OpinionzAlertIcon iconType;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id /*<OpinionzAlertViewDelegate>*/)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
      usingBlockWhenTapButton:(OpinionzPopupViewTapButtonBlock)tapButtonBlock;

- (void)show;

- (void)dismiss;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end

@protocol OpinionzAlertViewDelegate <NSObject>
- (void)alertView:(OpinionzAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

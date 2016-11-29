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
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
            defaultHeaderIcon:(UIImage *)defaultIcon;

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

/**
 Call this method to update the icon header image after the alert has been displayed, a common scenario to use this method is when you need to display a header image that is retrieved from a remote URL asynchronously , or when a specafic action happens after some time interval has passed .
 
 @param image the new header image.
 */
-(void)updateHeaderIconWithImage:(UIImage *)image;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end

@protocol OpinionzAlertViewDelegate <NSObject>
- (void)opinionzAlertView:(OpinionzAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

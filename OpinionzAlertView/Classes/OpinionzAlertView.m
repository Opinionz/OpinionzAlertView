//
//  OpinionzAlertView.m
//  OpinionzAlertView
//
//  Created by Opinionz.io on 8/16/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import "OpinionzAlertView.h"

#define kOpinionzAlertWidth   280
#define kOpinionzButtonHeight 44
#define kOpinionzTitleHeight  40
#define kOpinionzHeaderHeight 80

#define kOpinionzTitleLeftMargin 10
#define kOpinionzTitleRightMargin 10
#define kOpinionzMessageLeftMargin 10
#define kOpinionzMessageRightMargin 10

#define kOpinionzDefaultHeaderColor  [UIColor colorWithRed:0.8 green:0.13 blue:0.15 alpha:1]
#define kOpinionzSeparatorColor      [UIColor colorWithRed:0.724 green:0.727 blue:0.731 alpha:1.000]
#define kOpinionzBlueTitleColor      [UIColor colorWithRed:0.071 green:0.431 blue:0.965 alpha:1]
#define kOpinionzLightBlueTitleColor [UIColor colorWithRed:0.071 green:0.431 blue:0.965 alpha:0.4]

@interface OpinionzAlertView ()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSArray *otherButtonTitles;

@end

@implementation OpinionzAlertView


#pragma mark - initializers

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
{
    return [self initWithTitle:title
                       message:message
                      delegate:nil
             cancelButtonTitle:cancelButtonTitle
             otherButtonTitles:otherButtonTitles];
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
      usingBlockWhenTapButton:(OpinionzPopupViewTapButtonBlock)tapButtonBlock
{
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
    
    self.buttonDidTappedBlock = tapButtonBlock;
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id /*<OpinionzAlertViewDelegate>*/)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
        
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitles = otherButtonTitles;
        
        // helpers
        CGSize screenSize = [self screenSize];
        CGFloat screenHeight = screenSize.height;
        CGFloat screenWidth = screenSize.width;
        CGFloat headerHeight = kOpinionzHeaderHeight;
        CGFloat titleHeight = kOpinionzTitleHeight;
        
        // self
        [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        
        // buttons height calculation
        CGFloat buttonsHeight = 0;
        
        if (cancelButtonTitle || [otherButtonTitles count] == 1) {
            buttonsHeight = kOpinionzButtonHeight;
        }
        
        // if more then 2 buttons, place buttons vertically, else show them horizontally
        if ([otherButtonTitles count] > 1) {
            
            buttonsHeight += [otherButtonTitles count] * kOpinionzButtonHeight;
        }
        
        // alert height calculation
        CGFloat boundingRectHeight = [self boundingRectHeightWithText:message font:[UIFont systemFontOfSize:14]];
        CGFloat alertHeight = boundingRectHeight + buttonsHeight + headerHeight + titleHeight;
        
        // alert view
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - kOpinionzAlertWidth)/2,
                                                                  (screenHeight - alertHeight)/2, kOpinionzAlertWidth, alertHeight)];
        [self.alertView setBackgroundColor:[UIColor clearColor]];
        self.alertView.layer.masksToBounds = YES;
        self.alertView.layer.cornerRadius = 7;
        [self addSubview:self.alertView];

        // background effect
        if (NSClassFromString(@"UIVisualEffectView") != nil) {
            
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            visualEffectView.frame = self.alertView.bounds;
            [self.alertView addSubview:visualEffectView];
        } else {
            
            [self.alertView setBackgroundColor:[UIColor whiteColor]];
        }
        
        // header view
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.alertView.bounds), headerHeight)];
        [self.headerView setBackgroundColor:kOpinionzDefaultHeaderColor];
        [self.alertView addSubview:self.headerView];
        
        // icon imageview
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.headerView.bounds) - 50)/2,
                                                                                   (CGRectGetHeight(self.headerView.bounds) - 50)/2, 50, 50)];
        [self.iconImageView setUserInteractionEnabled:YES];
        [self.iconImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.iconImageView.autoresizingMask = ( UIViewAutoresizingFlexibleBottomMargin
                                          | UIViewAutoresizingFlexibleHeight
                                          | UIViewAutoresizingFlexibleLeftMargin
                                          | UIViewAutoresizingFlexibleRightMargin
                                          | UIViewAutoresizingFlexibleTopMargin
                                          | UIViewAutoresizingFlexibleWidth );
        [self.headerView addSubview:self.iconImageView];

        // title label
        // title label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kOpinionzTitleLeftMargin, CGRectGetHeight(self.headerView.frame), CGRectGetWidth(self.alertView.bounds) - kOpinionzTitleLeftMargin - kOpinionzTitleRightMargin, titleHeight)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setText:title];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[self titleFont]];
        [self.alertView addSubview:titleLabel];

        // message view
        CGFloat newLineHeight = [self boundingRectHeightWithText:message font:[self messageFont]];
        UITextView *messageView = [[UITextView alloc] initWithFrame:CGRectMake(kOpinionzTitleLeftMargin, CGRectGetHeight(titleLabel.frame) + CGRectGetHeight(self.headerView.frame) - 10, CGRectGetWidth(self.alertView.bounds) - kOpinionzMessageLeftMargin - kOpinionzMessageRightMargin, newLineHeight)];
        [messageView setText:message];
        [messageView setTextColor:[UIColor blackColor]];
        [messageView setTextAlignment:NSTextAlignmentCenter];
        [messageView setFont:[self messageFont]];
        [messageView setEditable:NO];
        [messageView setUserInteractionEnabled:NO];
        [messageView setDataDetectorTypes:UIDataDetectorTypeNone];
        [messageView setBackgroundColor:[UIColor clearColor]];
        [self.alertView addSubview:messageView];
        
        // buttons view
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, alertHeight - buttonsHeight, kOpinionzAlertWidth, buttonsHeight)];
        [buttonView setBackgroundColor:[UIColor clearColor]];
        [self.alertView addSubview:buttonView];

        // horizontal separator
        CALayer *horizontalBorder = [self separatorAt:CGRectMake(0, 0, buttonView.frame.size.width, 0.5)];
        [buttonView.layer addSublayer:horizontalBorder];

        // adds border between 2 buttons
        if ((cancelButtonTitle && [otherButtonTitles count] == 1) ||
            ([otherButtonTitles count] == 2 && !cancelButtonTitle)) {
            CALayer *centerBorder = [CALayer layer];
            centerBorder.frame = CGRectMake((CGRectGetWidth(buttonView.frame) - 0.5)/2, 0.0f, 0.5f, CGRectGetHeight(buttonView.frame));
            centerBorder.backgroundColor = kOpinionzSeparatorColor.CGColor;
            [buttonView.layer addSublayer:centerBorder];
        }
        [self.alertView addSubview:buttonView];
        
        // setup cancel button
        if (cancelButtonTitle) {
            
            UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            if ([otherButtonTitles count] == 1) {
                // Cancel button & 1 other button
                cancelButton.frame = CGRectMake(0, 0, kOpinionzAlertWidth/2, kOpinionzButtonHeight);
            }
            else {
                // Cancel button + multiple other buttons
                cancelButton.frame = CGRectMake(0, buttonsHeight-41+0.5, kOpinionzAlertWidth, kOpinionzButtonHeight);
            }

            [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [cancelButton setTitleColor:kOpinionzBlueTitleColor forState:UIControlStateNormal];
            [cancelButton setTitleColor:kOpinionzLightBlueTitleColor forState:UIControlStateHighlighted];
            [cancelButton setTitleColor:kOpinionzLightBlueTitleColor forState:UIControlStateSelected];
            [cancelButton setBackgroundColor:[UIColor clearColor]];
            cancelButton.titleLabel.font = [self cancelButtonFont];
            [cancelButton addTarget:self action:@selector(alertButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
            [cancelButton setTag:0];
            [buttonView addSubview:cancelButton];
        }

        // setup other buttons
        for (int i = 0; i < [otherButtonTitles count]; i++) {
            UIButton *otherTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ([otherButtonTitles count] == 1 && !cancelButtonTitle) {
                // 1 other button and no cancel button
                otherTitleButton.frame = CGRectMake(0, 0, kOpinionzAlertWidth, kOpinionzButtonHeight);
                otherTitleButton.tag = 0;
            }
            else if (([otherButtonTitles count] == 2 && !cancelButtonTitle) ||
                     ([otherButtonTitles count] == 1 && cancelButtonTitle)) {
                // 2 other buttons, no cancel or 1 other button and cancel
                otherTitleButton.tag = i+1;
                otherTitleButton.frame = CGRectMake(140.5, 0, 139.5, kOpinionzButtonHeight);
            }
            else if ([otherButtonTitles count] >= 2) {
                if (cancelButtonTitle) {
                    otherTitleButton.frame = CGRectMake(0, (i*kOpinionzButtonHeight)+0.5, kOpinionzAlertWidth, kOpinionzButtonHeight);
                    otherTitleButton.tag = i+1;
                }
                else {
                    otherTitleButton.frame = CGRectMake(0, i*kOpinionzButtonHeight, kOpinionzAlertWidth, kOpinionzButtonHeight);
                    otherTitleButton.tag = i;
                }
                CALayer *horizontalBorder = [CALayer layer];
                CGFloat borderY = CGRectGetMaxY(otherTitleButton.frame)-0.5;
                horizontalBorder.frame = CGRectMake(0.0f, borderY, buttonView.frame.size.width, 0.5f);
                horizontalBorder.backgroundColor = [UIColor colorWithRed:0.724 green:0.727 blue:0.731 alpha:1.000].CGColor;
                [buttonView.layer addSublayer:horizontalBorder];
            }
            
            [otherTitleButton addTarget:self action:@selector(alertButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
            [otherTitleButton setTitle:otherButtonTitles[i] forState:UIControlStateNormal];
            [otherTitleButton setTitleColor:kOpinionzBlueTitleColor forState:UIControlStateNormal];
            [otherTitleButton setTitleColor:kOpinionzLightBlueTitleColor forState:UIControlStateHighlighted];
            [otherTitleButton setTitleColor:kOpinionzLightBlueTitleColor forState:UIControlStateSelected];
            [otherTitleButton setBackgroundColor:[UIColor clearColor]];
            otherTitleButton.titleLabel.font = [self buttonsFont];
            [buttonView addSubview:otherTitleButton];
        }
        
        // Motion effects
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
        [self.alertView addMotionEffect:group];
    }
    return self;
}

// MARK: Setters/Getters
- (UIFont *)titleFont {
    return [UIFont boldSystemFontOfSize:17];
}

- (UIFont *)messageFont {
    return [UIFont systemFontOfSize:14];
}

- (UIFont *)buttonsFont {
    return [UIFont systemFontOfSize:17];
}

- (UIFont *)cancelButtonFont {
    return [UIFont boldSystemFontOfSize:16];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle;
    
    if (buttonIndex == 0) {
        
        buttonTitle = self.cancelButtonTitle;
    }
    else if(buttonIndex-1 < [self.otherButtonTitles count]) {
    
        buttonTitle = self.otherButtonTitles[buttonIndex-1];
    }
    return buttonTitle;
}

// MARK: alert button handler

- (void)alertButtonDidTapped:(UIButton *)button {
    if (self.delegate != nil) {
        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
    }
    
    if (self.buttonDidTappedBlock != nil) {
        self.buttonDidTappedBlock(self, button.tag);
    }
    
    [self dismiss];
}

// MARK: show/dismiss methods

- (void)show {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            [window addSubview:self];
            break;
        }
    }
    
    self.headerView.backgroundColor = self.color ? self.color : kOpinionzDefaultHeaderColor;
    
    
    // [iconImageView setImage:[[UIImage alloc] initWithContentsOfFile:imageName]];
    // [iconImageView setImage:icon];

    if (self.icon) {
        [self.iconImageView setImage:self.icon];
    }
    else if (self.iconType) {
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"OpinionzAlertView" ofType:@"bundle"];
        if (!bundlePath) {
            
            bundlePath = [[NSBundle bundleForClass:OpinionzAlertView.class] pathForResource:@"OpinionzAlertView" ofType:@"bundle"];
        }
        
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        if (!bundle) {
            
            bundle = [NSBundle mainBundle];
        }
        
        NSString *imageName;
        UIColor *headerColor;
        
        switch (self.iconType) {
            case OpinionzAlertIconInfo:
                // imageName = [bundle pathForResource:@"OpinionzAlertIconInfo" ofType:@"png"];
                imageName = @"OpinionzAlertIconInfo";
                headerColor = [UIColor colorWithRed:0.89 green:0.49 blue:0.19 alpha:1];
                break;
            case OpinionzAlertIconWarning:
                imageName = @"OpinionzAlertIconWarning";
                headerColor = [UIColor colorWithRed:0.79 green:0.14 blue:0.17 alpha:1];
                // imageName = [bundle pathForResource:@"OpinionzAlertIconWarning" ofType:@"png"];
                break;
            case OpinionzAlertIconSuccess:
                imageName = @"OpinionzAlertIconSuccess";
                headerColor = [UIColor colorWithRed:0.15 green:0.68 blue:0.38 alpha:1];
                // imageName = [bundle pathForResource:@"OpinionzAlertIconSuccess" ofType:@"png"];
                break;
            case OpinionzAlertIconQuestion:
                imageName = @"OpinionzAlertIconQuestion";
                headerColor = [UIColor colorWithRed:0.29 green:0.67 blue:0.97 alpha:1];
                // imageName = [bundle pathForResource:@"OpinionzAlertIconQuestion" ofType:@"png"];
                break;
            case OpinionzAlertIconStar:
                imageName = @"OpinionzAlertIconStar";
                headerColor = [UIColor colorWithRed:0.31 green:0.67 blue:0.96 alpha:1];
                // imageName = [bundle pathForResource:@"OpinionzAlertIconStar" ofType:@"png"];
                break;
            case OpinionzAlertIconHeart:
                imageName = @"OpinionzAlertIconHeart";
                headerColor = [UIColor colorWithRed:0.61 green:0.36 blue:0.7 alpha:1];
                // imageName = [bundle pathForResource:@"OpinionzAlertIconHeart" ofType:@"png"];
                break;
            default:
                break;
        }
        
        [self.iconImageView setImage:[[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:imageName ofType:@"png"]]];
        [self.headerView setBackgroundColor:headerColor];
    }
    else {
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"OpinionzAlertView" ofType:@"bundle"];
        if (!bundlePath) {
            
            bundlePath = [[NSBundle bundleForClass:OpinionzAlertView.class] pathForResource:@"OpinionzAlertView" ofType:@"bundle"];
        }

        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *imageName = [bundle pathForResource:@"OpinionzAlertIconSuccess" ofType:@"png"];
        [self.iconImageView setImage:[[UIImage alloc] initWithContentsOfFile:imageName]];
    }
    
    
    self.alertView.layer.opacity = 0.5f;
    self.alertView.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         self.alertView.layer.opacity = 1.0f;
                         self.alertView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alertView.transform = CGAffineTransformScale(self.alertView.transform, 0.8f, 0.8f);
                         self.alertView.alpha = 0.0f;
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [self performSelector:@selector(removeFromSuperview) withObject:self];
                     }];
}

// MARK: Helpers

// Helper function: count and return the screen's size
- (CGSize)screenSize
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // On iOS7, screen width and height doesn't automatically follow orientation
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    
    return CGSizeMake(screenWidth, screenHeight);
}

// Helper function: line for buttons
- (CALayer *)separatorAt:(CGRect)rect {
    CALayer *border = [CALayer layer];
    border.frame = rect;
    border.backgroundColor = kOpinionzSeparatorColor.CGColor;
    return border;
}

// Helper function: float that indicate bottom offset y
- (CGFloat)bottomOffsetWithView:(UIView *)view {
    return CGRectGetHeight(view.bounds) + CGRectGetMinY(view.bounds);
}

// Helper function: get text height with string and font
- (CGFloat)boundingRectHeightWithText:(NSString *)text font:(UIFont *)font {
    CGSize maximumSize = CGSizeMake(270, CGFLOAT_MAX);
    CGRect boundingRect = [text boundingRectWithSize:maximumSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font} context:nil];
    return boundingRect.size.height + 10;
}

@end
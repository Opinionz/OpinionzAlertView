# OpinionzAlertView

[![CI Status](http://img.shields.io/travis/Opinionz/OpinionzAlertView.svg?style=flat)](https://travis-ci.org/Opinionz/OpinionzAlertView)
[![Version](https://img.shields.io/cocoapods/v/OpinionzAlertView.svg?style=flat)](http://cocoapods.org/pods/OpinionzAlertView)
[![License](https://img.shields.io/cocoapods/l/OpinionzAlertView.svg?style=flat)](http://cocoapods.org/pods/OpinionzAlertView)
[![Platform](https://img.shields.io/cocoapods/p/OpinionzAlertView.svg?style=flat)](http://cocoapods.org/pods/OpinionzAlertView)

Introduction
--------------

Beautiful customizable alert view with blocks. Choose from predefined icons for info, warning, success and error alerts. Customize color or set your desired image.

Preview
--------------
![Preview](https://raw.githubusercontent.com/Opinionz/OpinionzAlertView/assets/screenshots/animated.gif)


Installation
--------------
###Cocoapods

OpinionzAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OpinionzAlertView'
```

###Manual
1. Add the OpinionzAlertView code into your project.

Usage
--------------
NOTE: prompt it after your view did appeared

###Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objective-c
//
//  ViewController.m
//  Demo
//
//  Created by Opinionz.io on 18/08/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import "ViewController.h"

#import <OpinionzAlertView/OpinionzAlertView.h>

- (IBAction)buttonHandlerAlert:(id)sender {

    OpinionzAlertView *alertView = [[OpinionzAlertView alloc] initWithTitle:@"Title"
                                                                    message:@"message"
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil];

    //    alertView = [[OpinionzAlertView alloc] initWithTitle:@"Title"
    //                                                 message:@"message"
    //                                       cancelButtonTitle:@"Cancel"
    //                                       otherButtonTitles:nil
    //                                 usingBlockWhenTapButton:^(OpinionzAlertView *alertView, NSInteger buttonIndex) {
    //                                     
    //                                     NSLog(@"Tapped button at index : %li", (long)buttonIndex);
    //                                     NSLog(@"buttonTitle: %@", [alertView buttonTitleAtIndex:buttonIndex]);
    //                                 }];

    [alertView show];
}

```

Configuration
-------------
Set `title`, `message`, `cancelButtonTitle` and `otherButtonTitles`.

Properties
--------------

The OpinionzAlertView has the following properties:
```objective-c
@property (nonatomic, strong) UIColor *color;
```
Color of header backgound

```objective-c
@property (nonatomic, strong) UIImage *icon;
```
Icon on header

```objective-c
@property (nonatomic, assign) OpinionzAlertIcon iconType;
```

Or you can choose icon type

```objective-c
typedef enum : NSUInteger {
    OpinionzAlertIconInfo = 1,
    OpinionzAlertIconWarning,
    OpinionzAlertIconSuccess,
    OpinionzAlertIconQuestion,
    OpinionzAlertIconStar,
    OpinionzAlertIconHeart
} OpinionzAlertIcon;
```


```objective-c
@property (nonatomic, assign) id<OpinionzAlertViewDelegate> delegate;
```
Alert view delegate

```objective-c
@property (nonatomic, copy) OpinionzPopupViewTapButtonBlock buttonDidTappedBlock;
```
Alert view tap block


Methods
--------------

The OpinionzAlertView class has following methods:

```objective-c
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
```

Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 7.0 (Xcode 6.2)


ARC Compatibility
------------------

OpinionzAlertView requires ARC. 

## Author

Opinionz.io, support@opinionz.io

## License

OpinionzAlertView is available under the MIT license. See the LICENSE file for more info.


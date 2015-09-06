# OpinionzAlertView

[![CI Status](http://img.shields.io/travis/Armen/OpinionzAlertView.svg?style=flat)](https://travis-ci.org/Armen/OpinionzAlertView)
[![Version](https://img.shields.io/cocoapods/v/OpinionzAlertView.svg?style=flat)](http://cocoapods.org/pods/OpinionzAlertView)
[![License](https://img.shields.io/cocoapods/l/OpinionzAlertView.svg?style=flat)](http://cocoapods.org/pods/OpinionzAlertView)
[![Platform](https://img.shields.io/cocoapods/p/OpinionzAlertView.svg?style=flat)](http://cocoapods.org/pods/OpinionzAlertView)

Introduction
--------------

Beautiful customizable alert view with blocks. Choose from predefined icons for info, warning, success and error alerts. Customize color or set your desired image.

Installation
--------------
###Cocoapods

OpinionzAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OpinionzAlertView', '~> 0.1.0'
```

###Manual
1. Add the OpinionzAlertView code into your project.


Usage
--------------
1. Add `#import <OpinionzRate.h>`
2. Call `[[OpinionzAlertView sharedInstance] promptForRating]` at your desired action

NOTE: prompt it after your view did appeared

###Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objective-c
//
//  AppDelegate.m
//  Demo
//
//  Created by Opinionz.io on 18/08/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import <OpinionzRate.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.

[[OpinionzRate sharedInstance] setupWithAppStoreId:995007460];

return YES;
}
```

```objective-c
//
//  ViewController.m
//  Demo
//
//  Created by Opinionz.io on 18/08/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import "ViewController.h"

#import <OpinionzRate.h>

- (IBAction)buttonHandlerRate:(id)sender {
//Optional customization
//    [OpinionzRate sharedInstance].title = @"Do you love our app?";
//    [OpinionzRate sharedInstance].message = @"Would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!";
//    [OpinionzRate sharedInstance].cancelTitle = @"No, thanks";
//    [OpinionzRate sharedInstance].rateTitle = @"Rate now";
//    [OpinionzRate sharedInstance].rateLaterTitle = @"Remind me later";

[[OpinionzRate sharedInstance] promptForRating];
}
```

Configuration
-------------
You can set `title`, `message`, `cancelTitle`, `rateTitle` and `rateLaterTitle` messages. If some of them are not set, default values will be used.

Properties
--------------

The OpinionzRate has the following properties:
```objective-c
@property (nonatomic, strong) NSString *title;
```
Title of the rate popup (default is __"Enjoying _Application name_?"__

```objective-c
@property (nonatomic, strong) NSString *message;
```
Message of the rate popup (default is "__Would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!__"


```objective-c
@property (nonatomic, strong) NSString *cancelTitle;
```
Cancel button title (default is __"No, Thanks"__


```objective-c
@property (nonatomic, strong) NSString *rateTitle;
```
Rate button title (default is __"Rate me"__

```objective-c
@property (nonatomic, strong) NSString *rateLaterTitle;
```
Rate later button title (default is __"Remind me later"__


Methods
--------------

The OpinionzRate class has the following methods:
```objective-c
+ (OpinionzRate *)sharedInstance;
```
Required method for getting single manager. The recommended way to set library into your application is to place a call to sharedInstance in your -application:didFinishLaunchingWithOptions: method.


```objective-c
- (void)setupWithAppStoreId:(NSUInteger)appStoreID;
```
Register app with store id and start using Opinionz SDK.


```objective-c
- (void)promptForRating;
```
Show rate popup at your desired time

Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 7.0 (Xcode 6.2)


ARC Compatibility
------------------

OpinionzRate requires ARC. 

Protocols
---------------

Thread Safety
--------------

Release Notes
----------------

Version 1.0

- Release version.

## Author

Opinionz.io, support@opinionz.io

## License

OpinionzRate is available under the MIT license. See the LICENSE file for more info.


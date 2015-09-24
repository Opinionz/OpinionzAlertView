//
//  OPZViewController.m
//  OpinionzAlertView
//
//  Created by Opinionz.io on 09/06/2015.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import "OPZViewController.h"

#import <OpinionzAlertView/OpinionzAlertView.h>

@interface OPZViewController ()

@end

@implementation OPZViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)successAction:(id)sender {
    
    OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:@"Congratulations"
                                                                message:@"You have just displayed this awesome alert view"
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
    alert.iconType = OpinionzAlertIconSuccess;
    alert.color = [UIColor colorWithRed:0.15 green:0.68 blue:0.38 alpha:1];
    [alert show];
}

- (IBAction)warningAction:(id)sender {
    
    OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:@"Warning"
                                                                message:@"No internet, please check network connection and try again."
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
    alert.iconType = OpinionzAlertIconWarning;
    [alert show];
}

- (IBAction)infoAction:(id)sender {
    
    OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:@"Info"
                                                                message:@"No internet, please check network connection and try again."
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
    alert.iconType = OpinionzAlertIconInfo;
    [alert show];
}

- (IBAction)customIconAction:(id)sender {
    
    OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:@"Custom alert"
                                                                message:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
    alert.icon = [UIImage imageNamed:@"heart"];
    alert.color = [UIColor colorWithRed:0.61 green:0.35 blue:0.71 alpha:1];
    [alert show];
}

- (IBAction)delegateAction:(id)sender {
    
    OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:@"Rate The App"
                                                                message:@"If you enjoy using this app, would you mind taking a moment to rate it? Thanks for your support!"
                                                               delegate:self
                                                      cancelButtonTitle:@"No, thanks"
                                                      otherButtonTitles:@[@"Rate the app", @"Remind me later"]];
    alert.icon = [UIImage imageNamed:@"heart"];
    [alert show];
}

- (IBAction)blockAction:(id)sender {
    
    OpinionzAlertView *alert = [[OpinionzAlertView alloc] initWithTitle:@"Rate The App"
                                                                message:@"If you enjoy using this app, would you mind taking a moment to rate it? Thanks for your support!"
                                                      cancelButtonTitle:@"No, thanks"
                                                      otherButtonTitles:@[@"Rate the app", @"Remind me later"]
                                                usingBlockWhenTapButton:^(OpinionzAlertView *alertView, NSInteger buttonIndex) {
                                                    
                                                    NSLog(@"buttonIndex: %li", (long)buttonIndex);
                                                    NSLog(@"buttonTitle: %@", [alertView buttonTitleAtIndex:buttonIndex]);
                                                }];
    
    alert.icon = [UIImage imageNamed:@"heart"];
    [alert show];
}

// MARK: OpinionzAlertViewDelegate

- (void)alertView:(OpinionzAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"buttonIndex: %li", (long)buttonIndex);
    NSLog(@"buttonTitle: %@", [alertView buttonTitleAtIndex:buttonIndex]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

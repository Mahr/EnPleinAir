//
// Created by Joel Drotleff on 12/16/13.
// Copyright (c) 2013 1Appworks, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NJKWebViewProgress.h"


@interface BasicWebViewController : UIViewController <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property(nonatomic, copy) NSString *url;
@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, retain) UIViewController *parentVC;
@property (nonatomic, assign) BOOL shouldRehideNavBar;

- (id)initWithURL:(NSString *)url;

@end
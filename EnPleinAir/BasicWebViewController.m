//
// Created by Joel Drotleff on 12/16/13.
// Copyright (c) 2013 1Appworks, Inc. All rights reserved.
//


#import "BasicWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@implementation BasicWebViewController  {
    UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (id)initWithURL:(NSString *)url   {
    self = [super init];
    if (self)   {
        self.url = url;
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.frame = self.view.bounds;
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;

    _webView.scrollView.scrollEnabled = YES;
    _webView.scalesPageToFit = YES;

    CGFloat progressBarHeight = 5;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    
    _progressView.progressBarView.backgroundColor = [UIColor blueColor];

//    self.closeButton = ({
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, 0, 50, 50);
//        button.backgroundColor = [UIColor clearColor];
//        [button setImage:[UIImage imageNamed:@"closeX-60x60"] forState:UIControlStateNormal];
//        button;
//    });
//
//    [_closeButton addTarget:self action:@selector(doCloseInfoButton) forControlEvents:UIControlEventTouchUpInside];
//    [_webView addSubview:_closeButton];
}


- (void)doCloseInfoButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];

    if (_shouldRehideNavBar)
        [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}



@end
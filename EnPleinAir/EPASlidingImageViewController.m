//
//  EPASlidingImageViewController.m
//  EnPleinAir
//
//  Created by Sean Brady on 5/5/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPASlidingImageViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "constants.h"
#import "EPALandscape.h"
#import "UIImageView+WebCache.h"

@interface EPASlidingImageViewController ()

@end

@implementation EPASlidingImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepContent {
    // Activity indicator
//    DDLogInfo(@"Adding spinny circle. On %@ thread.", [NSThread isMainThread] ? @"Main": @"Background");
//    UIActivityIndicatorView *spinnyCircle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    spinnyCircle.center = imageGallery.center;
//    [imageGallery addSubview:spinnyCircle];
//    [spinnyCircle startAnimating];
    
    float contentWidth = 0;
    

    _imageGallery.scrollsToTop = NO;
    _imageGallery.delegate = self;

    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)loadLandscapes {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@getLandscape", kServerURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        float contentWidth = 0;

        for (NSDictionary *lscape in responseObject) {
            EPALandscape *l = [[EPALandscape alloc] initWithDictionary:lscape];

            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(contentWidth, 0, 320, self.view.frame.size.height)];
            [image sd_setImageWithURL:[NSURL URLWithString:l.imageUrl] placeholderImage:[UIImage imageNamed:@"favicon.ico"]];
            [self.imageGallery addSubview:image];
            [self.photos addObject:image];
            contentWidth += 320;
        }

        _imageGallery.contentSize = CGSizeMake(contentWidth, self.view.frame.size.height);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadLandscapes];
    [self prepContent];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

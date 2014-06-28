//
//  EPASlidingImageViewController.m
//  EnPleinAir
//
//  Created by Sean Brady on 5/5/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPASlidingImageViewController.h"

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
    
    // Init the scroll view if it hasn't yet been initialized
    UIScrollView *imageGallery = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.imageGallery = imageGallery;
    imageGallery.pagingEnabled = YES;
    imageGallery.showsHorizontalScrollIndicator = NO;
    imageGallery.showsVerticalScrollIndicator = NO;
    imageGallery.scrollsToTop = NO;
    imageGallery.delegate = self;
    imageGallery.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:imageGallery];
    
    self.photos = [@[] mutableCopy];
    
    NSArray *pho = @[@"1", @"2"];
    
    
    for (NSString *photo in pho) {
        NSLog(@"photo: %@", photo);
        CGRect imgFrame = CGRectMake(contentWidth, 0, 320, self.view.frame.size.height);
        UIImageView *photoView = [[UIImageView alloc] initWithFrame:imgFrame];
        photoView.contentMode = UIViewContentModeScaleAspectFit;
        photoView.clipsToBounds = YES;
        photoView.backgroundColor = [UIColor clearColor]; // Allow spinny circle to show through
        [self.imageGallery addSubview:photoView];
        [self.photos addObject:photoView];
        photoView.image = [UIImage imageNamed:photo];
;
        photoView.frame = imgFrame;
        contentWidth += 320;
        NSLog(@"rect %f, %f, %f, %f", photoView.frame.origin.x, photoView.frame.origin.y, photoView.frame.size.width, photoView.frame.size.height);
    }
    
    self.imageGallery.contentSize = CGSizeMake(contentWidth, self.view.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepContent];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

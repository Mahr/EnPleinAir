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
#import "EPASlidingImageCell.h"
#import "SDWebImagePrefetcher.h"
#import "EPAUtilities.h"
#import "EPALandscapeInfoViewController.h"

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


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)prepContent {
    // Activity indicator
//    DDLogInfo(@"Adding spinny circle. On %@ thread.", [NSThread isMainThread] ? @"Main": @"Background");
//    UIActivityIndicatorView *spinnyCircle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    spinnyCircle.center = imageGallery.center;
//    [imageGallery addSubview:spinnyCircle];
//    [spinnyCircle startAnimating];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)loadLandscapes {
    NSDictionary *params = nil;
    if (_theme_id)
        params = @{@"theme_id":_theme_id};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@landscape", kServerURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *imagesToLoad = [@[] mutableCopy];

        for (NSDictionary *lscape in responseObject) {
            EPALandscape *l = [[EPALandscape alloc] initWithDictionary:lscape];

            if (!_landscapes)
                _landscapes = [@[] mutableCopy];

            [_landscapes addObject:l];
            [imagesToLoad addObject:[NSURL URLWithString:l.imageUrl]];

        }

        [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:imagesToLoad];
        [_imageCollectionView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_landscapes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPASlidingImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SlidingImageCell" forIndexPath:indexPath];

    EPALandscape *lscape = _landscapes[(NSUInteger)indexPath.row];

    NSString *optimizedURL = [EPAUtilities cloudinaryToJPG:lscape.imageUrl];
    optimizedURL = [EPAUtilities cloudinaryScaleImage:optimizedURL forFrame:cell.primaryImage.frame retina:YES];

    [cell.primaryImage sd_setImageWithURL:[NSURL URLWithString:optimizedURL] placeholderImage:nil];

    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LandscapeInfoSegue"]) {
        NSArray *selectedItems = [self.imageCollectionView indexPathsForSelectedItems];
        if (selectedItems) {
            NSIndexPath *indexPath = selectedItems[0];

            EPALandscapeInfoViewController *vc = segue.destinationViewController;
            EPALandscape *l = _landscapes[(NSUInteger)indexPath.row];
            vc.landscape = l;
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;

    [self loadLandscapes];
    [self prepContent];

//    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)hideNavBar {
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

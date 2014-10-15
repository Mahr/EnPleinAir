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


- (void)viewDidLoad
{
    [super viewDidLoad];

    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;

    [self prepContent];

//    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_selectedItem)
        [_imageCollectionView scrollToItemAtIndexPath:_selectedItem
                                     atScrollPosition:UICollectionViewScrollPositionNone
                                             animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)hideNavBar {
    self.navigationController.navigationBarHidden = YES;
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



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_landscapes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPASlidingImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SlidingImageCell" forIndexPath:indexPath];

    EPALandscape *lscape = _landscapes[(NSUInteger)indexPath.row];
    cell.landscape = lscape;

    [cell prepContent];


    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LandscapeInfoSegue"]) {
        NSArray *selectedItems = [self.imageCollectionView indexPathsForVisibleItems];
        if (selectedItems) {
            NSIndexPath *indexPath = selectedItems[0];

            EPALandscapeInfoViewController *vc = segue.destinationViewController;
            EPALandscape *l = _landscapes[(NSUInteger)indexPath.row];
            vc.landscape = l;
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

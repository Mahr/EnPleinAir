//
//  EPAThemeDetailViewController.m
//  EnPleinAir
//
//  Created by Sean Brady on 10/12/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPAThemeDetailViewController.h"
#import "EPAThemeHeaderView.h"
#import "EPATheme.h"
#import "UIImage+ImageEffects.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <SDWebImage/SDWebImagePrefetcher.h>
#import "EPAUtilities.h"
#import "constants.h"
#import "EPALandscape.h"
#import "EPAThemeCell.h"
#import "EPALandscapeCell.h"
#import "EPASlidingImageViewController.h"

@interface EPAThemeDetailViewController ()

@end

@implementation EPAThemeDetailViewController {
    NSMutableArray *_landscapes;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLandscapes];
    
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    

}


- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)loadLandscapes {
    NSDictionary *params = nil;
    params = @{@"theme_id":_theme.id};

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
        [_landscapeCollectionView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        EPAThemeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EPATitleHeaderView" forIndexPath:indexPath];

        if (_theme) {
            [headerView prepForTheme:_theme];
        }
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPALandscapeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EPALandscapeCellIdentifier" forIndexPath:indexPath];

    EPALandscape *l = _landscapes[(NSUInteger)indexPath.row];
    NSString *imageURL = [EPAUtilities cloudinaryScaleImage:l.imageUrl forFrame:cell.landscapeImage.frame retina:YES];
    [cell.landscapeImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil completed:nil];

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_landscapes)
        return _landscapes.count;
    else
        return 0;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [self performSegueWithIdentifier:@"ThemeDetailsToLandscapeSegue" sender:self];
}



//- (void)addBlurAndVibrancy {
//    // Blur effect
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    [blurEffectView setFrame:_themeImage.bounds];
//    [self.view addSubview:blurEffectView];
//    
//    // Vibrancy effect
//    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
//    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
//    [vibrancyEffectView setFrame:_themeImage.bounds];
//    
//    // Label for vibrant text
//    UILabel *vibrantLabel = [[UILabel alloc] init];
//    [vibrantLabel setText:@"Vibrant"];
//    [vibrantLabel setFont:[UIFont systemFontOfSize:72.0f]];
//    [vibrantLabel sizeToFit];
//    [vibrantLabel setCenter: self.view.center];
//    
//    // Add label to the vibrancy view
//    [[vibrancyEffectView contentView] addSubview:vibrantLabel];
//    
//    // Add the vibrancy view to the blur view
//    [[blurEffectView contentView] addSubview:vibrancyEffectView];
//}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ThemeDetailsToLandscapeSegue"]) {
        NSArray *selectedItems = [self.collectionView indexPathsForSelectedItems];
        if (selectedItems) {
            NSIndexPath *indexPath = selectedItems[0];

            EPASlidingImageViewController *vc = segue.destinationViewController;
            vc.selectedItem = indexPath;
            vc.landscapes = _landscapes;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  EPAThemeViewController.m
//  EnPleinAir
//
//  Created by Sean Brady on 8/16/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPAThemeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "constants.h"
#import "EPATheme.h"
#import "SDWebImagePrefetcher.h"
#import "EPAThemeCell.h"
#import "EPASlidingImageViewController.h"

@interface EPAThemeViewController ()

@end

@implementation EPAThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadThemes];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)loadThemes {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@theme", kServerURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {



//        NSMutableArray *imagesToLoad = [@[] mutableCopy];

        for (NSDictionary *thm in responseObject) {
            EPATheme *theme = [[EPATheme alloc] initWithDictionary:thm];

            if (!_themes)
                _themes = [@[] mutableCopy];

            [_themes addObject:theme];

//            cell.theme = theme;
//            [imagesToLoad addObject:[NSURL URLWithString:[cell optimizedImage]]];

        }

//        [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:imagesToLoad];
        [self.collectionView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPAThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EPAThemeCellIdentifier" forIndexPath:indexPath];

    cell.theme = _themes[(NSUInteger)indexPath.row];
    [cell prepContent];;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_themes)
        return _themes.count;
    else
        return 0;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EPATitleHeaderView" forIndexPath:indexPath];
        reusableview = headerView;
    }

    return reusableview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [self performSegueWithIdentifier:@"ThemeToLandscapeSegue" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ThemeToLandscapeSegue"]) {
        NSArray *selectedItems = [self.collectionView indexPathsForSelectedItems];
        if (selectedItems) {
            NSIndexPath *indexPath = selectedItems[0];
            
            EPASlidingImageViewController *vc = segue.destinationViewController;
            EPATheme *t = _themes[(NSUInteger)indexPath.row];
            vc.theme_id = t.id; 
        }
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

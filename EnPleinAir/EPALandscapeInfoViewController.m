//
//  EPALandscapeInfoViewController.m
//  EnPleinAir
//
//  Created by Sean Brady on 8/17/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <SDWebImage/SDWebImagePrefetcher.h>
#import "EPALandscapeInfoViewController.h"
#import "EPALandscape.h"
#import "constants.h"
#import "EPAPlant.h"
#import "EPAPlantTableViewCell.h"
#import "EPALandscapeDesignCell.h"
#import "EPAMoreInfoCell.h"

@interface EPALandscapeInfoViewController ()

@end

@implementation EPALandscapeInfoViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (_landscape)
        [self loadPlants];


    EPALandscapeDesignCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"EPALandscapeDesignCell"];
    self.landscapeHeight = cell.bounds.size.height;
    
    EPAMoreInfoCell * cell2 = [_tableView dequeueReusableCellWithIdentifier:@"EPAMoreInfoCell"];
    self.moreInfoHeight = cell2.bounds.size.height;
    
    EPAPlantTableViewCell * cell3 = [_tableView dequeueReusableCellWithIdentifier:@"EPAPlantTableViewCell"];
    self.plantHeight = cell3.bounds.size.height;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadPlants {
    NSDictionary *params = nil;
    if (_landscape)
        params = @{@"landscape_id":_landscape.id};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@plant", kServerURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *imagesToLoad = [@[] mutableCopy];

        self.plants = [@[] mutableCopy];

        for (NSDictionary *plant in responseObject) {
            EPAPlant *p = [[EPAPlant alloc] initWithDictionary:plant];



            [_plants addObject:p];
            [imagesToLoad addObject:[NSURL URLWithString:p.imageUrl]];

        }

        [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:imagesToLoad];
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark TABLE VIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int numSections = 0;

    if (_landscape) {
        numSections = 2;        //More information section and Landscape designer section

        if (_plants.count > 0)
            numSections++;
    }

    return numSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numRows = 0;

    if (_landscape) {
        if (section == 0 || section == 1)
            numRows = 1;
        else
            numRows = _plants.count;
    }

    return numRows;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *returnCell = nil;

    if (indexPath.section == 0)
        return _landscapeHeight;
    else if (indexPath.section == 1)
        return _moreInfoHeight;
    else
        return _plantHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *returnCell = nil;

    if (indexPath.section == 0)  {
        EPALandscapeDesignCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EPALandscapeDesignCell" forIndexPath:indexPath];
        cell.parentVC = self;
        cell.landscape = _landscape;
        [cell prepContent];
        returnCell = cell;
    }
    else if (indexPath.section == 1) {
        EPAMoreInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EPAMoreInfoCell" forIndexPath:indexPath];
        returnCell = cell;
    }
    else {
        EPAPlantTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EPAPlantTableViewCell" forIndexPath:indexPath];
        cell.parentVC = self;
        cell.plant = _plants[(NSUInteger)indexPath.row];
        [cell prepContent];

        returnCell = cell;
    }

    return returnCell;
}


////TODO: Need to update SlidingImageViewController so it also knows about Plants.
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"PlantToLandscapeSegue"]) {
//        NSIndexPath *indexPath = self.tableView indexPathForSelectedRow;
//
//        if (indexPath) {
//            EPASlidingImageViewController *vc = segue.destinationViewController;
//            EPATheme *t = _themes[(NSUInteger)indexPath.row];
//            vc.theme_id = t.id;
//        }
//    }
//}



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

//
//  EPASlidingImageCell.m
//  EnPleinAir
//
//  Created by Sean Brady on 7/20/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "EPASlidingImageCell.h"
#import "EPALandscape.h"
#import "EPAUtilities.h"
#import "AFHTTPRequestOperationManager.h"
#import "constants.h"
#import "SDWebImagePrefetcher.h"
#import "EPAPlant.h"
#import "EPAPlantTableViewCell.h"

@implementation EPASlidingImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (void)prepContent {
//    NSString *optimizedURL = [EPAUtilities cloudinaryToJPG:_landscape.imageUrl];
//    optimizedURL = [EPAUtilities cloudinaryScaleImage:optimizedURL forFrame:_primaryImage.frame retina:YES];

    [_primaryImage sd_setImageWithURL:[NSURL URLWithString:_landscape.imageUrl] placeholderImage:nil];
    NSLog(@"Load landscape image %@", _landscape.imageUrl);

    [self loadPlants];
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
//            [imagesToLoad addObject:[NSURL URLWithString:p.imageUrl]];

        }

//        [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:imagesToLoad];
        [_plantTableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark Plant Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _plants.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EPAPlantTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EPAPlantTableViewCell" forIndexPath:indexPath];
    cell.plant = _plants[(NSUInteger)indexPath.row];
    [cell prepContent];

    return cell;
}


- (void)prepareForReuse {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

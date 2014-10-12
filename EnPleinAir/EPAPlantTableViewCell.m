//
//  EPAPlantTableViewCell.m
//  EnPleinAir
//
//  Created by Sean Brady on 8/21/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "EPAPlantTableViewCell.h"
#import "EPAPlant.h"
#import "EPAUtilities.h"
#import "UIView+WebCacheOperation.h"
#import "BasicWebViewController.h"

@implementation EPAPlantTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)prepContent {
    _descriptionText.text = _plant.description;
    _nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", _plant.name, _plant.latinName];

//    NSString *optimizedURL = [EPAUtilities cloudinaryToJPG:_plant.imageUrl];
//    optimizedURL = [EPAUtilities cloudinaryScaleImage:optimizedURL forFrame:_plantImage.frame retina:YES];
    [_plantImage sd_setImageWithURL:[NSURL URLWithString:_plant.imageUrl] placeholderImage:nil];
}

- (IBAction)doPlantInfo:(id)sender {
    BasicWebViewController *bwvc = [[BasicWebViewController alloc] initWithURL:_plant.link];
    bwvc.title = _plant.name;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.parentVC.navigationController pushViewController:bwvc animated:YES];
    });
    
}


@end

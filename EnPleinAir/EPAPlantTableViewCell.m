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

    NSString *optimizedURL = [EPAUtilities cloudinaryToJPG:_plant.imageUrl];
    optimizedURL = [EPAUtilities cloudinaryScaleImage:optimizedURL forFrame:_plantImage.frame retina:YES];
    [_plantImage sd_setImageWithURL:[NSURL URLWithString:optimizedURL] placeholderImage:nil];
}

@end

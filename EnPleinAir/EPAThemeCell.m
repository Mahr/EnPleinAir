//
//  EPAThemeCell.m
//  EnPleinAir
//
//  Created by Sean Brady on 8/16/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "EPAThemeCell.h"
#import "EPATheme.h"
#import "EPAUtilities.h"
#import "UIImage+ImageEffects.h"

@implementation EPAThemeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepContent {
    _nameLabel.text = _theme.name;

    // Create a mask layer and the frame to determine what will be visible in the view.
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGPathRef path = CGPathCreateWithRect(_blurMask.frame, NULL);
    maskLayer.path = path;
    CGPathRelease(path);

    _blurredImage.layer.mask = maskLayer;

    [_image sd_setImageWithURL:[NSURL URLWithString:self.optimizedImage] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_blurredImage setImage:[image applyLightEffect]];
    }];
}


///Force to JPG and scale
- (NSString *)optimizedImage {
    NSString *url = [EPAUtilities cloudinaryToJPG:_theme.imageUrl];
    url = [EPAUtilities cloudinaryScaleImage:url forFrame:_image.frame retina:YES];
    return url;
}




- (void)prepareForReuse {
    [super prepareForReuse];
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

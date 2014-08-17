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
    [_image sd_setImageWithURL:[NSURL URLWithString:self.optimizedImage] placeholderImage:[UIImage imageNamed:@"favicon.ico"]];

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

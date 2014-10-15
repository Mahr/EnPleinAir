//
//  EPAThemeHeaderView.m
//  EnPleinAir
//
//  Created by Sean Brady on 10/12/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "EPAThemeHeaderView.h"
#import "EPATheme.h"

@implementation EPAThemeHeaderView

- (void)prepForTheme:(EPATheme *)theme {
    [_themeImage sd_setImageWithURL:[NSURL URLWithString:theme.imageUrl] placeholderImage:nil completed:nil];
    _nameLabe.text = theme.name;
    _descLabel.text = theme.desc;

    [_descLabel sizeToFit];
}


- (void)prepareForReuse {
    _themeImage = nil;
    _nameLabe.text = @"";
    _descLabel.text = @"";
}


@end

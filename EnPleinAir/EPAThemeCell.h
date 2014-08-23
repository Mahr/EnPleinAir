//
//  EPAThemeCell.h
//  EnPleinAir
//
//  Created by Sean Brady on 8/16/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPATheme;

@interface EPAThemeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blurredImage;
@property (weak, nonatomic) IBOutlet UIView *blurMask;

@property (strong, nonatomic) EPATheme *theme;

- (void)prepContent;

- (NSString *)optimizedImage;
@end

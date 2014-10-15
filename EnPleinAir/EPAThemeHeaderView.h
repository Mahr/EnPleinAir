//
//  EPAThemeHeaderView.h
//  EnPleinAir
//
//  Created by Sean Brady on 10/12/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPATheme;

@interface EPAThemeHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *themeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabe;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

- (void)prepForTheme:(EPATheme *)theme;
@end

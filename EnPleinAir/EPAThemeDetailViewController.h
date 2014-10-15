//
//  EPAThemeDetailViewController.h
//  EnPleinAir
//
//  Created by Sean Brady on 10/12/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EPATheme;

@interface EPAThemeDetailViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) EPATheme *theme;

@property (strong, nonatomic) IBOutlet UICollectionView *landscapeCollectionView;

@end

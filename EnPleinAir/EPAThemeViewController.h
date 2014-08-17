//
//  EPAThemeViewController.h
//  EnPleinAir
//
//  Created by Sean Brady on 8/16/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPAThemeViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

 @property (strong, nonatomic) NSMutableArray *themes;

@end

//
//  EPASlidingImageCell.h
//  EnPleinAir
//
//  Created by Sean Brady on 7/20/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPALandscape;

@interface EPASlidingImageCell : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *primaryImage;
@property (weak, nonatomic) IBOutlet UITableView *plantTableView;

@property (strong, nonatomic) IBOutlet EPALandscape *landscape;

@property(nonatomic, strong) NSMutableArray *plants;

- (void)prepContent;
@end

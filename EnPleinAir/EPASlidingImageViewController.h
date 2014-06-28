//
//  EPASlidingImageViewController.h
//  EnPleinAir
//
//  Created by Sean Brady on 5/5/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPASlidingImageViewController : UIViewController <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIScrollView *imageGallery;

@property(nonatomic, strong) NSMutableArray *photos;

@end

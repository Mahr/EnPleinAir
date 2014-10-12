//
// Created by Sean Brady on 7/20/14.
// Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPALandscape : NSObject

@property (nonatomic, strong) NSString *dateAdded;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *designer;
@property (nonatomic, strong) NSString *designerWebsite;


- (id)initWithDictionary:(NSDictionary *)jsonData;

@end
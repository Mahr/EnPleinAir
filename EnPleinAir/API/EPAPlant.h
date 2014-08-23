//
//  EPAPlant.h
//  EnPleinAir
//
//  Created by Sean Brady on 8/21/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPAPlant : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *latinName;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *description;

- (id)initWithDictionary:(NSDictionary *)jsonData;
@end

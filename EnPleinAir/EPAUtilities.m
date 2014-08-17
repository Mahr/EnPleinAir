//
// Created by Sean Brady on 8/17/14.
// Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPAUtilities.h"


@implementation EPAUtilities {

}


+ (NSString *)cloudinaryScaleImage:(NSString *)imageStr forFrame:(CGRect)rect retina:(BOOL)retina {
    NSString *returnStr = imageStr;
    int scale = 1;

    if (retina)
        scale = 2;

    if ([imageStr rangeOfString:@"cloudinary"].location) {
        if ([imageStr rangeOfString:@"/upload/w_"].location == NSNotFound) {
            //Cloudinary-optimized image
            NSString *replace = [NSString stringWithFormat:@"/upload/w_%d,h_%d,c_fill,q_%d", (int) rect.size.width*scale, (int) rect.size.height*scale, 60];
            returnStr = [imageStr stringByReplacingOccurrencesOfString:@"/upload" withString:replace];
        }
    }

    return returnStr;
}


+ (NSString *)cloudinaryToJPG:(NSString *)imageStr {
    NSString *returnStr = imageStr;

    if ([imageStr rangeOfString:@"cloudinary"].location) {
        if ([[imageStr pathExtension] isEqualToString:@"png"])
            returnStr = [imageStr stringByReplacingOccurrencesOfString:@".png" withString:@".jpg"];
    }

    return returnStr;
}

@end
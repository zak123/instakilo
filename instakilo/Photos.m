//
//  Photos.m
//  instakilo
//
//  Created by Zachary Mallicoat on 3/26/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import "Photos.h"

@implementation Photos

- (instancetype)initWithImagePath:(NSString *)imagePath Subject:(NSString *)subject
{
    self = [super init];
    if (self) {
        _imagePath = imagePath;
        _subject = subject;
        
    }
    return self;
}

-(UIImage*) returnImage {
    if (_imageData != nil) {
        return _imageData;
        
    } else {
        
        UIImage *image = [UIImage imageNamed:_imagePath];
        return image;
    }
}





@end

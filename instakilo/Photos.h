//
//  Photos.h
//  instakilo
//
//  Created by Zachary Mallicoat on 3/26/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photos : NSObject

@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) UIImage *imageData;



-(instancetype)initWithImagePath:(NSString*)imagePath Subject:(NSString*)subject;
-(UIImage*) returnImage;

@end

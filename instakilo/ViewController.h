//
//  ViewController.h
//  instakilo
//
//  Created by Zachary Mallicoat on 3/26/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photos.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSMutableArray *imagesMutableArray;
@property (nonatomic, strong) NSString *imageString;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteButton;



@end


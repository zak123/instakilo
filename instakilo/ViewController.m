//
//  ViewController.m
//  instakilo
//
//  Created by Zachary Mallicoat on 3/26/15.
//  Copyright (c) 2015 cghcapital. All rights reserved.
//

//CREATE PHOTO CLASS THAT ACCEPTS BOTH IMAGES AND STRINGS AND THEN ADD PHOTO OBJECTS TO ARRAY RATHER THAN JUST STRINGS

#import "ViewController.h"
#import "ImagesCollectionViewCell.h"
#import "Photos.h"
#import "UIImage+ImageEffects.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSArray *imagesArray;
    UICollectionViewFlowLayout *bigLayout;
    UICollectionViewFlowLayout *smallLayout;
    UIImage *imageBlur;
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imagesMutableArray = [[NSMutableArray alloc] init];
    
    Photos *photo = [[Photos alloc] initWithImagePath:@"IMG_001.jpg" Subject:@"Music"];
    
    [_imagesMutableArray addObject:photo];
    
    photo = [[Photos alloc] initWithImagePath:@"IMG_002.jpg" Subject:@"Music"];
    
    [_imagesMutableArray addObject:photo];
    
    photo = [[Photos alloc] initWithImagePath:@"IMG_003.jpg" Subject:@"Music"];
    
    [_imagesMutableArray addObject:photo];
    
    
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doPinch:)];
    
    [self.collectionView addGestureRecognizer:pinchGesture];
    
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doDoubleTap)];
//    doubleTap.numberOfTapsRequired = 2;

    //[self.collectionView addGestureRecognizer:singleTap];
//    [self.collectionView addGestureRecognizer:doubleTap];
    // Do any additional setup after loading the view, typically from a nib.
    //bigLayout = [[UICollectionViewFlowLayout alloc] init];
    
    bigLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    //bigLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //bigLayout.minimumInteritemSpacing = 10.0f;
    //bigLayout.minimumLineSpacing = 10.0f;
    
    [self.collectionView setCollectionViewLayout:bigLayout];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.view layoutIfNeeded];
    
    bigLayout.itemSize = CGRectInset(self.collectionView.bounds, 0, 10).size;
    //NSLog(@"item size is %@", NSStringFromCGSize(bigLayout.itemSize));
    //[self.collectionView setNeedsLayout];
    
}


- (IBAction)addImage:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;

    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    Photos *photo = [[Photos alloc] initWithImagePath:nil Subject:nil];
    photo.subject = @"Added";
    photo.imagePath = nil;
    photo.imageData = image;
    
    
    
    
    [_imagesMutableArray addObject:photo];
    [self.collectionView reloadData];
    
    
    imageBlur = [image applyLightEffect];
    
    
    //resize image to view bounds
    
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:imageBlur];
    

    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_imagesMutableArray count];
}


-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    Photos *photo = [self.imagesMutableArray objectAtIndex:indexPath.row];
    
    
    
    UIImage *tempImage = [photo returnImage];
    
    ImagesCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    
    [cell.phoneImageView setImage:tempImage];
    if (bigLayout) {
        [self setTitle:photo.subject];

    }
    
    
    return cell;
}

-(void) doPinch:(UIPinchGestureRecognizer *)pinch {
    
    
    if (pinch.state != UIGestureRecognizerStateEnded) {
        return;
    }
        
        
    if (!smallLayout) {
        smallLayout = [[UICollectionViewFlowLayout alloc] init];
        
        smallLayout.itemSize = CGSizeMake(100, 100);
        smallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        smallLayout.minimumInteritemSpacing = 10.0f;
        smallLayout.minimumLineSpacing = 10.0f;
        smallLayout.headerReferenceSize = CGSizeZero;
        
    }
    
    
    
    if (self.collectionView.collectionViewLayout != smallLayout) {
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationItem.leftBarButtonItem = nil;
            self.collectionView.backgroundColor = [UIColor colorWithPatternImage:imageBlur];
            [self.collectionView setCollectionViewLayout:smallLayout];
            [self setTitle:@"All Pictures"];
            [self.collectionView layoutIfNeeded];
        }];
    }
    

    

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        [UIView animateWithDuration:0.0 animations:^{
            if (self.collectionView.collectionViewLayout == smallLayout) {
                self.navigationItem.leftBarButtonItem = _deleteButton;
                [self setTitle:@"Music"];
                self.collectionView.backgroundColor = [UIColor blackColor];
                self.collectionView.collectionViewLayout = bigLayout;
            } else {
                return;
            }
        }];
    }
- (IBAction)deleteButton:(id)sender {
    {
        
        
        //get current selected image
        
        NSArray *selectedItem = [self.collectionView indexPathsForVisibleItems];
        
        NSIndexPath *indexPath = (NSIndexPath*) selectedItem.firstObject;
        
        UIAlertView *noImageAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"No image to remove" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        
        if (indexPath == nil) {
            [noImageAlert show];
        }
        else {
            [_imagesMutableArray removeObjectAtIndex:indexPath.item];
            UIAlertView *removeAlert = [[UIAlertView alloc]initWithTitle:@"Removed" message:@"Image Removed" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            
            
            
            [self.collectionView reloadData];
            [removeAlert show];
        }
        
        
    }
}

@end

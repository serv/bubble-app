//
//  CEPhotoViewController2.h
//  Bubble
//
//  Created by Julius Magsino on 6/1/14.
//  Copyright (c) 2014 Code Eevee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CEPhotoViewController2 : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property BOOL newMedia;
- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;



@end

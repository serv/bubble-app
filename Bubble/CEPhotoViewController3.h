//
//  CEPhotoViewController3.h
//  Bubble
//
//  Created by Julius Magsino on 6/2/14.
//  Copyright (c) 2014 Code Eevee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>



@interface CEPhotoViewController3 : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property BOOL newMedia;

@property (weak, nonatomic) IBOutlet UITableView *tblFiles;



- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;

@end

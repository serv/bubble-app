//
//  CEPhotoViewController.m
//  Bubble
//
//  Created by Julius Magsino on 5/19/14.
//  Copyright (c) 2014 Code Eevee. All rights reserved.
//

#import "CEPhotoViewController.h"
#import "CEViewController.h"
#import "CEAppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CEPhotoViewController ()<MCBrowserViewControllerDelegate, MCSessionDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) CEAppDelegate *appDelegate;
@property (nonatomic, strong) UIButton *peerConnect;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *imageSelect;

@property (nonatomic, strong) MCBrowserViewController *browserVC;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (nonatomic, strong) MCSession *mySession;
@property (nonatomic, strong) MCPeerID *myPeerID;



-(void)sendMyMessage;
-(void)didReceiveDataWithNotification:(NSNotification *)notification;


///ADDED THIS IN FOR TEST 6/1
-(void)peerDidChangesStateWithNotification:(NSNotification *)notification;


@end

@implementation CEPhotoViewController


//
//- (IBAction)ChooseImage {
//    //    CEViewController *second = [[CEViewController alloc] initWithNibName:nil bundle:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


- (void) setUpInterface{
//    // Setup the connect button
//    self.peerConnect = [UIButton
//                        buttonWithType:UIButtonTypeSystem];
//    [self.peerConnect setTitle:@"Connect"
//                      forState:UIControlStateNormal];
//    self.peerConnect.frame = CGRectMake(120, 20, 60, 30);
//    [self.view addSubview:self.peerConnect];
//    
    // Setup the imageSelect button
    self.imageSelect = [UIButton
                        buttonWithType:UIButtonTypeSystem];
    [self.imageSelect setTitle:@"Share Photo"
                      forState:UIControlStateNormal];
    self.imageSelect.frame = CGRectMake(100, 500, 120, 30);
    [self.view addSubview:self.imageSelect];
    
    [self.peerConnect addTarget:self
                         action:@selector(showBrowserViewController)
               forControlEvents:UIControlEventTouchUpInside];
    [self.imageSelect addTarget:self
                         action:@selector(selectImage)
               forControlEvents:UIControlEventTouchUpInside];
    
    // Setup imageView
    self.imageView = [[UIImageView alloc] initWithFrame: 
                      CGRectMake(0, 100, 320, 320)];
    self.imageView.backgroundColor = [UIColor 
                                      lightGrayColor]; 
    [self.view addSubview:self.imageView]; 
}







- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)Next {
    //    CEViewController *second = [[CEViewController alloc] initWithNibName:nil bundle:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpInterface];
//    [self setUpMultipeer];
    
    
        _appDelegate = (CEAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/////////////////////////////////////////////////////////////////////


#pragma marks MCSessionDelegate

- (void)session:(MCSession *)session peer:(MCPeerID
                                           *)peerID didChangeState:(MCSessionState)state{
}

- (void)session:(MCSession *)session didReceiveData:(NSData
                                                     *)data fromPeer:(MCPeerID *)peerID{
}

- (void)session:(MCSession *)session
didReceiveStream:(NSInputStream *)stream withName:(NSString
                                                   *)streamName fromPeer:(MCPeerID *)peerID{
}

- (void)session:(MCSession *)session
didStartReceivingResourceWithName:(NSString *)resourceName
       fromPeer:(MCPeerID *)peerID withProgress:(NSProgress
                                                 *)progress{
    NSLog(@"downloading file: %f%%",
          progress.fractionCompleted); 
}


//This	next	method	is	where	a	lot	of	the	work	is	done	for	receiving	the	image	file.

- (void)session:(MCSession *)session
didFinishReceivingResourceWithName:(NSString *)resourceName
       fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL
      withError:(NSError *)error {
    NSLog(@"Finished receiving file...");
    if (error) {
        NSLog(@"Error when receiving file! %@", error);
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *imageData = nil;
            @autoreleasepool {
                UIImage *image = [UIImage
                                  imageWithContentsOfFile:localURL.path];
                imageData =
                UIImageJPEGRepresentation(image, 1.0f);
            }
            NSString *fileName = [[NSUUID UUID]
                                  UUIDString];
            NSString *filePath = [NSString
                                  stringWithFormat:@"%@/%@.jpg", NSTemporaryDirectory(),
                                  fileName];
            NSURL *imageURL = [NSURL
                               fileURLWithPath:filePath];
            NSFileManager *fileman = [NSFileManager 
                                      defaultManager]; 
            [fileman createFileAtPath:imageURL.path 
                             contents:imageData attributes:nil]; 
            NSData *data = [NSData dataWithContentsOfURL: 
                            imageURL]; 
            UIImage *image = [[UIImage alloc] 
                              initWithData:data]; 
            _imageView.image = image; 
        }); 
    } 
}	

//
//- (IBAction)selectImage{
//    if ([UIImagePickerController isSourceTypeAvailable:
//         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
//    {
//        UIImagePickerController *imagePicker =
//        [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
//        imagePicker.allowsEditing = NO;
//        [self presentViewController:imagePicker 
//                           animated:YES completion:nil]; 
//    } 
//}


- (void)selectImage{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
    }
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES
                             completion:nil]; 
}


-(void)sendImage:(UIImage*)image with:(NSDictionary*)info{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *imageToSave = (UIImage *)[info
                                           objectForKey:UIImagePickerControllerOriginalImage];
        // Save the copied image to the documents directory
        NSData *pngData =
        UIImageJPEGRepresentation(imageToSave, 1.0);
        // Create a unique file name
        NSDateFormatter *inFormat = [NSDateFormatter new];
        [inFormat setDateFormat:@"yyMMdd-HHmmss"];  NSString *imageName = [NSString
                                                                           stringWithFormat:@"image-%@.JPG", [inFormat
                                                                                                              stringFromDate:[NSDate date]]];
        // Create a file path to our documents directory
        NSArray *paths =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0]
                              stringByAppendingPathComponent:imageName];
        [pngData writeToFile:filePath atomically:YES];
        NSURL *imageUrl = [NSURL fileURLWithPath:filePath];
        MCPeerID *peer = self.mySession.connectedPeers[0];
        [self.mySession sendResourceAtURL:imageUrl
                                 withName:imageName toPeer:peer
                    withCompletionHandler:^(NSError *error) { 
                        if (error) { 
                            NSLog(@"Failed to send picture to %@, %@", 
                                  peer.displayName, error.localizedDescription); 
                            return; 
                        } 
                        NSLog(@"Sent picture to %@", peer.displayName); 
                        //Clean up the temp file 
                        NSFileManager *fileManager = [NSFileManager 
                                                      defaultManager]; 
                        [fileManager removeItemAtURL:imageUrl 
                                               error:nil]; 
                    }]; 
    }); 
}

@end

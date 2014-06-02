//
//  CEViewController.h
//  Bubble
//
//  Created by Julius Magsino on 5/4/14.
//  Copyright (c) 2014 Code Eevee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface CEViewController : UIViewController <MCBrowserViewControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UISwitch *swVisible;
@property (weak, nonatomic) IBOutlet UITableView *tblConnectedDevices;
@property (weak, nonatomic) IBOutlet UIButton *btnDisconnect;

///GOING TO COMMENT THESE OUT BECAUSE THEY DONT REALLY NEED TO BE HERE

//- (IBAction)browseForDevices:(id)sender;
//- (IBAction)toggleVisibility:(id)sender;
//- (IBAction)disconnect:(id)sender;

- (IBAction)Next;
- (IBAction)Next2;

@end

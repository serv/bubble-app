//
//  CEChatViewController.h
//  Bubble
//
//  Created by Julius Magsino on 5/4/14.
//  Copyright (c) 2014 Code Eevee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CEChatViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tvChat;
@property (weak, nonatomic) IBOutlet UITextField *txtChat;

- (IBAction)Next;
- (IBAction)sendMessage:(id)sender;
- (IBAction)cancelMessage:(id)sender;

@end

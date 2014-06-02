//
//  CEChatViewController.m
//  Bubble
//
//  Created by Julius Magsino on 5/4/14.
//  Copyright (c) 2014 Code Eevee. All rights reserved.
//

#import "CEChatViewController.h"
#import "CEViewController.h"
#import "CEAppDelegate.h"

@interface CEChatViewController ()

@property (nonatomic, strong) CEAppDelegate *appDelegate;

-(void)sendMyMessage;
-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@end

@implementation CEChatViewController

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

////THIS IS TO HAVE THE KEYBOARD OPEN WHEN OPENING UP CHAT
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.txtChat performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _appDelegate = (CEAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _txtChat.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendMyMessage];
    return YES;
}

#pragma mark - IBAction method implementation

- (IBAction)sendMessage:(id)sender {
    [self sendMyMessage];
}

#pragma mark - Private method implementation

-(void)sendMyMessage{
    NSData *dataToSend = [_txtChat.text dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [_appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [_tvChat setText:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"I wrote:\n%@\n\n", _txtChat.text]]];
    [_txtChat setText:@""];
    [_txtChat resignFirstResponder];
    
    ////TO KEEP THE KEYBOARD UP EVEN AFTER PRESSING THE SEND BUTTON (WILL FIX)
    [self.txtChat performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    [_tvChat performSelectorOnMainThread:@selector(setText:) withObject:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"%@ wrote:\n%@\n\n", peerDisplayName, receivedText]] waitUntilDone:NO];
}

@end

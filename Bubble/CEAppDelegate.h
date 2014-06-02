//
//  CEAppDelegate.h
//  Bubble
//
//  Created by Julius Magsino on 5/4/14.
//  Copyright (c) 2014 Code Eevee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEMCManager.h"

@interface CEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CEMCManager *mcManager;

@end

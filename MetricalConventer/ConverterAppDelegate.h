//
//  ConventerAppDelegate.h
//  Conventer
//
//  Created by Sergey Klimov on 06.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConventerViewController;

@interface ConventerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ConventerViewController *viewController;

@end

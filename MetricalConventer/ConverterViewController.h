//
//  ConventerViewController.h
//  MetricalConventer
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conventer.h"

@interface ConventerViewController : UIViewController
{
    Conventer * conventer;
    IBOutlet UILabel* unit;
}

-(IBAction)unitChanged:(id)sender;
-(IBAction)valueChanged:(UITextField *)sender;


@end

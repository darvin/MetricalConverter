//
//  ConverterViewController.h
//  MetricalConverter
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Converter.h"
#import "UnitSelectViewController.h"



@interface ConverterViewController : UIViewController <UnitSelectViewControllerDelegate, UISplitViewControllerDelegate, UITextInputDelegate>
{
    Converter * converter;
    IBOutlet UIButton* unitButton;
    IBOutlet UITextView* resultView;
    IBOutlet UITextField* valueEdit;
    UIViewController * unitSelectViewController;
    
}

-(IBAction)unitChange:(id)sender;
-(IBAction)valueChanged:(UITextField *)sender;
@property (retain) UIViewController * unitSelectViewController;


@end

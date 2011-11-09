//
//  ConverterViewController.h
//  MetricalConverter
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Converter.h"
@class UnitSelectViewController;


@protocol ConverterViewControllerDelegate <NSObject>
@property (readonly) NSArray* availableUnits;
@property (copy) NSString* currentUnit;
@end

@interface ConverterViewController : UIViewController <ConverterViewControllerDelegate>
{
    Converter * converter;
    IBOutlet UIButton* unitButton;
    IBOutlet UITextView* resultView;
    UnitSelectViewController * unitSelectViewController;
}

-(IBAction)unitChange:(id)sender;
-(IBAction)valueChanged:(UITextField *)sender;
@property (readonly) NSArray* availableUnits;
@property (copy) NSString* currentUnit;

@end

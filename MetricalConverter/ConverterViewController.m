//
//  ConverterViewController.m
//  Converter
//
//  Created by Sergey Klimov on 06.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConverterViewController.h"
#import "UnitSelectViewController.h"
@class UnitSelectViewController;


@implementation ConverterViewController

- (void)refreshResult
{
    NSLog(@"%@", [converter getConvertered]);
    resultView.text = [[converter getConvertered] description];
    [unitButton  setTitle:converter.unit forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
-(Converter *) converter
{
    if (!converter) {
        converter = [[Converter alloc] init];
    }
    return converter;
}

-(UnitSelectViewController *) unitSelectViewController
{
    if (!unitSelectViewController) {
        unitSelectViewController = [[UnitSelectViewController alloc] init];
        unitSelectViewController.converterViewControllerDelegate = self;
    }
    return unitSelectViewController;
}


-(IBAction)valueChanged:(UITextField *)sender
{
    NSString* newValue = [sender text];
    NSLog(@"%@", newValue);
    [converter setOperand:[newValue doubleValue]];
    [self refreshResult];
}
-(IBAction)unitChange:(id)sender
{
    [self.navigationController pushViewController:self.unitSelectViewController animated:YES];
    
}

-(NSArray*) availableUnits
{
    return self.converter.availableUnits;
}

-(NSString*) currentUnit
{
    return self.converter.unit;
}


-(void) setCurrentUnit:(NSString*) newUnit
{
    self.converter.unit = newUnit;
    [self refreshResult];
}

-(void) dealloc
{
    [unitSelectViewController release];
    [super dealloc];
}

@end

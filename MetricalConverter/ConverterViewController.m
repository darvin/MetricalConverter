//
//  ConverterViewController.m
//  Converter
//
//  Created by Sergey Klimov on 06.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConverterViewController.h"
@interface ConverterViewController()
@property (readonly, retain) Converter * converter;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation ConverterViewController
@synthesize unitSelectViewController;
@synthesize masterPopoverController = _masterPopoverController;

- (void)refreshResult
{
    NSLog(@"%@", [self.converter getConvertered]);
    resultView.text = [[self.converter getConvertered] description];
    [unitButton  setTitle:self.converter.unit forState:UIControlStateNormal];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self refreshResult];
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



- (void) viewWillDisappear:(BOOL)animated
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Convert", @"Convert");
        self.converter.unit = [self.converter.availableUnits objectAtIndex:0];
        self.converter.operand = 1;
    }
    return self;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(Converter *) converter
{
    if (!converter) {
        converter = [[Converter alloc] init];
    }
    return converter;
}


-(IBAction)valueChanged:(UITextField *)sender
{
    NSString* newValue = [sender text];
    NSLog(@"%@", newValue);
    self.converter.operand = [newValue doubleValue];
    [self refreshResult];
}
-(IBAction)unitChange:(id)sender
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController pushViewController:self.unitSelectViewController animated:YES];
    }
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
    [converter release];
    [_masterPopoverController release];
    
    [super dealloc];
}


#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Units", @"Units");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string { 
    NSMutableCharacterSet* numbersAndPoint = [NSMutableCharacterSet decimalDigitCharacterSet];
    [numbersAndPoint formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    
    NSCharacterSet *nonNumberSet = [numbersAndPoint invertedSet];

    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



@end

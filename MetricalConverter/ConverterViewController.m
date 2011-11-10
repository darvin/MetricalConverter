//
//  ConverterViewController.m
//  Converter
//
//  Created by Sergey Klimov on 06.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConverterViewController.h"
@interface ConverterViewController()
@property (retain) Converter * converter;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)refreshResult;
@end

@implementation ConverterViewController
@synthesize unitSelectViewController, converter;
@synthesize masterPopoverController = _masterPopoverController;

- (void)refreshResult
{
    NSLog(@"%@", [self.converter getConvertered]);
    if (self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem.title = self.converter.unit;
    }
    NSLog(@"%@ %@", self.tableView.delegate, self.tableView.dataSource);
    [self.tableView reloadData];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Units" style:UIBarButtonItemStylePlain target:self action:@selector(unitChange:)] autorelease]  ; 

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.unitSelectViewController = nil;
    self.converter = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self refreshResult];
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



- (void) viewWillDisappear:(BOOL)animated
{
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
        self.converter = [[Converter alloc] init];
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



-(void) dealloc
{
    [unitSelectViewController release];
    [converter release];
    [_masterPopoverController release];
    [super dealloc];
}

#pragma mark - Unit select view 

- (NSArray*)unitSelectViewControllerAvailableUnits:(UnitSelectViewController *)unitSelectViewController
{
    return self.converter.availableUnits;
}
- (NSString*)unitSelectViewControllerCurrentUnit:(UnitSelectViewController *)unitSelectViewController
{
    return self.converter.unit;
}
- (void)unitSelectViewController:(UnitSelectViewController *)unitSelectViewController willSetCurrentUnit:(NSString*) newCurrentUnit
{
    self.converter.unit = newCurrentUnit;
    [self refreshResult];
}



#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    [self.navigationItem setRightBarButtonItem:barButtonItem animated:YES];
    if (!barButtonItem.title)
        [self refreshResult];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - Text field

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string { 
    if ([string length] == 0) 
        return YES; 
    
    NSMutableCharacterSet* numbersAndPoint = [NSMutableCharacterSet decimalDigitCharacterSet];
    [numbersAndPoint formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSCharacterSet *nonNumberSet = [numbersAndPoint invertedSet];

    
    string = [[string componentsSeparatedByCharactersInSet:nonNumberSet] componentsJoinedByString:@""]; 
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string]; 

    return NO; 

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)selectionWillChange:(id <UITextInput>)textInput{};
- (void)selectionDidChange:(id <UITextInput>)textInput{};
- (void)textWillChange:(id <UITextInput>)textInput{};
- (void)textDidChange:(id <UITextInput>)textInput{};

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 1;
    else {
        return [[self.converter getConvertered] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ValueCellIdentifier = @"ValueCell";
    static NSString *ResultCellIdentifier = @"ResultCell";
    UITableViewCell * cell;
    if ([indexPath section] == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier: ValueCellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:ValueCellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            UITextField *valueTextField = [[UITextField alloc] initWithFrame:CGRectMake(125, 10, 185, 30)];
            valueTextField.adjustsFontSizeToFitWidth = YES;
            valueTextField.textColor = [UIColor blackColor];
            valueTextField.placeholder = @"value here";
            valueTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            valueTextField.returnKeyType = UIReturnKeyDone;
            valueTextField.delegate = self;
            [valueTextField setEnabled: YES];
            [valueTextField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingDidEnd];
            cell.textLabel.text = @"Enter value:";
            [cell.contentView addSubview:valueTextField];
            

            
            [valueTextField release];
        
        }
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier: ResultCellIdentifier];
        if (cell ==nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 
                                           reuseIdentifier:ResultCellIdentifier] autorelease];
        }
        NSDictionary* result = [self.converter getConvertered];
        NSArray* resultKeys = [result allKeys];
        NSString* cellUnit = [resultKeys objectAtIndex:indexPath.row];
        NSNumber* cellValue = [result objectForKey:cellUnit];
        NSLog(@"%@ - %@", cellUnit, cellValue);
        cell.textLabel.text = cellUnit;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        cell.detailTextLabel.text = [formatter stringFromNumber:cellValue];
        [formatter release];
    }
    return cell;    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


@end

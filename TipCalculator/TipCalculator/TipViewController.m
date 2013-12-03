//
//  TipViewController.m
//  TipCalculator
//
//  Created by Ruchi Varshney on 12/2/13.
//  Copyright (c) 2013 Ruchi Varshney. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property NSUInteger defaultTipIndex;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

static NSArray *tipValues;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tipValues = @[@(0.1), @(0.15), @(0.20)];
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onTap:(id)sender
{
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues
{
    float billAmount = [self.billTextField.text floatValue];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton
{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger index = [tipValues indexOfObject:[defaults objectForKey:@"defaultTip"]];
    self.defaultTipIndex = (index == NSNotFound) ? 0 : index;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tipControl setSelectedSegmentIndex:self.defaultTipIndex];
    [self updateValues];
}
@end

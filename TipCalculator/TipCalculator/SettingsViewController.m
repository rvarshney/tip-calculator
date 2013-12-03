//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Ruchi Varshney on 12/2/13.
//  Copyright (c) 2013 Ruchi Varshney. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property NSUInteger selectedIndex;
@end

@implementation SettingsViewController

static NSArray *tipValues;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        tipValues = @[@(0.1), @(0.15), @(0.20)];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger index = [tipValues indexOfObject:[defaults objectForKey:@"defaultTip"]];
        self.selectedIndex = (index == NSNotFound) ? 0 : index;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tipValues count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Default Tip";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%0.0f%%", [tipValues[indexPath.row] floatValue] * 100];
    cell.accessoryType = (self.selectedIndex == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tipValues[indexPath.row] forKey:@"defaultTip"];
    [defaults synchronize];
    
    [tableView reloadData];
}
@end

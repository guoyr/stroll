//
//  LLSettingsViewController.m
//  wellmark
//
//  Created by Robert Guo on 9/10/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLSettingsViewController.h"

@interface LLSettingsViewController ()

@property (nonatomic, assign) int curY;

@end

@implementation LLSettingsViewController
{
    NSArray *tableData;
}
@synthesize doctorSB;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _curY = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[_einLabel layer] setCornerRadius:5];
    [[_idLabel layer] setCornerRadius:5];
    [[_einField layer] setCornerRadius:5];
    [[_idField layer] setCornerRadius:5];
    [[_doctorLabel layer] setCornerRadius:5];
    
    [_doctorScrollView setScrollEnabled:YES];
    [_doctorScrollView setContentSize:_doctorScrollView.frame.size];
	// Do any additional setup after loading the view.
    doctorSB = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"Doctors"]];
    //[doctorSB addObject:@""];
    //for (NSString *doctor in doctorSB) { changed
    for(int i = 0;i<[doctorSB count];i++){
        NSString *doctor = [doctorSB objectAtIndex:i];
        UITextField *label = [[UITextField alloc] initWithFrame:CGRectMake(0, _curY, 320, 48)];
        [label setBackgroundColor:[UIColor lightTextColor]];
        [label setAlpha:0.8];
        [[label layer] setCornerRadius:5.0];
        [label setFont:[UIFont systemFontOfSize:18]];
        [label setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        _curY += 58;
        [label setText:doctor];
        [_doctorScrollView addSubview:label];
        
        

    }

}

-(void)newDoctor{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonok:(id)sender {
    NSString *newdoctor = self.textfield.text;
    if ([newdoctor length] !=0) {
        [doctorSB addObject:newdoctor];
        [[NSUserDefaults standardUserDefaults] setObject:doctorSB forKey:@"Doctorsb"];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textfield) {
        [theTextField resignFirstResponder];
    }
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [doctorSB count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [doctorSB objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"doctor.png"];
    return cell;
}
@end

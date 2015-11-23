//
//  AddPersonController.h
//  coredata
//
//  Created by Admin on 11/18/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPersonController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *country;
- (IBAction)handleDone:(UIBarButtonItem *)sender;

@end

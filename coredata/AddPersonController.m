//
//  AddPersonController.m
//  coredata
//
//  Created by Admin on 11/18/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "AddPersonController.h"
#import "Person+CoreDataProperties.h"
#import "Phone+CoreDataProperties.h"
#import "NSManagedObjectContext+MainContext.h"
#import "NSManagedObject+ActiveDirectory.h"
#import "CountryListController.h"

@interface AddPersonController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) Country *country;
- (IBAction)handleDone:(UIBarButtonItem *)sender;
@end

@implementation AddPersonController

- (void)handleDone:(UIBarButtonItem *)sender {
    // Create Entity
    Person *newPerson = [Person createEntity];
    
    newPerson.name = self.firstName.text;
    newPerson.lastName = self.lastName.text;
    newPerson.birthday = self.birthday.text;
    newPerson.country = self.country;
    
    Phone *newPhone = [Phone createEntity];
    newPhone.number = self.phone.text;
    
    [newPerson addTelephonesObject:newPhone];
    
    [newPerson.managedObjectContext saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[CountryListController class]]) {
        CountryListController *controller = segue.destinationViewController;
        UITableViewCell *cell = sender;
        controller.onSelect = ^(Country *country) {
            self.country = country;
            cell.detailTextLabel.text = country.name;
        };
    }
}

@end

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

@interface AddPersonController ()

@end

@implementation AddPersonController

- (void)handleDone:(UIBarButtonItem *)sender {
    // Create Entity
    Person *newPerson = [Person createEntity];
    
    newPerson.name = self.firstName.text;
    newPerson.lastName = self.lastName.text;
    newPerson.birthday = self.birthday.text;
    newPerson.country = self.country.text;
    
    Phone *newPhone = [Phone createEntity];
    newPhone.number = self.phone.text;
    
    [newPerson addTelephonesObject:newPhone];
    
    [newPerson.managedObjectContext saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

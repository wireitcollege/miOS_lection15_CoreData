//
//  Person+CoreDataProperties.m
//  coredata
//
//  Created by Admin on 11/23/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

@dynamic birthday;
@dynamic email;
@dynamic lastName;
@dynamic name;
@dynamic telephones;
@dynamic country;

- (NSString *)countryName {
    return self.country.name;
}

@end

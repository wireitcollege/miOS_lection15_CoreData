//
//  PersonMigrationPolicy.m
//  coredata
//
//  Created by Admin on 11/23/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "PersonMigrationPolicy.h"
#import "Person+CoreDataProperties.h"

@implementation PersonMigrationPolicy

- (BOOL)beginEntityMapping:(NSEntityMapping *)mapping manager:(NSMigrationManager *)manager error:(NSError * _Nullable __autoreleasing *)error {
    
    NSMutableDictionary *userInfo = [@{} mutableCopy];
    userInfo[@"countries"] = [@{} mutableCopy];
    manager.userInfo = userInfo;
    
    return YES;
}

- (BOOL)createDestinationInstancesForSourceInstance:(Person *)sInstance
                                      entityMapping:(NSEntityMapping *)mapping
                                            manager:(NSMigrationManager *)manager
                                              error:(NSError * _Nullable __autoreleasing *)error
{
    NSManagedObjectContext *destinationContext = [manager destinationContext];
    NSString *destinationEntityName = [mapping destinationEntityName];
    
    Person *dInstance = [NSEntityDescription insertNewObjectForEntityForName:destinationEntityName inManagedObjectContext:destinationContext];
    dInstance.name = sInstance.name;
    dInstance.lastName = sInstance.lastName;
    dInstance.birthday = sInstance.birthday;
    dInstance.email = sInstance.email;
    
    NSString *nameOfACountry = [sInstance valueForKey:@"country"];
    
    Country *country = manager.userInfo[@"countries"][nameOfACountry];
    if (!country) {
        country = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:destinationContext];
        country.name = nameOfACountry;
        
        manager.userInfo[@"countries"][nameOfACountry] = country;
    }
    
    dInstance.country = country;
    
    [manager associateSourceInstance:sInstance
             withDestinationInstance:dInstance
                    forEntityMapping:mapping];
    
    return YES;
}

- (BOOL)createRelationshipsForDestinationInstance:(NSManagedObject *)dInstance entityMapping:(NSEntityMapping *)mapping manager:(NSMigrationManager *)manager error:(NSError * _Nullable __autoreleasing *)error {
    return YES;
}

@end

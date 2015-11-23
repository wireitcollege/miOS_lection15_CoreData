//
//  Country+CoreDataProperties.h
//  coredata
//
//  Created by Admin on 11/23/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Country.h"

NS_ASSUME_NONNULL_BEGIN

@interface Country (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString * name;
@property (nullable, nonatomic, retain) NSSet<Person *> *people;

@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addPeopleObject:(Person *)value;
- (void)removePeopleObject:(Person *)value;
- (void)addPeople:(NSSet<Person *> *)values;
- (void)removePeople:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END

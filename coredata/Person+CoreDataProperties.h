//
//  Person+CoreDataProperties.h
//  coredata
//
//  Created by Admin on 11/23/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"
#import "Country.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *birthday;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Phone *> *telephones;
@property (nullable, nonatomic, retain) Country *country;
@property (nonatomic, strong, readonly) NSString *countryName;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addTelephonesObject:(Phone *)value;
- (void)removeTelephonesObject:(Phone *)value;
- (void)addTelephones:(NSSet<Phone *> *)values;
- (void)removeTelephones:(NSSet<Phone *> *)values;

@end

NS_ASSUME_NONNULL_END

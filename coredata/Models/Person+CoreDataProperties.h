//
//  Person+CoreDataProperties.h
//  coredata
//
//  Created by Admin on 11/18/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *birthday;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *telephones;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addTelephonesObject:(NSManagedObject *)value;
- (void)removeTelephonesObject:(NSManagedObject *)value;
- (void)addTelephones:(NSSet<NSManagedObject *> *)values;
- (void)removeTelephones:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END

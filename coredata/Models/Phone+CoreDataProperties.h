//
//  Phone+CoreDataProperties.h
//  coredata
//
//  Created by Admin on 11/18/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Phone.h"

NS_ASSUME_NONNULL_BEGIN

@interface Phone (CoreDataProperties)

@property (nonatomic) int32_t type;
@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) Person *person;

@end

NS_ASSUME_NONNULL_END

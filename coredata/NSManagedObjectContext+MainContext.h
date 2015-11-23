//
//  NSManagedObjectContext+MainContext.h
//  coredata
//
//  Created by Admin on 11/18/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (MainContext)

+ (instancetype)mainContext;
- (void)saveContext;

@end

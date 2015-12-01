//
//  Country+JSONMapping.h
//  coredata
//
//  Created by Admin on 11/25/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "Country.h"

@interface Country (JSONMapping)

+ (void)loadObjectsInCoreData:(id)json inContext:(NSManagedObjectContext *)context;
+ (instancetype)countryWithDictionary:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context;

@end

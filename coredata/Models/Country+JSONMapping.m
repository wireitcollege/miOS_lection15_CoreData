//
//  Country+JSONMapping.m
//  coredata
//
//  Created by Admin on 11/25/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "Country+JSONMapping.h"
#import "NSManagedObject+ActiveDirectory.h"

@implementation Country (JSONMapping)

+ (void)loadObjectsInCoreData:(id)json inContext:(NSManagedObjectContext *)context
{
    if ([json isKindOfClass:[NSDictionary class]]) {
        [self countryWithDictionary:json inContext:context];
    }
    if ([json isKindOfClass:[NSArray class]]) {
        NSMutableArray *objects = [@[] mutableCopy];
        
        for (NSDictionary *object in (NSArray *)json) {
            id managedObject = [self countryWithDictionary:object inContext:context];
            if (managedObject) {
                [objects addObject:managedObject];
            }
        }
    }
}

+ (instancetype)countryWithDictionary:(NSDictionary *)dict
                            inContext:(NSManagedObjectContext *)context
{
    NSString *uniqueName = dict[@"name"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", uniqueName];
    NSFetchRequest *request = [self request];
    request.predicate = predicate;
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    Country *newCountry;
    if (!error && results.count) {
        newCountry = results.firstObject;
    } else {
        newCountry = [Country createEntityInContext:context];
        newCountry.name = uniqueName;
    }
    
    newCountry.population = dict[@"population"];
    newCountry.capital =    dict[@"capital"];
    newCountry.region =     dict[@"region"];
    
    NSArray *latlng =       dict[@"latlng"];
    newCountry.latitude =   @([latlng.firstObject doubleValue]);
    newCountry.longitude =  @([latlng.lastObject doubleValue]);
    
    return newCountry;
}

@end

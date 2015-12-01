//
//  Country+Annotation.m
//  coredata
//
//  Created by Admin on 12/1/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "Country+Annotation.h"

@implementation Country (Annotation)

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%@ (%@)", self.capital, self.population];
}

@end

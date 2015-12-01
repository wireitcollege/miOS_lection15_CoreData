//
//  CountryListController.h
//  coredata
//
//  Created by Admin on 11/25/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country+CoreDataProperties.h"

typedef void (^CountryListDidSelect)(Country *country);

@interface CountryListController : UITableViewController

@property (nonatomic, copy) CountryListDidSelect onSelect;

@end

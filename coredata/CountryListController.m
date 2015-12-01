//
//  CountryListController.m
//  coredata
//
//  Created by Admin on 11/25/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "CountryListController.h"

#import "NSManagedObject+ActiveDirectory.h"
#import "APIManager.h"

@interface CountryListController() <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation CountryListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = NSLocalizedString(@"Loading...", nil);
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
    self.tableView.backgroundView = label;
    [[APIManager defaultManager] loadCountries:^{
        self.tableView.backgroundView = nil;
    }];
}

#pragma mark - Properties

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        NSArray *terms = @[
                           [NSSortDescriptor sortDescriptorWithKey:@"region"
                                                         ascending:YES
                                                          selector:@selector(localizedStandardCompare:)],
                           [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                         ascending:YES
                                                          selector:@selector(localizedStandardCompare:)]];
        _fetchedResultsController = [Country fetchedResulttWithSortDescriptors:terms
                                                                     predicate:nil
                                                                     groupedBy:@"region"];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _fetchedResultsController = nil;
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseCellIdentifier = @"Country Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo =
    self.fetchedResultsController.sections[section];
    
    return sectionInfo.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if (self.onSelect) {
        self.onSelect(country);
        self.onSelect = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Fetched Results Controller Delegate

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", country.capital, country.population];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

@end

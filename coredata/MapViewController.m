//
//  MapViewController.m
//  coredata
//
//  Created by Admin on 12/1/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "NSManagedObject+ActiveDirectory.h"
#import "NSManagedObjectContext+MainContext.h"
#import "Person.h"
#import "ContactsByCountryTVC.h"

@interface MapViewController () <MKMapViewDelegate>
@property (nonatomic, strong, readonly) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray <id <MKAnnotation>> *annotations;
@end

@implementation MapViewController

#pragma mark - View Controller Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView showAnnotations:self.annotations animated:animated];
}

#pragma mark - Properties

- (void)setMapView:(MKMapView *)mapView {
    _mapView = mapView;
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeSatellite;
    [_mapView addAnnotations:self.annotations];
}

- (NSManagedObjectContext *)context {
    return [NSManagedObjectContext mainContext];
}

- (NSArray<id<MKAnnotation>> *)annotations {
    if (!_annotations) {
        NSFetchRequest *request = [Country request];
        NSError *error = nil;
        NSArray *objects = [self.context executeFetchRequest:request error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        
        _annotations = objects;// [objects valueForKey:@"country"];
    }
    return _annotations;
}

#pragma mark - Map View

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *const kReuseIdentifier = @"Some ID";
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:kReuseIdentifier];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kReuseIdentifier];
        aView.canShowCallout = YES;
        aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    aView.annotation = annotation;
    
    return aView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)view.leftCalloutAccessoryView;
        imageView.image = nil;
        // load data from network...
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[Country class]]) {
        [self performSegueWithIdentifier:@"Show Contacts From Country" sender:view];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ContactsByCountryTVC class]] &&
        [sender isKindOfClass:[MKAnnotationView class]]) {
        MKAnnotationView *aView = sender;
        Country *country = aView.annotation;
        ContactsByCountryTVC *cbctvc = segue.destinationViewController;
        cbctvc.country = country;
    }
}

@end

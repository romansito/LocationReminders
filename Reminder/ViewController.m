//
//  ViewController.m
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/23/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"
#import "DetailViewController.h"

@interface ViewController () <LocationControllerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)locationButtonSelected:(UIButton *)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	[self.mapView.layer setCornerRadius:200.0];
	[self.mapView setShowsUserLocation:YES];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[LocationController sharedController]setDelegate:self];
	[[[LocationController sharedController]locationManager]startUpdatingLocation];
}


- (void)setRegionForCoordinate:(MKCoordinateRegion) region {
	[self.mapView setRegion:region animated:YES];
}

- (IBAction)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture {
	
	if (gesture.state == UIGestureRecognizerStateBegan) {
		CGPoint touchPoint = [gesture locationInView:self.mapView];
		CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
		
		MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
		newPoint.coordinate = touchMapCoordinate;
		newPoint.title = @"SUP";
		newPoint.subtitle = @"I am a pretty pin!";
		
		[self.mapView addAnnotation:newPoint];
	}
}


- (IBAction)locationButtonSelected:(UIButton *)sender {
	
	NSString *buttonTitle = sender.titleLabel.text;
	if ([buttonTitle isEqualToString:@"LocationOne"]){
		NSLog(@"LocationOne");
		
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.7127837, -74.00594130000002);
		MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000.00, 1000.00);
		[self setRegionForCoordinate:region];
	
	}
	if ([buttonTitle isEqualToString:@"LocationTwo"]){
		NSLog(@"LocationTwo");
		
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.30732279999999, -122.22845319999999);
		MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000.00, 1000.00);
		[self setRegionForCoordinate:region];
	}
	if ([buttonTitle isEqualToString:@"LocationThree"]) {
		NSLog(@"LocationThree");
		
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(51.5073509, -0.12775829999998223);
		MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000.00, 1000.00);
		[self setRegionForCoordinate:region];
	}
	
}

#pragma mark - LocationController Delegate

- (void) locationControllerDidUpdateLocation:(CLLocation *)location {
	[self setRegionForCoordinate:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.00, 500.00)];
}

#pragma mark - MapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

	if ([annotation isKindOfClass:[MKUserLocation class]]) {return nil; }
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
	annotationView.annotation = annotation;
	[annotationView setPinColor:MKPinAnnotationColorPurple];
	
	if (!annotationView) {
		annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
		
	}
	
	annotationView.canShowCallout = true;
	UIButton *rightCallOut = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	annotationView.rightCalloutAccessoryView = rightCallOut;
	
	
	return annotationView;
	
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	[self performSegueWithIdentifier:@"DetailViewController" sender:view];
}


@end

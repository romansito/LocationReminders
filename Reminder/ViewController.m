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

@import Parse;
@import ParseUI;



@interface ViewController () <LocationControllerDelegate, MKMapViewDelegate, PFLogInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

//- (IBAction)locationButtonSelected:(UIButton *)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	[self.mapView.layer setCornerRadius:20.0];
	[self.mapView setShowsUserLocation:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[LocationController sharedController]setDelegate:self];
	[[[LocationController sharedController]locationManager]startUpdatingLocation];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:YES];
	[self logIn];
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

#pragma mark - Parse

-(void)additionalUI {
	UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]initWithTitle:@"sign out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
	self.navigationItem.rightBarButtonItem = signOutButton;
}

- (void)logIn {
	if (![PFUser currentUser]) {
		PFLogInViewController *logInViewController = [[PFLogInViewController alloc]init];
		logInViewController.delegate = self;
		[self presentViewController:logInViewController animated:YES completion:nil];
	} else {
		[self additionalUI];
	}
}

- (void)logOut {
	
	[PFUser logOut];
	[self logIn];
	
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
	[self dismissViewControllerAnimated:YES completion:nil];
	[self additionalUI];
}



@end

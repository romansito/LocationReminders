//
//  DetailViewController.m
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/24/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "DetailViewController.h"
#import <Parse/Parse.h>
#import "Reminder.h"
#import "LocationController.h"
@import MapKit;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;
- (IBAction)createReminderButtonSelected:(UIButton *)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSLog(@"%@", self.annotationTitle);
	NSLog(@"%f %f", self.coordinate.latitude, self.coordinate.longitude);
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.reminderTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)createReminderButtonSelected:(UIButton *)sender {
	
	UILocalNotification *notification = [[UILocalNotification alloc]init];
	notification.alertTitle = self.reminderTextField.text;

	
	Reminder *reminder = [[Reminder alloc]init];
	reminder.reminder = self.reminderTextField.text;
	reminder.radius = [NSNumber numberWithFloat:self.radiusTextField.text.floatValue];
	reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
	[reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
		NSLog(@"Reminder Saved to Parse");
		
		// If completion was set
		
		if (self.completion) {
			
			// check for abilities
			if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    
				// create a new region
				CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:self.radiusTextField.text.floatValue identifier:self.reminderTextField.text];
				[[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
				
				// pass it to the be added to the map
				self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:self.radiusTextField.text.floatValue]);
				
				// dismiss
				[self.navigationController popViewControllerAnimated:YES];
			}
		}
		
	}];
}





@end






















































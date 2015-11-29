//
//  LocationController.m
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/24/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "LocationController.h"

@interface LocationController () <CLLocationManagerDelegate>
@end

@implementation LocationController

+ (LocationController *)sharedController {
	static LocationController *sharedController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^ {
		sharedController = [[self alloc]init];
	});
	
	return sharedController;
}
	- (id)init {
		self = [super init];
		if (self) {
			_locationManager = [[CLLocationManager alloc]init];
			_locationManager.delegate = self;
			_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
			_locationManager.distanceFilter = 50;
			
			[_locationManager requestAlwaysAuthorization];
		}
		return self;
	}

#pragma mark - Location Manager

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	[self.delegate locationControllerDidUpdateLocation:locations.lastObject];
	[self setLocation:locations.lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
	UILocalNotification *notification = [[UILocalNotification alloc]init];
	notification.alertTitle = @"Reminder";
	[[UIApplication sharedApplication]presentLocalNotificationNow:notification];
}

//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
//	
//	NSLog(@"User did enter region.");
//	
//	UILocalNotification *notification = [[UILocalNotification alloc]init];
//	notification.alertTitle = @"Reminder";
//	notification.alertBody = @"Buy Eggs.";
//	
//	[[UIApplication sharedApplication]presentLocalNotificationNow:notification];
//}





@end

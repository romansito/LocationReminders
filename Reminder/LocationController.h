//
//  LocationController.h
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/24/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

@import Foundation;
@import CoreLocation;
@import UIKit;

@protocol LocationControllerDelegate <NSObject>

@optional
- (void) locationControllerDidUpdateLocation: (CLLocation *) location;

@end

@interface LocationController : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) id delegate;
+ (LocationController *)sharedController;

@end



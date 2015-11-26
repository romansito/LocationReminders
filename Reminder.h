//
//  Reminder.h
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/25/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//
@import Foundation;
@import Parse;

@interface Reminder : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *reminder;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSNumber *radius;

@end

//
//  Reminder.m
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/25/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic reminder;
@dynamic location;
@dynamic radius;

+ (void)load {
	[self registerSubclass];
}

+ (NSString *)parseClassName {
	return @"Reminder";
}

@end

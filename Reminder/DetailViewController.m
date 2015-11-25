//
//  DetailViewController.m
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/24/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSLog(@"%@", self.annotationTitle);
	NSLog(@"%f %f", self.coordinate.latitude, self.coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

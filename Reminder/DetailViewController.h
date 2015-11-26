//
//  DetailViewController.h
//  Reminder
//
//  Created by Roman Salazar Lopez on 11/24/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "ViewController.h"
@import MapKit;

typedef void(^DetailViewControllerCompletion)(MKCircle *circle);

@interface DetailViewController : ViewController

@property (copy, nonatomic) DetailViewControllerCompletion completion;
@property (strong, nonatomic) NSString *annotationTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

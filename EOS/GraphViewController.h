//
//  GraphViewController.h
//  EOS
//
//  Created by Allen White on 11/14/15.
//  Copyright © 2015 ScheduleFour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"

@interface GraphViewController : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (strong, nonatomic) IBOutlet BEMSimpleLineGraphView *daGraph;
@property NSMutableArray *points;

@end

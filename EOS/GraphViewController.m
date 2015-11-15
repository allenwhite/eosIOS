//
//  GraphViewController.m
//  EOS
//
//  Created by Allen White on 11/14/15.
//  Copyright © 2015 ScheduleFour. All rights reserved.
//

#import "GraphViewController.h"
#import "AFAPIclient.h"

@interface GraphViewController ()
@property NSMutableArray *arrayOfDates;
@property UILabel *labelValues;
@property UILabel *labelDates;
@end

@implementation GraphViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.points = [NSMutableArray new];
	self.arrayOfDates = [NSMutableArray new];
	[self getData];
	
//	self.points = @[@2, @7, @3, @5];
//	self.arrayOfDates = @[@"04/12",@"04/13",@"04/14",@"04/15"];
	self.daGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 24, self.view.frame.size.width, self.view.frame.size.width)];
	
	
	self.daGraph.dataSource = self;
	self.daGraph.delegate = self;
	self.daGraph.enableBezierCurve = YES;
	
	self.daGraph.enableTouchReport = YES;
	self.daGraph.enablePopUpReport = YES;
	self.daGraph.enableYAxisLabel = YES;
	self.daGraph.autoScaleYAxis = YES;
	self.daGraph.alwaysDisplayDots = NO;
	self.daGraph.enableReferenceXAxisLines = YES;
	self.daGraph.enableReferenceYAxisLines = YES;
	self.daGraph.enableReferenceAxisFrame = YES;
	
	
	// Draw an average line
	self.daGraph.averageLine.enableAverageLine = YES;
	self.daGraph.averageLine.alpha = 0.6;
	self.daGraph.averageLine.color = [UIColor darkGrayColor];
	self.daGraph.averageLine.width = 2.5;
	self.daGraph.averageLine.dashPattern = @[@(2),@(2)];

	
	// Set the graph's animation style to draw, fade, or none
	self.daGraph.animationGraphStyle = BEMLineAnimationDraw;
	
	// Dash the y reference lines
	self.daGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
	
	// Show the y axis values with this format string
	self.daGraph.formatStringForValues = @"%.1f";

	UIColor *color = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
	self.daGraph.colorTop = color;
	self.daGraph.colorBottom = color;
	self.daGraph.backgroundColor = color;
	
	
	self.labelValues = [[UILabel alloc] initWithFrame:CGRectMake(
								     0,
								     self.daGraph.frame.size.height +24,
								     self.view.frame.size.width,
								     40)];
	self.labelValues.textAlignment = NSTextAlignmentCenter;
	self.labelDates = [[UILabel alloc] initWithFrame:CGRectMake(
								    0,
								    self.labelValues.frame.size.height + self.labelValues.frame.origin.y,
								    self.view.frame.size.width,
								    40)];
	self.labelDates.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.labelValues];
	[self.view addSubview:self.labelDates];
	
	[self.view addSubview:self.daGraph];
	self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.daGraph calculatePointValueSum] intValue]];
	self.labelDates.text = @"between now and later";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
	return self.points.count; // Number of points in the graph.
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
	return [[self.points objectAtIndex:index] floatValue];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)labelForDateAtIndex:(NSInteger)index {
	if ([self.arrayOfDates count] != 0) {
		NSString *date = self.arrayOfDates[index];
		//	NSLog(@"date = %@", date);
		//	NSDateFormatter *df = [[NSDateFormatter alloc] init];
		//	df.dateFormat = @"MM/dd";
		//	NSString *label = [df stringFromDate:date];
		//	NSLog(@"label-> %@", label);
		return date;
	}
	return @"";
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
	return 2;
}


- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
	
	NSString *label = [self labelForDateAtIndex:index];
	return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}


- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
	self.labelValues.text = [NSString stringWithFormat:@"%@", [self.points objectAtIndex:index]];
	self.labelDates.text = [NSString stringWithFormat:@"in %@", [self labelForDateAtIndex:index]];
}


- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
	[UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.labelValues.alpha = 0.0;
		self.labelDates.alpha = 0.0;
	} completion:^(BOOL finished) {
		self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.daGraph calculatePointValueSum] intValue]];
		self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self labelForDateAtIndex:0], [self labelForDateAtIndex:self.arrayOfDates.count - 1]];
		[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			self.labelValues.alpha = 1.0;
			self.labelDates.alpha = 1.0;
		} completion:nil];
	}];
}


- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
	self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.daGraph calculatePointValueSum] intValue]];
	self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self labelForDateAtIndex:0], [self labelForDateAtIndex:self.arrayOfDates.count - 1]];
}



- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph {
	return @" units";
}



-(void)getData{
	[[AFAPIclient sharedClient] GET:@"" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
		NSLog(@"json - %@", JSON);
		[self.points removeAllObjects];
		[self.arrayOfDates removeAllObjects];
		for (NSDictionary *res in JSON) {
			if (![res isEqual:[NSNull null]]) {
				[self.points addObject:[res objectForKey:@"result"]];
				[self.arrayOfDates addObject:[[res objectForKey:@"coreInfo"] objectForKey:@"last_heard"]];
			}
		}
		NSLog(@"!%@", self.points);
		[self.daGraph reloadGraph];
	} failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
		NSLog(@"error - %@", error);
	}];

}

@end

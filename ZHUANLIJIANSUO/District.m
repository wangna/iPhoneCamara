//
//  DemoMapAnnotation.m
//  Created by Gregory Combs on 11/30/11.
//
//  based on work at https://github.com/grgcombs/MultiRowCalloutAnnotationView
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. 
//  To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/
//  or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
//
//

#import "District.h"
#import "Representative.h"

@interface District()
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title representatives:(NSArray *)representatives;
@end

@implementation District
@synthesize title = _title;
@synthesize coordinate = _coordinate;
@synthesize representatives = _representatives;

#pragma mark For Demonstration Purposes

/* Naturally, you should set up your annotation objects as usual, but this demo factory helps distance the cell data from the view controller. */
+ (District *)demoAnnotationFactory:(double)x :(double)y :(NSString *)address :(NSString *)teleph :(NSString *)fax :(NSString *)name {
    Representative *dudeOne = [Representative representativeWithName:nil party:name image:nil representativeID:@"TXL1"];
//    Representative *dudeTwo = [Representative representativeWithName:teleph party:@"电话:" image:nil representativeID:@"TXL2"];
//	Representative *dudeThree = [Representative representativeWithName:fax party:@"传真:" image:nil representativeID:@"TXL3"];
    return [District districtWithCoordinate:CLLocationCoordinate2DMake(x, y) title:@"名称" representatives:[NSArray arrayWithObjects:dudeOne, nil]];    
}

#pragma mark - The Good Stuff

+ (District *)districtWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title representatives:(NSArray *)representatives {
    return [[[District alloc] initWithCoordinate:coordinate title:title representatives:representatives] autorelease];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title representatives:(NSArray *)representatives {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.title = title;
        self.representatives = representatives;
    }
    return self;
}

- (void)dealloc {
    self.title = nil;
    self.representatives = nil;
    [super dealloc];
}

- (NSArray *)calloutCells {
    if (!_representatives || [_representatives count] == 0)
        return nil;
    return [self valueForKeyPath:@"representatives.calloutCell"];
}

@end

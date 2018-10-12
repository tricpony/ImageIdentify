#import <XCTest/XCTest.h>
#import "ImageIdentify.h"

@interface ImageIdentifyTests : XCTestCase

@end

@implementation ImageIdentifyTests

- (void)setUp {
    [super setUp];
	NSLog(@"setUp");
}

- (void)tearDown {
    [super tearDown];
}

- (void)testImage1 {
	XCTAssertEqualObjects([[ImageIdentify new] identifyImage:[UIApplication.sharedApplication.keyWindow viewWithTag:101]], @"cat1");
}

- (void)testImage2 {
	XCTAssertEqualObjects([[ImageIdentify new] identifyImage:[UIApplication.sharedApplication.keyWindow viewWithTag:102]], @"cat2");
}

- (void)testImage3 {
	XCTAssertEqualObjects([[ImageIdentify new] identifyImage:[UIApplication.sharedApplication.keyWindow viewWithTag:103]], @"cat3");
}

- (void)testImage4 {
	XCTAssertEqualObjects([[ImageIdentify new] identifyImage:[UIApplication.sharedApplication.keyWindow viewWithTag:104]], @"cat4");
}

- (void)testImage5 {
	XCTAssertEqualObjects([[ImageIdentify new] identifyImage:[UIApplication.sharedApplication.keyWindow viewWithTag:105]], @"cat5");
}

- (void)testImage6 {
	XCTAssertEqualObjects([[ImageIdentify new] identifyImage:[UIApplication.sharedApplication.keyWindow viewWithTag:106]], @"cat6");
}

@end

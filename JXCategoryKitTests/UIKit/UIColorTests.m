//
//  UIColorTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/4/25.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+JXGeneral.h"
#import "UIColor+JXSpaceComponent.h"

@interface UIColorTests : XCTestCase

@end

@implementation UIColorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample_General {
    UIColor *purpleColor = [UIColor purpleColor];
    XCTAssertTrue(purpleColor.red == 0.5);
    XCTAssertTrue(purpleColor.blue == 0.5);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 1.0);
    
    purpleColor = [UIColor jx_colorFromRed:128 green:0 blue:128 alpha:0.0];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 0.0);
    
    purpleColor = [UIColor jx_colorFromRed:128 green:0 blue:128];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 1.0);
    
    purpleColor = [UIColor jx_colorFromRGBA:0x800080ff];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 1.0);
    
    purpleColor = [UIColor jx_colorFromRGB:0x800080];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 1.0);
    
    purpleColor = [UIColor jx_colorFromRGB:0x800080 alpha:0.0];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 0.0);
    
    purpleColor = [UIColor jx_colorFromHexString:@"#800080" alpha:0.0];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 0.0);
    
    purpleColor = [UIColor jx_colorFromHexString:@"800080"];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.blue <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 1.0);
    
    XCTAssertTrue(purpleColor.jx_rgbaValue == 0x800080ff);
    XCTAssertTrue([purpleColor.jx_rgbaHexString isEqualToString:@"800080ff"]);
    
    purpleColor = [UIColor jx_colorWithHue:0.8333333 saturation:1.0 lightness:0.251 alpha:1.0];
    XCTAssertTrue(purpleColor.red >= 0.5 && purpleColor.red <= 0.51);
    XCTAssertTrue(purpleColor.blue >= 0.5 && purpleColor.blue <= 0.51);
    XCTAssertTrue(purpleColor.green == 0.0);
    XCTAssertTrue(purpleColor.alpha == 1.0);
    
    CGFloat cyan = 0;
    CGFloat magenta = 0;
    CGFloat yellow = 0;
    CGFloat black = 0;
    CGFloat alpha = 0;
    
    [purpleColor jx_getCyan:&cyan magenta:&magenta yellow:&yellow black:&black alpha:&alpha];
    NSLog(@"%f",cyan);
    NSLog(@"%f",magenta);
    NSLog(@"%f",yellow);
    NSLog(@"%f",black);
}

@end

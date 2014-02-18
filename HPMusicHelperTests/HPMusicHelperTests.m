//
//  HPMusicHelperTests.m
//  HPMusicHelperTests
//
//  Created by Hervé PEROTEAU on 17/07/13.
//  Copyright (c) 2013 Hervé PEROTEAU. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HPMusicHelper.h"

@interface HPMusicHelperTests : XCTestCase

@end

@implementation HPMusicHelperTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testCleanArtistTheStrokes
{
    NSString *name = @"The Strokes";
    NSString *expected = @"strokes";
    
    NSString *result = [HPMusicHelper cleanArtistName:name];
    
    NSLog(@"cleanArtistName name=%@ expected=%@ result=%@", name, expected, result);
    
    XCTAssertEqualObjects(result, expected, @"cleanArtistName name=%@ %@ != %@ !!!", name, result, expected);
}

- (void)testCleanArtistTheStrokesBis
{
    NSString *name = @"The Strokes";
    NSString *expected = @"strokes";
    
    NSString *result = [HPMusicHelper cleanArtistName:name];
    
    NSLog(@"cleanArtistName name=%@ expected=%@ result=%@", name, expected, result);
    
    XCTAssertEqualObjects(result, expected, @"cleanArtistName name=%@ %@ != %@ !!!", name, result, expected);
}

- (void)testCleanArtistTheStrokes2
{
    NSString *name = @" The Strokes";
    NSString *expected = @"strokes";
    
    NSString *result = [HPMusicHelper cleanArtistName:name];
    
    NSLog(@"cleanArtistName name=%@ expected=%@ result=%@", name, expected, result);
    
    XCTAssertEqualObjects(result, expected, @"cleanArtistName name=%@ %@ != %@ !!!", name, result, expected);
}

- (void)testCleanArtistTheStrokes3
{
    NSString *name = @"Les Strokes";
    NSString *expected = @"strokes";
    
    NSString *result = [HPMusicHelper cleanArtistName:name];
    
    NSLog(@"cleanArtistName name=%@ expected=%@ result=%@", name, expected, result);
    
    XCTAssertEqualObjects(result, expected, @"cleanArtistName name=%@ %@ != %@ !!!", name, result, expected);
}

- (void)testCleanArtistBeyonce
{
    NSString *name = @"BEYONCÉ";
    NSString *expected = @"beyoncé";
    
    NSString *result = [HPMusicHelper cleanArtistName:name];
    
    NSLog(@"cleanArtistName name=%@ expected=%@ result=%@", name, expected, result);
    
    XCTAssertEqualObjects(result, expected, @"cleanArtistName name=%@ %@ != %@ !!!", name, result, expected);
}


- (void)testCleanSong1
{
    NSString *name = @"Scream & Shout (feat. Britney Spears)";
    NSString *expected = @"scream & shout";
    
    NSString *result = [HPMusicHelper cleanSongTitle:name];
    
    NSLog(@"cleanSongTitle name=%@ expected=%@ result=%@", name, expected, result);
    
    XCTAssertEqualObjects(result, expected, @"cleanSongTitle name=%@ %@ != %@ !!!", name, result, expected);
}

- (void)testCleanSong2
{
    NSString *name = @"Test accentué à boût de nèrf";
    NSString *expected = @"test accentue a bout de nerf";
    
    NSString *result = [HPMusicHelper cleanSongTitle:name];
    
    NSLog(@"cleanSongTitle name=%@ expected=%@ result=%@", name, expected, result);
    
    XCTAssertEqualObjects(result, expected, @"cleanSongTitle name=%@ %@ != %@ !!!", name, result, expected);
}

- (void)testCleanAlbumTitle
{
    NSString *result = [HPMusicHelper cleanAlbumTitle:@"01- Blabla"];
    NSLog(@"testCleanAlbumTitle result=%@", result);

    result = [HPMusicHelper cleanAlbumTitle:@"01, Blabla"];
    NSLog(@"testCleanAlbumTitle result=%@", result);

    result = [HPMusicHelper cleanAlbumTitle:@"01 Blabla"];
    NSLog(@"testCleanAlbumTitle result=%@", result);

    result = [HPMusicHelper cleanAlbumTitle:@"01: Blabla"];
    NSLog(@"testCleanAlbumTitle result=%@", result);

}


@end

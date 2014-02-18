//
//  HPMusicHelper.h
//  HPMusicHelper
//
//  Created by Hervé PEROTEAU on 17/07/13.
//  Copyright (c) 2013 Hervé PEROTEAU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HPMusicHelper : NSObject


// Ex : The Strokes => strokes
+(NSString *) cleanArtistName:(NSString *) artist;
+(NSString *) cleanArtistName:(NSString *) artist  PreserveAccent:(BOOL)preserveAccent;

// Ex: Scream & Shout (feat. Britney Spears) => scream & shout
+(NSString *) cleanSongTitle:(NSString *) title;
+(NSString *) cleanSongTitle:(NSString *) title PreserveAccent:(BOOL)preserveAccent;

// Ex: Loud (Deluxe Edition) => lound
+(NSString *) cleanAlbumTitle:(NSString *) title;
+(NSString *) cleanAlbumTitle:(NSString *) title PreserveAccent:(BOOL)preserveAccent;

@end

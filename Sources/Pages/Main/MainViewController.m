//
//  MainViewController.m
//  DecryptionOfVideoOnFly
//
//  Created by Ildar Sibagatov on 02.07.14.
//  Copyright (c) 2014 Sig Inc. All rights reserved.
//

#import "MainViewController.h"
#import "GCDWebServerFileResponseWithDecryption.h"

@interface MainViewController ()
{
    GCDWebServer* webServer;
}
@property (strong) MPMoviePlayerController *moviePlayerController;

@end


@implementation MainViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webServer = [[GCDWebServer alloc] init];
    [webServer addDefaultHandlerForMethod:@"GET"
                             requestClass:[GCDWebServerRequest class]
                             processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                                 DPLogFast(@"request : %@", request);
                                 GCDWebServerFileResponseWithDecryption *response = [GCDWebServerFileResponseWithDecryption responseWithFile:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mov"]
                                                                                                                                   byteRange:[request byteRange]
                                                                                                                                isAttachment:NO];
                                 DPLogFast(@"response : %@", response);
                                 return response;
                             }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
}

#pragma mark - Логика

- (NSURL*)localMovieURL
{
	NSURL *theMovieURL = nil;
	NSBundle *bundle = [NSBundle mainBundle];
	if (bundle) {
        NSString *moviePath = [bundle pathForResource:@"video" ofType:@"mov"];
		if (moviePath)
		{
			theMovieURL = [NSURL fileURLWithPath:moviePath];
		}
	}
    
    NSLog(@"theMovieURL = %@", theMovieURL);
    
    return theMovieURL;
}

- (NSURL*)streamMovieURL
{
	NSURL *theMovieURL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];
    
    if (webServer.isRunning) {
        theMovieURL = (webServer.serverURL)?webServer.serverURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://0.0.0.0:%d", webServer.port]];
    }
    
    NSLog(@"theMovieURL = %@", theMovieURL);
    
    return theMovieURL;
}

#pragma mark - Обработка нажатий

- (IBAction)playLocalFileClicked:(id)sender
{
    DPLogFast(@"");
    
    MPMoviePlayerController *movie_player = [[MPMoviePlayerController alloc] initWithContentURL:[self localMovieURL]];
    [self.view addSubview:movie_player.view];
    movie_player.shouldAutoplay = YES;
    [movie_player prepareToPlay];
    movie_player.fullscreen = YES;
    movie_player.movieSourceType = MPMovieSourceTypeFile;
    [movie_player play];
    
    if (self.moviePlayerController != nil) {
        [self.moviePlayerController stop];
        [self.moviePlayerController.view removeFromSuperview];
        self.moviePlayerController = nil;
    }
    self.moviePlayerController = movie_player;
}

- (IBAction)playFileFromStreamClicked:(id)sender
{
    DPLogFast(@"");
    
    MPMoviePlayerController *movie_player = [[MPMoviePlayerController alloc] initWithContentURL:[self streamMovieURL]];
    [self.view addSubview:movie_player.view];
    movie_player.movieSourceType = MPMovieSourceTypeStreaming;
    movie_player.contentURL = [self streamMovieURL];
    movie_player.shouldAutoplay = YES;
    movie_player.fullscreen = YES;
    
    [movie_player prepareToPlay];
    [movie_player play];
    
    if (self.moviePlayerController != nil) {
        [self.moviePlayerController stop];
        [self.moviePlayerController.view removeFromSuperview];
        self.moviePlayerController = nil;
    }
    self.moviePlayerController = movie_player;
}

- (IBAction)startStopClicked:(UIButton*)sender
{
    DPLogFast(@"");
    
    [sender setTitle:([[sender titleForState:UIControlStateNormal] isEqual:@"START"])?@"STOP":@"START"
            forState:UIControlStateNormal];
    
    //	if (isRunning) {
    //        DPLogFast(@"STOP state");
    //
    //        [webServer stop];
    //        DPLogFast(@"webServer.isRunning : %d", webServer.isRunning);
    //
    //		isRunning = false;
    //	}
    //	else {
    //        DPLogFast(@"START state");
    //
    //        [webServer startWithPort:8080 bonjourName:nil];
    //        DPLogFast(@"ADDRESS : %@", webServer.serverURL);
    //
    //		isRunning = YES;
    //	}
}

#pragma mark - Обработка уведомлений

- (void)doneButtonClick:(NSNotification*)notification
{
    DPLogFast(@"");
    
    NSNumber *reason = [notification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if ([reason intValue] == MPMovieFinishReasonUserExited) {
        [self.moviePlayerController stop];
        [self.moviePlayerController.view removeFromSuperview];
        self.moviePlayerController = nil;
    }
}

@end

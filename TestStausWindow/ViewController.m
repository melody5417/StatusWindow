//
//  ViewController.m
//  TestStausWindow
//
//  Created by Yiqi Wang on 2016/12/29.
//  Copyright © 2016年 Melody5417. All rights reserved.
//

#import "ViewController.h"
#import "PopWindowController.h"

@interface ViewController ()
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) PopWindowController *popWindowController;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // setup status item
  self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  NSImage *normalIcon = [NSImage imageNamed:@"tray_icon_normal"];
  NSImage *activeIcon = [NSImage imageNamed:@"tray_icon_active"];
  normalIcon.template = YES;
  
  [self.statusItem setHighlightMode:YES];
  [self.statusItem setImage:normalIcon];
  [self.statusItem setAlternateImage:activeIcon];
  [self.statusItem setTarget:self];
  [self.statusItem setAction:@selector(handleClick:)];
  [self.statusItem setHighlightMode:YES];
  
  // add observer for statusButton frame
  NSWindow *statusItemWindow = [self.statusItem valueForKey:@"window"];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(statusBarDidMove:)
                                               name:NSWindowDidMoveNotification
                                             object:statusItemWindow];
  
  // setup status window
  self.popWindowController = [[PopWindowController alloc] init];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleClick:(NSStatusBarButton *)button {
  [self updateStatusWindowFrame];
}

- (void)statusBarDidMove:(NSNotification *)notification {
  NSWindow *window = notification.object;
  if (window) {
    [self updateStatusWindowFrame];
  }
}

- (void)updateStatusWindowFrame {
  NSPoint popCenterPoint = [self statusWindowPopArrowPoint];
  [self.popWindowController popAtPosition:popCenterPoint];
}

- (NSPoint)statusWindowPopArrowPoint {
  NSButton *statusButton = self.statusItem.button;
  
  NSRect buttonFrameInWindow = [statusButton convertRect:statusButton.frame toView:statusButton.window.contentView];
  NSLog(@"statusButtonFrameInWindow : %@", NSStringFromRect(buttonFrameInWindow));
  
  // buttonFrameInScreen.origin is statusButton left bottom point
  NSRect buttonFrameInScreen = [statusButton.window convertRectToScreen:buttonFrameInWindow];
  NSLog(@"statusButtonFrameInScreen : %@", NSStringFromRect(buttonFrameInScreen));
  
  NSPoint popCenterPoint = NSMakePoint(buttonFrameInScreen.origin.x + buttonFrameInScreen.size.width / 2.0,
                                       buttonFrameInScreen.origin.y);
  return popCenterPoint;
}

@end

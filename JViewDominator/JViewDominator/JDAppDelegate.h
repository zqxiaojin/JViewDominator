//
//  JDAppDelegate.h
//  JViewDominator
//
//  Created by Liang Jin on 7/20/13.
//  Copyright (c) 2013 Liang Jin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JDMainController;

@interface JDAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) JDMainController *mainController;


- (IBAction)saveAction:(id)sender;

@end

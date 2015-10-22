//
//  SQLiteManager.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"


enum errorCodes {
	kDBNotExists,
	kDBFailAtOpen, 
	kDBFailAtCreate,
	kDBErrorQuery,
	kDBFailAtClose
};

@interface SQLiteManager : NSObject {

	sqlite3 *db; // The SQLite db reference
	NSString *databaseName; // The database name
}

- (id)initWithDatabaseNamed:(NSString *)name;

// SQLite Operations
- (NSError *) openDatabase;
- (NSError *) doQuery:(NSString *)sql;
- (NSArray *) getRowsForQuery:(NSString *)sql;
- (NSError *) closeDatabase;

- (NSString *)getDatabaseDump;

@end

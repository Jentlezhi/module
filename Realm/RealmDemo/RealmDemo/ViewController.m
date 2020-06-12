//
//  ViewController.m
//  RealmDemo
//
//  Created by Jentle on 2020/6/4.
//  Copyright © 2020 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "ESRootClass.h"
#import "YYModel.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    RLMResults<ESRootClass*> *results = [ESRootClass allObjects];
//    NSLog(@"ESRootClass数据条数:%lu",(unsigned long)results.count);
//    NSLog(@"ESRootClass最新数据:%@",results.lastObject);
    NSLog(@"ESRootClass数据库位置：%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}

/// 读取本地文件
- (id)readLocalFileWithName:(NSString *)name
                                   type:(NSString *)type {

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (path == nil) {return nil;}
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data == nil) {return nil;}
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    NSDictionary *data = [self readLocalFileWithName:@"data.json" type:nil];
//    ESRootClass *model = [[ESRootClass alloc] initWithValue:data];
//    model.ID = [ESRootClass allObjects].count;
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    [realm addObject:model];
//    [realm commitWriteTransaction];
}

@end

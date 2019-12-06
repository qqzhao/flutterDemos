//
//  tool.swift
//  Runner
//
//  Created by 赵千千 on 2019/12/6.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit

func WCLog<N>(message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEBUG
    print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)");
    #endif
}

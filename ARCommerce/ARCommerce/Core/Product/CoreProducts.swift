//
//  Core.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

class CoreProducts {
    let database: DatabaseFacade
    
    init() {
        self.database = DatabaseFacade()
    }
    
    deinit{
        print("Core deleted")
    }
}

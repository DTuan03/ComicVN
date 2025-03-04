//
//  Untitled.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import RealmSwift

class User: Object {
    @objc dynamic var userId: String =  ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    
}

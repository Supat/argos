//
//  ViewRouter.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter, Never>();
    var videoURL: URL!;
    
    var currentPage: String = "selectionPage" {
        didSet {
            objectWillChange.send(self);
        }
    }
}

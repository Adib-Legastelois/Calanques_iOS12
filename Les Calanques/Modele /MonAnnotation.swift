//
//  MonAnnotation.swift
//  Les Calanques
//
//  Created by Adib Lgs on 2019-09-29.
//  Copyright © 2019 Adib Lgs. All rights reserved.
//

import UIKit
import MapKit

class MonAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var calanque: Calanque
    var title: String?
    
    init (_ calanque: Calanque) {
        self.calanque = calanque
        coordinate = self.calanque.coordonnee
        title = self.calanque.nom
    }
    
}

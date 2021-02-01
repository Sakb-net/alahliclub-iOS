//
//  File.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/2/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    
    var mainStoryboard:UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var vediosStoryboard:UIStoryboard {
        return UIStoryboard(name: "Vedios", bundle: nil)
    }
    
    var imagesStoryboard:UIStoryboard {
        return UIStoryboard(name: "Images", bundle: nil)
    }
    
    var productsStoryboard:UIStoryboard {
        return UIStoryboard(name: "Products", bundle: nil)
    }
    
    var dropDownStoryboard:UIStoryboard {
        return UIStoryboard(name: "DropDown", bundle: nil)
    }
}


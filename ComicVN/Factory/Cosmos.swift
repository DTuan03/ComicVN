//
//  Cosmos.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit
import Cosmos

class CosmosViewFactory {
    static func createCosmosView(starSize: CGFloat = 18, starMargin: CGFloat = 9, emptyImage: UIImage? = UIImage(named: "starEmpty"), updateOnTouch: Bool = false, filledImage: UIImage? = UIImage(named: "starFill"), emptyBorderColor: UIColor = .gray, filledBorderColor: UIColor = UIColor(hex: "#FFC107")) -> CosmosView {
        
        let cosmosView = CosmosView()
        
        cosmosView.settings.starSize = starSize
        cosmosView.settings.starMargin = starMargin
        cosmosView.settings.updateOnTouch = updateOnTouch
        cosmosView.settings.fillMode = .full
        cosmosView.settings.emptyImage = emptyImage
        cosmosView.settings.filledImage = filledImage
        cosmosView.settings.emptyBorderColor = emptyBorderColor
        cosmosView.settings.filledBorderColor = filledBorderColor
        
        return cosmosView
    }
}

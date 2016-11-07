//
// Created by Nickolay Sheika on 6/8/16.
//

import Foundation


internal protocol AnimationDataSource {
    func buildAnimation(forImage image: UIImage, viewPortSize: CGSize) -> ImageAnimation
}

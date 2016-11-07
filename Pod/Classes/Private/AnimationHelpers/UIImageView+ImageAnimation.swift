//
// Created by Nickolay Sheika on 6/11/16.
//

import Foundation
import UIKit
import CoreFoundation

extension UIImageView {

    // MARK: - Public

    func animate(withImageAnimation animation: ImageAnimation, completion: (() -> ())? = nil) {
        let imageStartTransform = transform(forImageState: animation.startState)
        let imageEndTransform = transform(forImageState: animation.endState)

        UIView.animateKeyframes(withDuration: animation.duration, delay: 0.0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.0) {
                self.transform = imageStartTransform
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                self.transform = imageEndTransform
            }
        }, completion: {
            finished in

            completion?()
        })
    }

    // MARK: - Helpers

    private func transform(forImageState imageState: ImageState) -> CGAffineTransform {
        let scaleTransform = CGAffineTransform(scaleX: imageState.scale, y: imageState.scale)
        let translationTransform = CGAffineTransform(translationX: imageState.position.x, y: imageState.position.y)
        let transform = scaleTransform.concatenating(translationTransform)
        return transform
    }
}

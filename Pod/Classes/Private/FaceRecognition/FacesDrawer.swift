//
// Created by Nickolay Sheika on 6/11/16.
//

import Foundation
import UIKit

protocol FacesDrawerProtocol {
    func drawFaces(inView: UIView, image: UIImage)
    func cleanUp(forView view: UIView)
}


class FacesDrawer: FacesDrawerProtocol {

    // MARK: - Public Variables

    var faceColor: UIColor = UIColor.red
    var faceAlpha: CGFloat = 0.2

    // MARK: - Private Variables

    private var facesViews = [Int: [UIView]]()

    // MARK: - Public

    func drawFaces(inView view: UIView, image: UIImage) {
        cleanUp(forView: view)
        DispatchQueue.global().async {
            let allFacesRects = image.allFacesRects()

            DispatchQueue.main.async {
                guard allFacesRects.count > 0 else {
                    return
                }

                self.facesViews[view.hashValue] = []

                let viewPortSize = view.bounds
                let imageCenter = CGPoint(x: viewPortSize.size.width / 2, y: viewPortSize.size.height / 2)
                let imageFrame = CGRect(center: imageCenter, size: image.size)

                for faceRect in allFacesRects {
                    let faceRectConverted = self.convert(faceRect: faceRect, inImageCoordinates: imageFrame.origin)

                    let faceView = self.buildFaceView(withFrame: faceRectConverted)
                    self.facesViews[view.hashValue]!.append(faceView)

                    view.addSubview(faceView)
                }
            }
        }
    }

    func cleanUp(forView view: UIView) {
        guard let facesForView = facesViews[view.hashValue] else {
            return
        }

        for faceView in facesForView {
            faceView.removeFromSuperview()
        }
        facesViews[view.hashValue] = nil
    }

    // MARK: - Private

    private func convert(faceRect: CGRect, inImageCoordinates imageOrigin: CGPoint) -> CGRect {
        let faceRectConvertedX = imageOrigin.x + faceRect.origin.x
        let faceRectConvertedY = imageOrigin.y + faceRect.origin.y
        let faceRectConverted = CGRect(x: faceRectConvertedX,
                                       y: faceRectConvertedY,
                                       width: faceRect.size.width,
                                       height: faceRect.size.height).integral
        return faceRectConverted
    }

    private func buildFaceView(withFrame frame: CGRect) -> UIView {
        let faceView = UIView(frame: frame)
        faceView.translatesAutoresizingMaskIntoConstraints = false
        faceView.backgroundColor = faceColor
        faceView.alpha = faceAlpha
        return faceView
    }
}

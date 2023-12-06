//
//  UIimage+data.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import UIKit

extension UIImage {
    func dataConvert(data: Data?) -> UIImage {
        guard let data, let uiImage = UIImage(data: data) else {
            return UIImage(systemName: "photo")!
        }

        return uiImage
    }
}

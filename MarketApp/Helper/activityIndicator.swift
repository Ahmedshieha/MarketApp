//
//  activityIndicator.swift
//  MarketApp
//
//  Created by MacBook on 07/03/2022.
//

import Foundation
import NVActivityIndicatorView


public var activityIndicator : NVActivityIndicatorView?


func showLoadingIndicator2 () {
    if activityIndicator != nil {
        activityIndicator?.startAnimating()
    }
}

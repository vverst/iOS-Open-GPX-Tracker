//
//  PreferencesTableViewControllerDelegate.swift
//  OpenGpxTracker
//
//  Created by merlos on 24/10/15.
//

import Foundation

///
/// Delegate protocol of the view controller that displays the list of tile servers
///
///
protocol PreferencesTableViewControllerDelegate: class {
    
    /// User updated tile server
    func didUpdateTileServer(_ newGpxTileServer: Int)
    
    /// User updated the usage of the caché
    func didUpdateUseCache(_ newUseCache: Bool)
    
    /// User update the usage of imperial units
    func didUpdateUseImperial(_ newUseImperial: Bool)
    
    /// User updated the desired accuracy
    func didUpdateDesiredAccuracy(_ newDesiredAccuracy: Double)
}

//
//  ALWebView.swift
//  ALWebView
//
//  Created by UnalCelik on 31.01.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import UIKit
import WebKit

public class ALWebView: WKWebView {
    
    /// Allowed base URLs to ALWebView to present. Do not fill with strings that most website adresses include! Ex: Adding "www." to this array, will allow loading of every website which includes "www." in their address.
    public var allowedBaseURLs: [String]?
    
    
    /// Loads ALWebView with the given url adress
    /// - Parameter urlString: URL address as string
    public func load(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        load(request)
    }
    
    
    /// Loads the HTML file from bundle in the ALWebView
    /// - Parameters:
    ///   - named: File name
    ///   - withExtension: File extension name
    public func loadHTMLFile(named: String, withExtension: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: withExtension) else { return }
        loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
    
    
    /// Takes plain HTML text and loads it in the ALWebView. If HTML string is referencing assets in your bundle such as images or CSS, you should specify isAssetsInBundle to true so they can be loaded.
    /// - Parameters:
    ///   - html: Plain HTML string
    ///   - isAssetsInBundle: Specify if the HTML assets are in the bundle.
    public func loadHTMLString(_ html: String, isAssetsInBundle: Bool) {
        let baseUrl = isAssetsInBundle ? Bundle.main.resourceURL! : nil
        loadHTMLString(html, baseURL: baseUrl)
    }
    
    
    /// Returns the visited urls as a string array. Default urls are for backward visited.
    /// - Parameter forForward: Specifies the returning array for backward or forward visited urls list.
    public func bringVisitedURLs(forForward: Bool = false) -> [String] {
        var visitedAddresses: [String] = []
        let addressList = forForward ? backForwardList.forwardList : backForwardList.backList
        
        addressList.forEach {
            visitedAddresses.append($0.url.absoluteString)
        }
        
        return visitedAddresses
    }
    
    
    
}

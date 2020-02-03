//
//  ALWebNavigationDelegate.swift
//  ALWebView
//
//  Created by UnalCelik on 31.01.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import Foundation
import WebKit

public protocol ALWebNavigationDelegate: WKNavigationDelegate {
    /// No extra methods for now.
}

extension ALWebNavigationDelegate {
    
    /*
        Check if requested url is in ALWebView's allowed URLs
    */
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let webView = webView as? ALWebView, let allowedURLs = webView.allowedBaseURLs else { return }
        
        if let host = navigationAction.request.url?.host {
            /// Check if host url is amongst the allowed URLs
            allowedURLs.forEach {
                if host.contains($0) {
                    decisionHandler(.allow)
                    return
                }
            }
        }

        decisionHandler(.cancel)
    }
    
    
    
}

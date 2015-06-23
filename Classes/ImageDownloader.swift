//
//  ImageDownloader.swift
//  
//  Created by Jijo A Pulikkottil on 27/05/15.
//  Copyright (c) 2015 Jijo A Pulikkottil. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject, NSURLSessionDelegate {
    
    
    
    private var session: NSURLSession!
    
    override init(){
        
        
        super.init()
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.HTTPMaximumConnectionsPerHost = 5
        
        self.session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        
    }
    
    func startDownload(ImageURL imageurlstr: String, completionHandler: ((dimage: UIImage?) -> Void)?) {
        
        
        let getImageTask : NSURLSessionDownloadTask = self.session.downloadTaskWithURL(NSURL(string: imageurlstr)!, completionHandler: { (locationURL, respose, error) -> Void in
            
            let data = NSData(contentsOfURL: locationURL)
            
            
            var image : UIImage?
            if data != nil {
                
                image = UIImage(data: data!)
            }
            
            if completionHandler != nil {
                
                completionHandler!(dimage: image)
            }
            
        })
        
        getImageTask.resume()
    }
    
    deinit{
        
        cancelAllDownloads()
        session = nil
    }
    
    func cancelAllDownloads(){
        
        session!.invalidateAndCancel()
    }
}

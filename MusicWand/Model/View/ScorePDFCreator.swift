//
//  ScorePDFCreator.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/02.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import UIKit
import PDFKit

class ScorePDFCreator: NSObject {
    func createScore() -> Data {
        
        let pdfMetaData = [
            kCGPDFContextCreator: "Music Score Builder",
            kCGPDFContextAuthor: "MusicWand"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            let text = "This is a MagicWand PDF test"
            let textRect = CGRect(x: 100, // left margin
                y: 100, // top margin
                width: 200,
                height: 20)
            text.draw(in: textRect, withAttributes: attributes)
        }
        
        
        return data
    }
    
}

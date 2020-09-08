//
//  TESTPDFVIEW.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/03.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import PDFKit

struct ScorePDFViewer: View {
    var url: URL
    
    var body: some View {
        PDFKitRepresentedView(url)
        
    }
}

struct ScorePDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFKitRepresentedView(Bundle.main.bundleURL.appendingPathComponent("sample.pdf"))
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
     
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
    }
}

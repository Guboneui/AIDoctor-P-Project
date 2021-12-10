//
//  String.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/11.
//

import Foundation

extension String {
    func htmlEscaped(font: UIFont, colorHex: String, lineSpacing: CGFloat) -> NSAttributedString {
        let style = """
                    <style>
                    p.normal {
                      line-height: \(lineSpacing);
                      font-size: \(font.pointSize)px;
                      font-family: \(font.familyName);
                      color: \(colorHex);
                    }
                    </style>
        """
        let modified = String(format:"\(style)<p class=normal>%@</p>", self)
        
        do {
            guard let data = modified.data(using: .unicode) else {
                return NSAttributedString(string: self)
            }
            let attributed = try NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: self)
        }
    }
    
    func htmlToAttributedString(font: UIFont, color: UIColor, lineHeight: CGFloat) -> NSAttributedString? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
            
        let _ = color.getRed(&red, green: &green, blue: &blue, alpha: nil)
            
        let rgb = "rgb(\(red * 255),\(green * 255),\(blue * 255))"
            
        let newLineHeight = lineHeight / font.pointSize
            
        let newHTML = String(format:"<span style=\"font-family: '-apple-system', '\(font.fontName)'; font-size: \(font.pointSize); color: \(rgb); line-height: \(newLineHeight);\">%@</span>", self)
            
        guard let data = newHTML.data(using: .utf8) else {
          return NSAttributedString()
        }
        
        do {
          return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
          return NSAttributedString()
        }
      }
  
}

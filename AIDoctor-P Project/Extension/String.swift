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
    
    
    // MARK: 자주 사용되는 기능들
    // ex. guard let email = emailTextField.text?.trim, email.isExists else { return }
    var isEmpty: Bool {
        return self.count == 0
    }
    var isExists: Bool {
        return self.count > 0
    }
    var trim: String? {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    // MARK: 다국어 지원 (localization)
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(with values: String...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), values)
    }
    
    
    // MARK: substring
    func substring(from: Int, to: Int) -> String {
        guard (to >= 0) && (from <= self.count) && (from <= to) else {
            return ""
        }
        let start = index(startIndex, offsetBy: max(from, 0))
        let end = index(start, offsetBy: min(to, self.count) - from)
        return String(self[start ..< end])
    }
    
    func substring(range: Range<Int>) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    
    // MARK: indexing
    func get(_ index: Int) -> String {
        return self.substring(range: index..<index)
    }
    
    
    // MARK: replace
    func replace(target: String, with withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: .literal, range: nil)
    }
    
    
    // MARK: comma
    // ex. "1234567890".insertComma == "1,234,567,890"
    var insertComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let _ = self.range(of: ".") {
            let numberArray = self.components(separatedBy: ".")
            if numberArray.count == 1 {
                var numberString = numberArray[0]
                if numberString.isEmpty {
                    numberString = "0"
                }
                guard let doubleValue = Double(numberString)
                    else { return self }
                return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
            } else if numberArray.count == 2 {
                var numberString = numberArray[0]
                if numberString.isEmpty {
                    numberString = "0"
                }
                guard let doubleValue = Double(numberString)
                    else {
                        return self
                }
                return (numberFormatter.string(from: NSNumber(value: doubleValue)) ?? numberString) + ".\(numberArray[1])"
            }
        }
        else {
            guard let doubleValue = Double(self)
                else {
                    return self
            }
            return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
        }
        return self
    }
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
  
}

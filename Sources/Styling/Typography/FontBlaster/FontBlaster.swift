import CoreGraphics
import CoreText
import Foundation
import OSLog

final public class FontBlaster {
    fileprivate enum SupportedFontExtensions: String {
        case TrueTypeFont = ".ttf"
        case OpenTypeFont = ".otf"
    }
    
    fileprivate typealias FontPath = String
    fileprivate typealias FontName = String
    fileprivate typealias FontExtension = String
    fileprivate typealias Font = (path: FontPath, name: FontName, ext: FontExtension)
    
    /// A list of the loaded fonts
    public static var loadedFonts: [String] = []
    
    /// Load all fonts found in a specific bundle. If no value is entered, it defaults to the main bundle.
    public class func blast(bundle: Bundle = Bundle.main) {
        blast(bundle: bundle, completion: nil)
    }
    
    /**
     Load all fonts found in a specific bundle. If no value is entered, it defaults to the main bundle.
     
     - returns: An array of strings containing the names of the fonts that were loaded.
     */
    public class func blast(bundle: Bundle = Bundle.main, completion handler: (([String])->Void)?) {
        let path = bundle.bundlePath
        loadFontsForBundle(withPath: path)
        loadFontsFromBundlesFoundInBundle(path: path)
        handler?(loadedFonts)
    }
}

// MARK: - Helpers (Font Loading)

private extension FontBlaster {
    /// Loads all fonts found in a bundle.
    ///
    /// - Parameter path: The absolute path to the bundle.
    final class func loadFontsForBundle(withPath path: String) {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path) as [String]
            let loadedFonts = fonts(fromPath: path, withContents: contents)
            if !loadedFonts.isEmpty {
                loadedFonts.forEach { font in
                    loadFont(font: font)
                }
            } else {
                os_log("No fonts were found in the bundle path: \(path).")
            }
        } catch let error as NSError {
            os_log("There was an error loading fonts from the bundle. \nPath: \(path).\nError: \(error)")
        }
    }
    
    /// Loads all fonts found in a bundle that is loaded within another bundle.
    ///
    /// - Parameter path: The absolute path to the bundle.
    final class func loadFontsFromBundlesFoundInBundle(path: String) {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path)
            contents.forEach { item in
                if let url = URL(string: path),
                   item.contains(".bundle") {
                    let urlPathString = url.appendingPathComponent(item).absoluteString
                    loadFontsForBundle(withPath: urlPathString)
                }
            }
        } catch let error as NSError {
            os_log("There was an error accessing bundle with path. \nPath: \(path).\nError: \(error)")
        }
    }
    
    /// Loads a specific font.
    ///
    /// - Parameter font: The font to load.
    final class func loadFont(font: Font) {
        let fontPath: FontPath = font.path
        let fontName: FontName = font.name
        let fontExtension: FontExtension = font.ext
        let fontFileURL = URL(fileURLWithPath: fontPath).appendingPathComponent(fontName).appendingPathExtension(fontExtension)
        
        var fontError: Unmanaged<CFError>?
        if let fontData = try? Data(contentsOf: fontFileURL) as CFData,
           let dataProvider = CGDataProvider(data: fontData) {
            
            guard let fontRef = CGFont(dataProvider) else {
                os_log("Failed to load font: '\(fontName)': fontRef is nil")
                return
            }
            
            if CTFontManagerRegisterGraphicsFont(fontRef, &fontError),
               let postScriptName = fontRef.postScriptName {
                os_log("Successfully loaded font: '\(postScriptName)'.")
                loadedFonts.append(String(postScriptName))
            } else if let fontError = fontError?.takeRetainedValue() {
                let errorDescription = CFErrorCopyDescription(fontError)
                os_log("Failed to load font '\(fontName)': \(String(describing: errorDescription))")
            }
        } else {
            guard let fontError = fontError?.takeRetainedValue() else {
                os_log("Failed to load font '\(fontName)'.")
                return
            }
            
            let errorDescription = CFErrorCopyDescription(fontError)
            os_log("Failed to load font '\(fontName)': \(String(describing: errorDescription))")
        }
    }
}

private extension FontBlaster {
    /// Parses all of the fonts into their name and extension components.
    ///
    /// - Parameters:
    ///     - path: The absolute path to the font file.
    ///     - contents: The contents of an Bundle as an array of String objects.
    ///
    /// - Returns: A an array of Font objects.
    final class func fonts(fromPath path: String, withContents contents: [String]) -> [Font] {
        os_log("\nScanning \(path) with contents: \n \(contents)")
        var fonts = [Font]()
        for fileName in contents {
            var parsedFont: (FontName, FontExtension)?
            
            if fileName.contains(SupportedFontExtensions.TrueTypeFont.rawValue) || fileName.contains(FontBlaster.SupportedFontExtensions.OpenTypeFont.rawValue) {
                parsedFont = font(fromName: fileName)
            }
            
            if let parsedFont = parsedFont {
                let font: Font = (path, parsedFont.0, parsedFont.1)
                fonts.append(font)
            }
            
            let fileURL = URL(fileURLWithPath: "\(path)/\(fileName)")
            let isDir = (
                try? fileURL.resourceValues(forKeys: [.isDirectoryKey]).isDirectory
            ) ?? false
            
            if isDir {
                let contents: [String] = (
                    try? FileManager.default.contentsOfDirectory(atPath: fileURL.path)
                ) ?? []
                let subDirFonts = Self.fonts(fromPath: fileURL.path,
                                             withContents: contents)
                fonts.append(contentsOf: subDirFonts)
            }
        }
        
        return fonts
    }
    
    /// Parses a font into its name and extension components.
    ///
    /// - Parameter name: The name of the font.
    ///
    /// - Returns: A tuple with the font's name and extension.
    final class func font(fromName name: String) -> (FontName, FontExtension) {
        let components = name.split{$0 == "."}.map { String($0) }
        return (components[0], components[1])
    }
}

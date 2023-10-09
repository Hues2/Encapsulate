import Foundation
import Compression

extension Data {
    func compressed() -> Data? {
        do {
            let compressedData = try (self as NSData).compressed(using: .lzfse)
            return Data(compressedData)
        } catch {
            print("Couldn't compress data \(error.localizedDescription)")
            return nil
        }
    }
    
    func decompressed() -> Data? {
        do {
            let deCompressedData = try (self as NSData).decompressed(using: .lzfse)
            return Data(deCompressedData)
        } catch {
            print("Couldn't de-compress data \(error.localizedDescription)")
            return nil
        }
    }
}

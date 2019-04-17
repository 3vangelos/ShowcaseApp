import Foundation
import RxSwift

struct FileHandler {
    private let fileSuffix = ".json"
    private let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    private func fileUrl(of file: String) -> URL? {
        return dir?.appendingPathComponent(file + fileSuffix)
    }
    
    func read<T: Codable>(from file: String) -> Observable<T> {
        return Observable<T>.create { o in
            do {
                let data = try Data(contentsOf: self.fileUrl(of: file)!, options: [])
                let decodedObject: T = try JSONDecoder().decode(T.self, from: data)
                o.onNext(decodedObject)
                o.onCompleted()
            } catch {
                o.onError(APIError.decoding)
            }
            
            return Disposables.create()
        }
    }
    
    func write(_ data: Data?, to file: String) {
        try? data?.write(to: self.fileUrl(of: file)!, options: [])
    }
}

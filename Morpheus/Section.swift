import Foundation

public protocol SectionType {
    typealias Row: RowType
    
    var rows: [Row] { get }
}

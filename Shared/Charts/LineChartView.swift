//
//  LineChartView.swift
//  BetterBudget
//
//  Created by Matt Marks on 12/13/20.
//

import SwiftUI



struct LineChartView: View {
    
    private var data: [CGPoint] = []
    private var minX: CGFloat
    private var maxX: CGFloat
    private var minY: CGFloat
    private var maxY: CGFloat
    private var colors: [Color]
    private var thickness: CGFloat
    
    init(data: [CGPoint], thickness: CGFloat = 7.0, colors: [Color] = [.orange, .pink]) {
        self.data = data.sorted(by: {$0.x < $1.x})
        self.minX = data.map({$0.x}).min() ?? 0
        self.maxX = data.map({$0.x}).max() ?? 0
        self.minY = data.map({$0.y}).min() ?? 0
        self.maxY = data.map({$0.y}).max() ?? 0
        self.thickness = thickness
        self.colors = colors
    
        // Normalize Data
        self.data = data.map({
            CGPoint(x: ($0.x - minX) / (maxX - minX),
                    y: ($0.y - minY) / (maxY - minY))
        })
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let width = geometry.size.width
            let height = geometry.size.height
            
            // Scale data for geometry.
            let scaledData = data.map({
                CGPoint(x: $0.x * width,
                        y: height - ($0.y * height))
            })
                        
            Path { path in
                
                for (i, datum) in scaledData.enumerated() {
                    if i == 0 {
                        path.move(to: CGPoint(x: datum.x, y: datum.y))
                    } else {
                        path.addLine(to: CGPoint(x: datum.x, y: datum.y))
                    }
                }
                
            }
            .stroke( LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
        }
        
    }
}


struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(data: [
            CGPoint(x: 1,  y: 10126),
            CGPoint(x: 2,  y: 9986),
            CGPoint(x: 3,  y: 8469),
            CGPoint(x: 4,  y: 11144),
            CGPoint(x: 5,  y: 10880),
            CGPoint(x: 6,  y: 10535),
            CGPoint(x: 7,  y: 9982),
            CGPoint(x: 8,  y: 13171),
            CGPoint(x: 9,  y: 13097),
            CGPoint(x: 10, y: 12282)
        ])
    }
}

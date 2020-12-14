//
//  DoughnutChartView.swift
//  BetterBudget
//
//  Created by Matt Marks on 12/13/20.
//

import SwiftUI

struct DoughnutChartView: View {
    
    @State private var hoveredSection: UUID = UUID()
    
    private var internalData: [InternalChartCellModel] = []
    private var startAngles: [Angle] = []
    private var endAngles: [Angle] = []
    
    init(data: [ChartCellModel]) {
        
        // Convert Values into Angles
        
        // First, we need the sum of all the values.
        let total = data.map({$0.value}).reduce(0, +)
        
        for datum in data {
            let start = internalData.last?.endAngle.degrees ?? 0
            let end = start + ((datum.value / total) * 360)
            let internalModel = InternalChartCellModel(
                chartCellModel: datum,
                startAngle: Angle(degrees: start),
                endAngle: Angle(degrees: end)
            )
            internalData.append(internalModel)
        }
    }
    
    
    var body: some View {
            
        GeometryReader { geometry in
            
            ZStack {
                ForEach(internalData, id: \.id) { datum in
                    Path { path in
                        path.addArc(
                            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
                            radius: 100,
                            startAngle: datum.startAngle,
                            endAngle: datum.endAngle,
                            clockwise: false)
                    }
                    .stroke(datum.color, lineWidth: 50)
                    .scaleEffect(hoveredSection == datum.id ? 1.1 : 1.0)
                    .animation(.default)
                    .gesture(TapGesture(count: 1).onEnded({
                        hoveredSection = datum.id
                    }))
                }
            }
            
            
        }
        
    }
}

struct ChartSection: Shape {
    
    let startAngle: Angle
    let endAngle: Angle
    let center: CGPoint
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addArc(
                center: center,
                radius: 100,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false)
        }
    }
    
}

struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let value: Double
    let name: String
}

fileprivate struct InternalChartCellModel: Identifiable {
    
    let id = UUID()
    let color: Color
    let value: Double
    let name: String
    let startAngle: Angle
    let endAngle: Angle
    
    init(chartCellModel: ChartCellModel, startAngle: Angle, endAngle: Angle) {
        self.color = chartCellModel.color
        self.value = chartCellModel.value
        self.name = chartCellModel.name
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}

struct DoughnutChartView_Previews: PreviewProvider {

    static var previews: some View {
        DoughnutChartView(data: [ChartCellModel(color: Color.red, value: 123, name: "Math"),
                                 ChartCellModel(color: Color.yellow, value: 233, name: "Physics"),
                                 ChartCellModel(color: Color.pink, value: 73, name: "Chemistry"),
                                 ChartCellModel(color: Color.blue, value: 731, name: "Litrature"),
                                 ChartCellModel(color: Color.green, value: 51, name: "Art")])
    }
}

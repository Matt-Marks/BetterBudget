//
//  BarChartView.swift
//  BetterBudget (iOS)
//
//  Created by Matt Marks on 12/13/20.
//

import SwiftUI

struct BarChartView: View {
    
    var data: [CGFloat] = []
    var colors: [Color] = [.orange, .pink]
    
    var body: some View {
        VStack {
            BarsView(data: data, colors: colors)
            HorizontalAxisView()
        }
        
    }
}

fileprivate struct BarsView: View {
    
    let spacing: CGFloat = 5
    
    var data: [CGFloat] = []
    var max: CGFloat
    var colors: [Color]
    
    init(data: [CGFloat], colors: [Color]) {
        self.data = data
        self.max = data.max() ?? 0
        self.colors = colors
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            let height = geometry.size.height
            let barWidth = (width - spacing * CGFloat(data.count - 1)) / CGFloat(data.count)
            
            HStack(alignment: .bottom, spacing: spacing) {
                ForEach(data, id: \.self) { datum in
                    BarView(colors: colors, label: datum.description)
                        .frame(width: barWidth, height: height * (datum / max))
                    
                }
            }
        }
    }
}

fileprivate struct BarView: View {
    
    @State private var hovered = false
    
    var colors: [Color]
    var label: String
    
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            
            RoundedRectangle(cornerRadius: width / 5)
                .fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom))
                .scaleEffect(hovered ? 1.04 : 1.0)
                .animation(.default)
                .onHover { isHovered in
                    self.hovered = isHovered
                }
                .popover(isPresented: $hovered) {
                    Text(label).padding()
                }
            
        }
        
    }
    
}

fileprivate struct HorizontalAxisView: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(height: 1)
        
    }
    
}


struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: [5,150,50,100,0,200,110,30,170,50]).padding()
    }
}

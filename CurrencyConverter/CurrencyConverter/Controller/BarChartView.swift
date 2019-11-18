//
//  ChartsView.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-16.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit
import Macaw

var coderObj:NSCoder?
class ChartsView: MacawView {
    
    static let palette = [0xf08c00, 0xbf1a04, 0xffd505, 0x8fcc16, 0xd1aae3].map { val in Color(val: val)}

    static var data: [Double] = [1.0,2.0,3.0,4.0,5.0]
    
    required init?(coder aDecoder: NSCoder) {
        coderObj = aDecoder
        let chart = ChartsView.createChart()
        super.init(node: Group(contents: [chart]), coder: aDecoder)
    }
    
    
    static func createChart() -> Group {
        var items: [Node] = []
        for i in 1...data.count {
            let y = 200 - Double(i) * 30.0
            items.append(Line(x1: -5, y1: y, x2: 275, y2: y).stroke(fill: Color(val: 0xF0F0F0)))
            items.append(Text(text: "\(i*30)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y)))
        }
        items.append(createBars())
        items.append(Line(x1: 0, y1: 200, x2: 275, y2: 200).stroke())
        items.append(Line(x1: 0, y1: 0, x2: 0, y2: 200).stroke())
        return Group(contents: items, place: .move(dx: 50, dy: 200))
    }
    
    
    static func createBars() -> Group {
        var items: [Node] = []
        for (i, item) in data.enumerated() {
            let bar = Shape(
                form: Rect(x: Double(i) * 50 + 25, y: 0, w: 30, h: item),
                fill: LinearGradient(degree: 90, from: palette[i], to: palette[i].with(a: 0.3)),
                place: .move(dx: 0, dy: -data[i]))
            items.append(bar)
        }
        return Group(contents: items, place: .move(dx: 0, dy: 200))
    }
    


}

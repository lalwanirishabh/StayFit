//
//  GraphView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI

struct GraphView: View {
    
    @EnvironmentObject var userData : ViewModel
    static let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
        
    }()
    
    let steps: [Step]

    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.2471546233, green: 0.4435939193, blue: 0.8302586079, alpha: 1)))
        .cornerRadius(10)
        .padding(10)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let steps = [
                   Step(count: 3452, date: Date())
               ]
        
        GraphView(steps: steps)
    }
}

//
//  InputView.swift
//  Budget
//
//  Created by yuuto takeuchi on 2024/07/26.
//

import SwiftUI

struct InputView: View {
    
    let today = Date()
    

//    let todayDC = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: today)
    var body: some View {
        Text("\(today)")
            .font(.title)
            .foregroundColor(.green)
    }
}


#Preview {
    InputView()
}

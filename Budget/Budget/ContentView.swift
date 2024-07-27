//
//  ContentView.swift
//  Budget
//
//  Created by yuuto takeuchi on 2024/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            InputView() //1枚目の子ビュー
                .tabItem {
                    Image(systemName: "pencil.line")
                    Text("入力")
                }
            CalendarView() //2枚目の子ビュー
                .tabItem {
                    Image(systemName: "calendar")
                    Text("カレンダー")
                }
            GraphView()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("グラフ")
                }
        }
    }
}



#Preview {
    ContentView()
}

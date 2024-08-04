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
            SettingView() //1枚目の子ビュー
                .tabItem {
                    Image(systemName: "gear")
                    Text("設定")
                }
        }
    }
}



#Preview {
    ContentView()
}

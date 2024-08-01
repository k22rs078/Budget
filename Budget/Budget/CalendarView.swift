//
//  CalendarView.swift
//  Budget
//
//  Created by yuuto takeuchi on 2024/07/26.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date() // 現在の表示日を管理
    
    let calendar = Calendar.current
    
    var daysOfWeek: [String] {
        calendar.shortWeekdaySymbols
    }
    
    var daysInMonth: [Int] {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        return Array(range)
    }
    
    
    var firstDayOfMonth: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
    }
    
    var firstDayWeekday: Int {
        calendar.component(.weekday, from: firstDayOfMonth) // 1 = Sunday, 2 = Monday, ...
    }
    
    var body: some View {
        VStack {
            // 月の表示とナビゲーションボタン
            HStack {
                Button(action: {
                    // 先月に移動
                    if let previousMonth = calendar.date(byAdding: .month, value: -1, to: currentDate) {
                        currentDate = previousMonth
                    }
                }) {
                    Text("<")
                        .font(.largeTitle)
                        .padding()
                }
                
                Spacer()
                
                Text("\(calendar.monthSymbols[calendar.component(.month, from: currentDate) - 1]) \(calendar.component(.year, from: currentDate))")
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // 翌月に移動
                    if let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentDate) {
                        currentDate = nextMonth
                    }
                }) {
                    Text(">")
                        .font(.largeTitle)
                        .padding()
                }
            }
            
            // 曜日のヘッダー
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .font(.subheadline)
                }
            }
            
            // 日付のグリッド
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 40)), count: 7), spacing: 10) {
                // 空白セルを表示して、月の始まりの位置を合わせる
                ForEach(0..<firstDayWeekday - 1, id: \.self) { a in
                    Rectangle()
                        .frame(height: 40) // 空白のサイズを設定
                        .opacity(0) // 完全に透明にする
                }
                
                // 現在の月の日付を表示
                ForEach(daysInMonth, id: \.self) { day in
//                    let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
//                    
//                    Text("\(day)")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .padding(10)
//                        .background(calendar.isDateInToday(date) ? Color.blue.opacity(0.5) : Color.green.opacity(0.3))
//                        .clipShape(Circle())
//                        .font(.title3)
//                        .foregroundColor(calendar.isDateInToday(date) ? .white : .black)
//                        .frame(height: 40) // 日付の高さを設定
                    let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
                    Button(action: {
                        
                    }, label: {
                        Text("\(day)")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(10)
                            .background(calendar.isDateInToday(date) ? Color.blue.opacity(0.5) : Color.green.opacity(0.3))
                            .clipShape(Circle())
                            .font(.title3)
                            .foregroundColor(calendar.isDateInToday(date) ? .white : .black)
                            .frame(height: 40) // 日付の高さを設定
                    })
                }
            }
            .padding()
        }
    }
}

#Preview {
    CalendarView()
}

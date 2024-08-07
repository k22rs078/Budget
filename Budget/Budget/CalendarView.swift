//
//  CalendarView.swift
//  Budget
//
//  Created by yuuto takeuchi on 2024/07/26.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var isEnabled = true //ボタンの有効/無効を管理するブール値
    @State private var int: Int? = nil //int をオプショナル型にして、初期値を nil に設定
    @State var int1: Int = 0
    @State private var currentDate = Date() // 現在の表示日を管理
    @State private var selectedDate: Date? = Date() //選択された日付を管理するための変数
    @State private var startDate = Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 1))!
    @State private var endDate = Calendar.current.date(from: DateComponents(year: 2026, month: 8, day: 15))!
    @State private var dateArray: [Date] = []
    @State private var dailyValues: [Date: [Int]] = [:]
    @State private var monthlyValues: [String: Int] = [:]
    @State private var yearValues: [String: Int] = [:]
    
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
        GeometryReader { geometry in
            VStack (spacing: 0){
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
                        let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
                        Button(action: {
                            selectedDate = date
                            if let amount = dailyValues[date] {
                                print("Selected date: \(dateFormatter.string(from: date)), Amount: \(amount)")
                            } else {
                                print("Selected date: \(dateFormatter.string(from: date)), Amount: 0")
                            }
                        }, label: {
                            Text("\(day)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(10)
                                .background(selectedDate == date ? Color.red.opacity(0.5) : (calendar.isDateInToday(date) ? Color.blue.opacity(0.5) : Color.green.opacity(0.3)))
                                .clipShape(Circle())
                                .font(.title3)
                                .foregroundColor(calendar.isDateInToday(date) ? .white : .black)
                                .frame(height: 40) // 日付の高さを設定
                        })
                    }
                }
                .padding()
                
                VStack(spacing: 0){
                    GroupBox{
                        TextField("金額", value: $int, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            if let date = selectedDate, let amount = int {
                                if dailyValues[date] == nil{
                                    dailyValues[date] = []
                                }
                                dailyValues[date]?.append(amount)
                                int = nil
                            }
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: geometry.size.width / 2, height: 50)
                                Text("収入")
                                    .frame(width: geometry.size.width / 2, height: 50)
                            }
                        })
                        .disabled((int ?? 0) <= 0) // isEnabledがfalseの場合にボタンを無効化
                        
                        Button(action: {
                            if let date = selectedDate, let amount = int {
                                if dailyValues[date] == nil{
                                    dailyValues[date] = []
                                }
                                dailyValues[date]?.append(-amount)
                                int = nil
                            }
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(width: geometry.size.width / 2, height: 50)
                                Text("支出")
                                    .frame(width: geometry.size.width / 2, height: 50)
                            }
                        })
                        .disabled((int ?? 0) <= 0)
                    }
                }
            }
            .onAppear{
                selectedDate = Date()
                currentDate = Date()
            }
        }
    }
}

// 日付フォーマットを定義
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    return formatter
}()

#Preview {
    CalendarView()
}


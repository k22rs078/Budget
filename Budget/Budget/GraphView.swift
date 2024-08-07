//
//  GraphView.swift
//  Budget
//
//  Created by yuuto takeuchi on 2024/07/26.
//

import SwiftUI

struct GraphView: View {
    @State private var startDate = Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 1))!
    @State private var endDate = Calendar.current.date(from: DateComponents(year: 2026, month: 8, day: 15))!
    @State private var dateArray: [Date] = []
    @State private var dateValues: [Date: Int] = [:]
    @State private var monthlyValues: [String: Int] = [:]
    @State private var yearValues: [String: Int] = [:]
    
    var body: some View {
        VStack {
            List {
//                Section(header: Text("Date List")) {
//                    ForEach(dateArray, id: \.self) { date in
//                        HStack {
//                            Text("\(date, formatter: dateFormatter)")
//                            Spacer()
//                            Text("\(dateValues[date] ?? 0)")
//                        }
//                    }
//                }
                
                Section(header: Text("Monthly Total Values")) {
                    ForEach(monthlyValues.keys.sorted(), id: \.self) { month in
                        HStack {
                            Text(month)
                            Spacer()
                            Text("\(monthlyValues[month] ?? 0)")
                        }
                    }
                }
                
                Section(header: Text("year Total Values")) {
                    ForEach(yearValues.keys.sorted(), id: \.self) { year in
                        HStack {
                            Text(year)
                            Spacer()
                            Text("\(yearValues[year] ?? 0)")
                        }
                    }
                }

            }
            .onAppear(perform: generateDates)
        }
    }
    
    func generateDates() {
        var currentDate = startDate
        dateArray.removeAll()
        dateValues.removeAll()
        monthlyValues.removeAll()
        
        while currentDate <= endDate {
            dateArray.append(currentDate)
            dateValues[currentDate] = Int.random(in: 1...100)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        // 月ごとに値を集計
        for (date, value) in dateValues {
            let monthString = dateFormatter.string(from: date).prefix(7) // "yyyy/MM"の形式にする
            if let existingValue = monthlyValues[String(monthString)] {
                monthlyValues[String(monthString)] = existingValue + value
            } else {
                monthlyValues[String(monthString)] = value
            }
        }
        
        for (date, value) in dateValues {
            let yearString = dateFormatter.string(from: date).prefix(4) // "yyyy/MM"の形式にする
            if let existingValue = yearValues[String(yearString)] {
                yearValues[String(yearString)] = existingValue + value
            } else {
                yearValues[String(yearString)] = value
            }
        }

    }
}

#Preview {
    GraphView()
}

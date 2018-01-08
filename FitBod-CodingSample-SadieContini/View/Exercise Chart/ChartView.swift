//
//  ChartView.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 1/5/18.
//  Copyright © 2018 sadiecontini. All rights reserved.
//

import UIKit
import Charts

class ChartView: CombinedChartView {

    struct Entry {
        var date: Date
        var value: Int
    }
    
    private var exercise: Exercise! {
        didSet {
            xAxisValueArray = createXAxisArray(for: exercise)
        }
    }
    
    // All xAxis values contained in array
    // Display labels created in extension for IAxisValueFormatter
    private var xAxisValueArray: [Date]!
    
    func setup(for exercise: Exercise) {
        self.exercise = exercise
        configureChartUI()
        setChartData()
    }
    
    func createEntryArray(for exercise: Exercise) -> [Entry] {
        var entryArray = exercise.workouts.map{Entry(date: $0.date, value: $0.oneRepMax())}
        entryArray = entryArray.sorted(by: { $0.date < $1.date })
        return entryArray
    }
    
    // Currently adds xaxis value for each workout date.
    // TODO: Make x axis have a space for every day --
    // so plotted graph will show there were days in between --
    // and make x axis labels show up weekly.
    func createXAxisArray(for exercise: Exercise) -> [Date] {
        var xAxisArray = exercise.workouts.map{$0.date}
        xAxisArray = xAxisArray.sorted(by: { $0 < $1 })
        return xAxisArray
    }
    
    private func setChartData() {
        let chartData = CombinedChartData()
        
        // Configure line chart data
        var dataSetArray = [IChartDataSet]()
        let exerciseEntryArray = createEntryArray(for: exercise)
        let lineDataSet = lineChartDataSet(entries: exerciseEntryArray)
        dataSetArray.append(configureLineChartDataSet(lineDataSet))
        chartData.lineData = LineChartData.init(dataSets: dataSetArray)
        
        xAxis.axisMaximum = chartData.xMax
        
        data = chartData
        data?.highlightEnabled = false
    }
    
    private func lineChartDataSet(entries: [Entry],
                              label: String = "") -> LineChartDataSet {
        var chartEntryArray = [ChartDataEntry]()
        for index in 0..<entries.count {
            let yValue = entries[index].value
            let chartEntry = ChartDataEntry.init(x: Double(index), y: Double(truncating: yValue as NSNumber))
            chartEntryArray.append(chartEntry)
        }
        let set = LineChartDataSet.init(values: chartEntryArray, label: label)
        set.fillAlpha = 1
        return set
    }
    
    // MARK: - Configure UI
    
    private func configureChartUI() {
        chartDescription?.enabled = false
        
        // draw order options for this combo chart:
        // bar, bubble, candle, line, scatter
        drawOrder = [DrawOrder.line.rawValue]
        
        drawGridBackgroundEnabled = false
        drawBarShadowEnabled = false
        highlightFullBarEnabled = true
        
        pinchZoomEnabled = false
        scaleXEnabled = false
        scaleYEnabled = false
        setScaleEnabled(false)
        
        legend.enabled = false
        
        rightAxis.drawGridLinesEnabled = false
        rightAxis.axisMinimum = 0.0
        rightAxis.drawLabelsEnabled = false
        rightAxis.drawAxisLineEnabled = false
        
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0.0
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawAxisLineEnabled = false
        
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 0.0
        xAxis.granularity = 1.0
        xAxis.valueFormatter = self
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelTextColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        xAxis.axisLineColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func configureLineChartDataSet(_ set: LineChartDataSet) -> LineChartDataSet {
        
        set.setColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        set.lineWidth = 1.0
        set.setCircleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        set.circleRadius = 3.0
        set.circleHoleRadius = 2.0
        set.circleHoleColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        set.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        set.mode = .linear;
        set.drawValuesEnabled = false
        set.valueFont = UIFont.systemFont(ofSize: 20)
        set.valueTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        set.axisDependency = .left
        
        return set
    }
}

// MARK: - IAxisValueFormatter (X Axis)

extension ChartView: IAxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String
    {
        let dateDisplayFormat = "MMM dd"
        if xAxisValueArray.count > 0 &&
            value >= 0 &&
            value < Double(xAxisValueArray.count)
        {
            let xAxisDate = xAxisValueArray[Int(value)]
            return xAxisDate.format(dateDisplayFormat)
        }
        return ""
    }
}

extension Date {
    func format(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}




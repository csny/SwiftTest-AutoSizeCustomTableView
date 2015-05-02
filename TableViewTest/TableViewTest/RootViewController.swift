//
//  RootViewController.swift
//  TableViewTest
//
//  Created by macbook on 2015/04/29.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

import UIKit

// セルのラベルに出力する変数
struct strctCellLabel {
    var bunsyou: String
    var hiduke: NSDate?
}

class RootViewController: UITableViewController {
    
    // インスタンス変数
    let textPoolArr: Array<String> = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sodales diam sed turpis mattis dictum. In laoreet porta eleifend. Ut eu nibh sit amet est iaculis faucibus.","initWithBitmapDataPlanes:pixelsWide:pixelsHigh:bitsPerSample:samplesPerPixel:hasAlpha:isPlanar:colorSpaceName:bitmapFormat:bytesPerRow:bitsPerPixel:", "祇辻飴葛蛸鯖鰯噌庖箸", "Nam in vehicula mi.", "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", "あのイーハトーヴォの\nすきとおった風、\n夏でも底に冷たさをもつ青いそら、\nうつくしい森で飾られたモーリオ市、\n郊外のぎらぎらひかる草の波。"]
    var outputArr:[strctCellLabel]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        // editボタンの設置
        navigationItem.leftBarButtonItem = self.editButtonItem()
        // addボタンの設置と動作
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "insertNewObject:")
        navigationItem.setRightBarButtonItem(addButton, animated: true)
        
        // UITableViewAutomaticDimensionはiOS8から
        // セルの高さの計算は Autolayout に任せる
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // addボタンの動作
    func insertNewObject(sender : AnyObject) {
        // データ作成
        var dataIndex: Int = Int(arc4random() % UInt32(textPoolArr.count))
        let str: String = textPoolArr[dataIndex]
        let date = NSDate()
        var tempstrct = (strctCellLabel(bunsyou: str, hiduke: date))
        // データ挿入
        outputArr.insert(tempstrct, atIndex: 0)
        
        // テーブルビュー更新
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Top)
    }
    
    // セルの行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outputArr.count
    }
    
    // セル描画
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // プロトタイプセルの特定
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        // メインラベルに文字列を設定
        cell.bodyLabel.text = outputArr[indexPath.row].bunsyou
        
        // サブラベルに文字列を設定
        let date: NSDate = outputArr[indexPath.row].hiduke!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分ss秒"
        cell.dateLabel.text = dateFormatter.stringFromDate(date)
        
        return cell
    }
    
    // セルの高さ見積もり、40という適当な数値を入れてる
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    // editモードの有無
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    // editモード時のボタンと動作
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // 配列の要素削除と表示セルの削除
            outputArr.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

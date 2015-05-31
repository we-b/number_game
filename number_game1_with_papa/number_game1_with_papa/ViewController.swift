
//
//  ViewController.swift
//  number_game1_with_papa
//
//  Created by Kim Yeonwoo on 2015/05/23.
//  Copyright (c) 2015年 Kim Yeonwoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        start()
        count = count + 1
        let btn_plus = calculateButton(1)
        btn_plus.center = CGPointMake(self.view.frame.width/5, self.view.frame.height/4*3)
        btn_plus.setTitle("+", forState: UIControlState.Normal)
        
        let btn_minus = calculateButton(2)
        btn_minus.center = CGPointMake(self.view.frame.width/5*2, self.view.frame.height/4*3)
        btn_minus.setTitle("-", forState: UIControlState.Normal)
        
        let btn_multiple = calculateButton(3)
        btn_multiple.center = CGPointMake(self.view.frame.width/5*3, self.view.frame.height/4*3)
        btn_multiple.setTitle("x", forState: UIControlState.Normal)
        
        let btn_division = calculateButton(4)
        btn_division.center = CGPointMake(self.view.frame.width/5*4, self.view.frame.height/4*3)
        btn_division.setTitle("÷", forState: UIControlState.Normal)
        
        let btn_number1 = configureButton(number1)
        btn_number1.center = CGPointMake(self.view.frame.width/8*3, self.view.frame.height/2)
        
        let btn_number2 = configureButton(number2)
        btn_number2.center = CGPointMake(self.view.frame.width/8*5, self.view.frame.height/2)
        
        let btn_number3 = configureButton(number3)
        btn_number3.center = CGPointMake(self.view.frame.width/4, (self.view.frame.height/2)-self.view.frame.width/3*2/4)
        
        let tensdigit = randomLabel(randomtendigit)
        tensdigit.center = CGPointMake(self.view.frame.width/2, (self.view.frame.height/2)-self.view.frame.width/3*2/4)
        
        let unitdigit = randomLabel(randomunitdigit)
        unitdigit.center = CGPointMake(self.view.frame.width/4*3, (self.view.frame.height/2)-self.view.frame.width/3*2/4)
        
        let btn_number4 = configureButton(number4)
        btn_number4.center = CGPointMake(self.view.frame.width/8*3, (unitdigit.center.y)-self.view.frame.width/3*2/4)
    
        let btn_number5 = configureButton(number5)
        btn_number5.center = CGPointMake(self.view.frame.width/8*5, (unitdigit.center.y)-self.view.frame.width/3*2/4)
    
        
        let btn_reload = UIButton()
        btn_reload.frame.size = CGSizeMake(50, 25)
        btn_reload.center = CGPointMake(self.view.frame.width/8*7, self.view.frame.height/16*13)
        btn_reload.backgroundColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 102/255.0, alpha: 1.0)
        btn_reload.setTitle(String("reset"), forState: UIControlState.Normal)
        btn_reload.addTarget(self, action: "reload:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn_reload)
        
        let btn_back = UIButton()
        btn_back.frame.size = CGSizeMake(50, 25)
        btn_back.center = CGPointMake(self.view.frame.width/8*7, self.view.frame.height/16*14)
        btn_back.backgroundColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 102/255.0, alpha: 1.0)
        btn_back.setTitle(String("back"), forState: UIControlState.Normal)
        btn_back.addTarget(self, action: "back:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn_back)
        
        let btn_ranking = UIButton()
        btn_ranking.frame.size = CGSizeMake(100, 25)
        btn_ranking.center = CGPointMake(self.view.frame.width/8*6, self.view.frame.height/8)
        btn_ranking.backgroundColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 102/255.0, alpha: 1.0)
        btn_ranking.setTitle(String("record"), forState: UIControlState.Normal)
        btn_ranking.addTarget(self, action: "push_ranking:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn_ranking)
        

////
////
//        let ud3 = NSUserDefaults.standardUserDefaults()
//        ud3.removeObjectForKey("time")


    
        // Do any additional setup after loading the view, typically from a nib.
        
      
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    乱数プロパティ
    var number1 = 0
    var number2 = 0
    var number3 = 0
    var number4 = 0
    var number5 = 0
    var randomtendigit = 0
    var randomunitdigit = 0
    
    
    
    var firstNumber = 0
    var secondNumber = 0
    var thirdNumber = 0
    var numbers_array:[CustomButton] = []
    var hidden_array:[CustomButton] = []
    var calculate_array: [NSArray] = []
    var result = 0
    var randomnumber_array = [0,0,0,0,0,0,0]
    var count = 0
    var answer_count = 0
    var starttime = NSDate()

    
//    乱数を作るか判断
    func start(){
        if count == 0{
        makenumber_check()}
    }
    
//    最初からやり直す
    func reload(sender :UIButton){
        for view in self.view.subviews {
            view.removeFromSuperview()}
            hidden_array.removeAll()
            calculate_array.removeAll()
            answer_count = 0
            numbers_array.removeAll()
            viewDidLoad()

    }
    
//    一回もどる
    func back(sender: UIButton){
        if calculate_array.count != 0{
        hidden_array.last?.hidden = false
            if calculate_array.last?[1].tag == 1{
                result = result - calculate_array.last![0].tag}
            else if calculate_array.last?[1].tag == 2{
                result = result + calculate_array.last![0].tag}
            else if calculate_array.last?[1].tag == 3{
                result = result / calculate_array.last![0].tag}
            else if calculate_array.last?[1].tag == 4{
                result = result * calculate_array.last![0].tag}
                var button = calculate_array.last![2] as! CustomButton
                button.setTitle(String(result), forState: UIControlState.Normal)
                button.tag = result
            for content in numbers_array{
                content.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
            calculate_array.removeAll()
            answer_count = answer_count - 1}
    }

    //    新しいゲームを始める
    func restart(sender: UIButton){
        for view in self.view.subviews {
            view.removeFromSuperview()}
        hidden_array.removeAll()
        calculate_array.removeAll()
        answer_count = 0
        numbers_array.removeAll()
        count = 0
        starttime = NSDate()
        viewDidLoad()
    }

    
//使う数字ボタン
    func configureButton(tag: Int)->CustomButton{
        let buttons = CustomButton()
        buttons.check = 1
        buttons.tag = tag
        buttons.frame.size = CGSizeMake(50, 50)
        buttons.backgroundColor = UIColor(red: 102 / 255.0, green: 255 / 255.0, blue: 102 / 255.0, alpha: 1.0)
        buttons.addTarget(self, action: "push:", forControlEvents: .TouchUpInside)
        buttons.setTitle(String(buttons.tag), forState: UIControlState.Normal)
        self.view.addSubview(buttons)
        return buttons
    }

// 作る数字ラベル
    func randomLabel(tag: Int) ->UILabel{
        let labels = UILabel()
        labels.tag = tag
        labels.frame.size = CGSizeMake(50, 50)
        labels.backgroundColor = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 102 / 255.0, alpha: 1.0)
        labels.textColor = UIColor.blackColor()
        labels.textAlignment = NSTextAlignment.Center
        labels.text = String(labels.tag)
        self.view.addSubview(labels)
        return labels

    }
    
//　四則演算ボタン
    func calculateButton(tag: Int) ->CustomButton{
        let buttons = CustomButton()
        buttons.check = 2
        buttons.tag = tag
        buttons.frame.size = CGSizeMake(50, 50)
        buttons.backgroundColor = UIColor(red: 102 / 255.0, green: 204 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        buttons.addTarget(self, action: "push:", forControlEvents: .TouchUpInside)
        self.view.addSubview(buttons)
        return buttons
    }
//ゲーム終了時メッセージ
    func endmessageLabel() ->UILabel{
        let labels = UILabel()
        labels.frame.size = CGSizeMake(100, 25)
        labels.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/7)
        labels.backgroundColor = UIColor(red: 255 / 255.0, green: 204 / 255.0, blue: 102 / 255.0, alpha: 1.0)
        labels.textColor = UIColor.whiteColor()
        labels.textAlignment = NSTextAlignment.Center
        self.view.addSubview(labels)
        return labels
    }
    
//    NEWGAMEボタン
    func newgameButton() -> UIButton{
        let btn_newgame = UIButton()
        btn_newgame.frame.size = CGSizeMake(100, 25)
        btn_newgame.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/5)
        btn_newgame.backgroundColor = UIColor.grayColor()
        btn_newgame.setTitle(String("New game"), forState: UIControlState.Normal)
        btn_newgame.addTarget(self, action: "restart:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn_newgame)
        return btn_newgame
    }
    
//    乱数を作るメソッド
    func makenumber_check(){
        var checkarray = RandomNumber().random_number_array
        var string = "0000000"
        
        while find(checkarray, string) != nil{
            makenumber()
            randomnumber_array = [number1, number2, number3, number4, number5]
            randomnumber_array.sort(){$0 < $1}
            randomnumber_array.append(randomtendigit)
            randomnumber_array.append(randomunitdigit)
            string = ""
            for number in randomnumber_array{
                string = string + String(number)
                
            }
        }

    }
    
    func makenumber(){
        number1 = Int(arc4random_uniform(UInt32(6))) + 1
        number2 = Int(arc4random_uniform(UInt32(6))) + 1
        number3 = Int(arc4random_uniform(UInt32(6))) + 1
        number4 = Int(arc4random_uniform(UInt32(6))) + 1
        number5 = Int(arc4random_uniform(UInt32(6))) + 1
        randomtendigit = Int(arc4random_uniform(UInt32(6))) + 1
        randomunitdigit = Int(arc4random_uniform(UInt32(6))) + 1

    }

//　数字ボタンを押して配列に入れる
    func push(sender: CustomButton) {
        numbers_array.append(sender)
        select()

    }

//計算するかどうかを決める
    func select(){
        if numbers_array[0].check == 1{
            self.numbers_array[0].setTitleColor(UIColor.blueColor(), forState: .Normal)
            if numbers_array.count >= 2{
                if numbers_array[1].check == 2{
                    self.numbers_array[1].setTitleColor(UIColor.blueColor(), forState: .Normal)
                    if numbers_array.count >= 3{
                        if numbers_array[2] != numbers_array[0] && numbers_array[2].check == 1{
                            self.numbers_array[2].setTitleColor(UIColor.blueColor(), forState: .Normal)
                            calculate()
                        }
                            
                        else{
                            for content in numbers_array{
                                content.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                            }
                            self.numbers_array.removeAll()
                        }
                    }
                }
                else{
                    for content in numbers_array{
                        content.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    }
                    self.numbers_array.removeAll()
                }
            }
        }
            
        else {
            for content in numbers_array{
                content.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
            self.numbers_array.removeAll()
        }
        
    }

//計算する
    func calculate(){
        calculate_array.removeAll()
        firstNumber = numbers_array[0].tag
        secondNumber = numbers_array[1].tag
        thirdNumber = numbers_array[2].tag
        if secondNumber == 1{
            result = firstNumber + thirdNumber
            process()
        }
        else if secondNumber == 2 && firstNumber - thirdNumber >= 0{
            result = firstNumber - thirdNumber
            process()
        }
        else if secondNumber == 3{
            result = firstNumber * thirdNumber
             process()
        }
        else if secondNumber == 4 && thirdNumber != 0 && firstNumber % thirdNumber == 0{
            result = firstNumber / thirdNumber
             process()
        }
        for content in numbers_array{
            content.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
        numbers_array.removeAll()
        answer()
        
    }
    
//   計算してからの動作
    func process(){
        calculate_array.append(numbers_array)
        answer_count = answer_count + 1
        hidden_array.append(numbers_array[0])
        numbers_array[0].hidden = true
        numbers_array[2].setTitle(String(result), forState: UIControlState.Normal)
        numbers_array[2].tag = result

    }
    
//　答え合わせ
    func answer(){

        if answer_count == 4{
            if randomtendigit*10 + randomunitdigit == result {
                right()
                save_time()
            }
            else{
                wrong()
            }
        }
    }

//    合っている時
    func right() ->NSTimeInterval {
        let rightlabel = endmessageLabel()
        let btn_gameover = newgameButton()
        let elapsed = NSDate().timeIntervalSinceDate(starttime)
        let minute = Int(elapsed / 60)
        let second = elapsed % 60
        let intSecond = Int(second)
        let floatSecond = Int((second - Double(intSecond)) * 100)
        
        rightlabel.text = String(format: "%02d:%02d.%02d", minute, intSecond, floatSecond)
        return elapsed
        
    }
    //　間違った時
    
    
    func wrong(){
        
        let wronglabel = endmessageLabel()
        
        wronglabel.text = "Try Again"
        
        let btn_gameover = newgameButton()
        
    }

    let array_time = NSUserDefaults.standardUserDefaults()
    var loadText:[Double] = []
     var time_to_rank_array :[String] = []
    
//   記録を保存
    func save_time(){
        
        let elapsed = right()
        if array_time.arrayForKey("time") == nil{
            loadText = [elapsed]
        }
        else{
            loadText = array_time.arrayForKey("time") as! [Double]
            loadText.append(elapsed)
        }
        array_time.setObject(loadText, forKey: "time")
        array_time.synchronize()
        show_time()
    }
    
//    記録を読み込む・sort
    func show_time() ->[Double]{
        if array_time.arrayForKey("time") != nil{
            loadText = array_time.arrayForKey("time") as! [Double]
        }
        loadText.sort(){$0 < $1}
        return loadText
    }
//    記録の表示を整える
    func time_to_rank(){
        loadText = show_time()
        for content in loadText{
            let minute = Int(content / 60)
            let second = content % 60
            let intSecond = Int(second)
            let floatSecond = Int((second - Double(intSecond)) * 100)
            time_to_rank_array.append(String(format: "%02d:%02d.%02d", minute, intSecond, floatSecond))
        }
    }
    
//    レコード表示
    var myTableView: UITableView!
    
//    レコード読み込み
    func push_ranking(sender: UIButton)  {
        time_to_rank()
        show_ranking()
    }
    
//    TableView形成
        func show_ranking(){
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height))
        
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
        
    }
    
//    セールの数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if time_to_rank_array.count < 10{
            return time_to_rank_array.count
        }
        else{
            return 10
        }
    }
//    セールの内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "myCell")
        cell.textLabel?.text = "\((indexPath.row)+1) "
        cell.detailTextLabel?.text = "\(time_to_rank_array[indexPath.row])"
        return cell
        
    }
    
    //セルの高さ
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    //セクションのタイトル
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ranking"
    }
    
    //セクションのタイトルの高さ
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
}





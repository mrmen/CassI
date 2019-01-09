//
//  ViewController.swift
//  CassI
//
//  Created by Thomas Etcheverria on 09/12/2018.
//  Copyright © 2018 Belette Team. All rights reserved.
//

import UIKit
import WebKit
import AudioToolbox

class ViewController: UIViewController, WKUIDelegate {

    
    let html_start = "<html><head><title>MathJax TeX Test Page</title><script type=\"text/javascript\" async  src=\"my-mathjax/MathJax.js?config=TeX-AMS_CHTML\"></script><script type=\"text/javascript\" src=\"my-mathjax/algebrite.bundle-for-browser.js\"></script><style>.boxed {border: 1px solid green ;}</style></head><body>  <div style=\"font-size: 40pt; color: black;\"><p id='demo'></p>";
    let html_end = "</div></body></html>";
    var content = "";
    var p_content = "";
    var from = "";
    var todo = "";
    var op = "";
    
    
    //Toolbar
    var tbAccessoryView : UIToolbar?
    
    @IBAction func AlgebriteRun(_ sender: Any) {
        content = field.text ?? ""
        if (content != ""){
            load_me(content: content)
        }
    }
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var web: WKWebView!
    
    @IBAction func clear(_ sender: Any) {
        p_content = ""
        content = ""
        field.text = ""
        load_me(content: content)
    }
    
    func performOperator(choosenOperator: String){
        var current = field.text ?? ""
        current = choosenOperator + "(" + current + ")"
        field.text = current
    }
    
    func load_me(content:String){
        if (content == ""){
            web.loadHTMLString("", baseURL: nil)
            //webview.loadHTMLString("", baseURL: baseURL)
            return
        }
        if (p_content != ""){
            p_content = "\"$$\"+"+"Algebrite.run(\"printlatex("+content+")\")"+"+\"$$</div>\"" + "+" + p_content
        }else{
            p_content = "\"$$\"+"+"Algebrite.run(\"printlatex("+content+")\")"+"+\"$$</div>\""
        }
        if (from != "from_simplify"){
            from = ""
            p_content = "\"<div class='boxed'>$$>"+content+"$$\" + "+p_content
        }else{
            var temp = content.replacingOccurrences(of: "expand(", with: "")
            temp.removeLast()
            p_content = "\"<div class='boxed'>$$ > "+temp+"$$\" + "+p_content
        }
        web.loadHTMLString(html_start + "<script  type=\"text/javascript\">document.getElementById('demo').innerHTML ="+p_content+"</script>" + html_end, baseURL: Bundle.main.bundleURL)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [
            UIBarButtonItem(title: "(", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.doIt)),
            space,
            UIBarButtonItem(title: ")", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.doIt)),
            space,
            UIBarButtonItem(title: "^", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.doIt)),
            space,
            UIBarButtonItem(title: "x", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.doIt)),
            space,
            UIBarButtonItem(title: "=", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.doIt)),
            space,
            UIBarButtonItem(title: "<", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.doIt)),
            space,
            UIBarButtonItem(title: ">", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.doIt))
            ]

        toolBar.sizeToFit()
        field.inputAccessoryView = toolBar
    }
    
    @objc func doIt(sender: UIBarButtonItem){
        let t = sender.title ?? ""
        AudioServicesPlaySystemSound(0x450)
        if (t == "<"){
            // only if there is a currently selected range
            if let selectedRange = field.selectedTextRange {
                // and only if the new position is valid
                if let newPosition = field.position(from: selectedRange.start, offset: -1) {
                    // set the new position
                    field.selectedTextRange = field.textRange(from: newPosition, to: newPosition)
                }
            }
        }
        else if (t == ">"){
            // only if there is a currently selected range
            if let selectedRange = field.selectedTextRange {
                // and only if the new position is valid
                if let newPosition = field.position(from: selectedRange.start, offset: 1) {
                    // set the new position
                    field.selectedTextRange = field.textRange(from: newPosition, to: newPosition)
                }
            }
        }
        else{
            field.insertText(t)
        }
    }
    
}




//
//  ViewController.swift
//  AppDojoTask2
//
//  Created by Naoyuki Kan on 2021/03/05.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet private weak var textField1: UITextField!
	@IBOutlet private weak var textField2: UITextField!
	@IBOutlet private weak var resultText: UILabel!
	@IBOutlet private weak var selectedSegment: UISegmentedControl!

	// 独自のエラー定義
	enum CalculationError: Error {
		case divisionByZero
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// 数字のみの入力とする設定
		textField1.keyboardType = .numberPad
		textField2.keyboardType = .numberPad
	}

	@IBAction func calButtonTap(_ sender: Any) {
		do{
			let resultSum = try _doCaluculation()
			resultText.text = String(resultSum)
		}catch let error as CalculationError{
			switch error {
			case .divisionByZero:
				print("0除算になっています")
				resultText.text = "割る数には0以外を入力して下さい"
			}
		}catch {
			print("")
		}
	}

	// 計算を行う関数
	private func _doCaluculation() throws -> Float{
		let value1 = Int(textField1.text!) ?? 0
		let value2 = Int(textField2.text!) ?? 0

		switch selectedSegment.selectedSegmentIndex {
		case 0: // 足算
			return Float(value1 + value2)
		case 1: // 引き算
			return Float(value1 - value2)
		case 2: // 掛け算
			return Float(value1 * value2)
		default: // 割り算
			// ゼロ除算になる場合にはエラーを投げる
			guard value2 != 0 else {
				throw CalculationError.divisionByZero
			}
			return Float(value1 / value2)
		}
	}
}


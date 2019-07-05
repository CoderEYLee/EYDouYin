//
//	EYCreator.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import YYModel

class EYCreator: NSObject{

	var birth : String?
	var descriptionField : String?
	var emotion : String?
	var gender : Int = 0
	var gmutex : Int = 0
	var hometown : String?
	var id : Int = 0
	var inke_verify : Int = 0
	var level : Int = 0
	var location : String?
	var nick : String?
	var portrait : String?
	var profession : String?
	var rankVeri : Int = 0
	var sex : Int = 0
	var third_platform : String?
	var veri_info : String?
	var verified : Int = 0
	var verified_reason : String?

    /// 重写 description 的计算型属性
    override var description: String {
        return yy_modelDescription()
    }
}

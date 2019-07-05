//
//	EYLive.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import UIKit
import YYModel

class EYLive: NSObject{

	var city : String?
    var creator : EYCreator?
//    var extra : EYExtra?
	var group : Int = 0
	var id : String?
	var image : String?
	var landscape : Int = 0
//    var like : [EYLike]?
	var link : Int = 0
	var live_type : String?
	var multi : Int = 0
	var name : String?
	var online_users : Int = 0
	var optimal : Int = 0
	var pub_stat : Int = 0
	var room_id : Int = 0
	var rotate : Int = 0
	var share_addr : String?
	var slot : Int = 0
	var status : Int = 0
	var stream_addr : String?
	var tag_id : String?
	var token : String?
	var version : Int = 0

    /// 重写 description 的计算型属性
    override var description: String {
        return yy_modelDescription()
    }

    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["like": EYLike.self]
    }
}

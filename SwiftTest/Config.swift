//
//  Config.swift
//  SwiftTest
//  本地配置
//  Created by 张琳 on 2017/7/18.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation

class Config: AnyObject {
    
    /**
     * 获得商品对应名称、背景图、slogan
     * @param itemID  商品ID
     */
    static func productByItemId(itemId:Int) ->Dictionary<String, String> {
        switch itemId {
        case 1:
            return ["itemName":"临时保洁","itemSlogan":"垃圾清理、全面去尘、玻璃清洁、房间打扫","icon_big":"richangbaojie_big","icon":"linshibaojie"]
        case 2:
            return ["itemName":"育儿嫂","itemSlogan":"辅食制作、婴儿陪护、早教益智、哼唱儿歌","icon_big":"yuersao_big","icon":"yuesao"]
        case 3:
            return ["itemName":"长期钟点工","itemSlogan":"日常保洁、买菜做饭、接送小孩、衣物整理","icon_big":"changqizhongdiangong_big","icon":"zhongdiangong"]
        case 4:
            return ["itemName":"保姆","itemSlogan":"日常保洁、买菜做饭、照顾小孩、护理老人","icon_big":"baomu_big","icon":"baomu"]
        case 5:
            return ["itemName":"月嫂","itemSlogan":"哺乳期催乳、月子餐、产后恢复、身型重塑","icon_big":"yuesao_big","icon":"yuesao"]
        case 6:
            return ["itemName":"老人陪护","itemSlogan":"日常保洁、保健按摩、买菜做饭、协助喂饭、外出散步","icon_big":"laorenpeihu_big","icon":"laorenpeihu"]
        case 10:
            return ["itemName":"新房开荒","itemSlogan":"玻璃擦洗、地砖处理、厨厕除污、装修痕迹清理、全面养护","icon_big":"xinfangkaihuang_big","icon":"xinfangkaihuang"]
        case 11:
            return ["itemName":"公司保洁","itemSlogan":"办公桌清洁、地面打扫、垃圾处理、厕所除污","icon_big":"gongsibaojie_big","icon":"gongsibaojie"]
        case 12:
            return ["itemName":"病人陪护","itemSlogan":"擦身清洁、协助饮食、协助方便、协助下床、保健按摩","icon_big":"bingrenpeihu_big","icon":"bingrenpeihu"]
        case 13:
            return ["itemName":"深度保洁","itemSlogan":"厨房保洁、卫生间保洁、除菌消毒、器具光亮","icon_big":"shenduqingjie_big","icon":"shendubaojie"]
        case 14:
            return ["itemName":"玻璃清洁","itemSlogan":"玻璃去污、玻璃擦洗、玻璃养护、玻璃修复","icon_big":"boliqingjie_big","icon":"boliqingjie"]
        case 15:
            return ["itemName":"其他保洁","itemSlogan":"除尘除螨、甲醛清理、沙发保养、地板打蜡","icon_big":"qitabaojie_big","icon":"shafabaoyang"]
        case 61:
            return ["itemName":"开荒保洁","itemSlogan":"玻璃擦洗、地砖处理、厨厕除污、装修痕迹清理、全面养护","icon_big":"xinfangkaihuang_big","icon":"xinfangkaihuang"]
        case 62:
            return ["itemName":"全面保洁","itemSlogan":"垃圾清理、全面去尘、玻璃清洁、房间打扫","icon_big":"richangbaojie_big","icon":"shendubaojie"]
        case 63:
            return ["itemName":"钟点保洁","itemSlogan":"日常保洁、买菜做饭、接送小孩、衣物整理","icon_big":"changqizhongdiangong_big","icon":"zhongdiangong"]
        case 64:
            return ["itemName":"玻璃保洁","itemSlogan":"玻璃去污、玻璃擦洗、玻璃养护、玻璃修复","icon_big":"boliqingjie_big","icon":"boliqingjie"]
        case 65:
            return ["itemName":"地板打蜡","itemSlogan":"地板除污、地板清洗、打蜡抛光、地板养护","icon_big":"dibandala_big","icon":"dibandala"]
        case 66:
            return ["itemName":"沙发洗护","itemSlogan":"沙发罩拆洗、真皮养护、除尘抑菌、金属件光亮","icon_big":"shafaxihu_big","icon":"shafabaoyang"]
        case 67:
            return ["itemName":"油烟机拆洗杀菌","itemSlogan":"油污去除、杀菌除臭、深度清洗、外壳光亮","icon_big":"youyanjichaixi_big","icon":"youyanjiqingxi"]
        case 68:
            return ["itemName":"空调拆洗杀菌","itemSlogan":"表面除尘、污垢清理、杀菌消毒、深度清洗","icon_big":"kongtiaochaixi_big","icon":"kongtiaochaixi"]
        case 69:
            return ["itemName":"冰箱除菌消除","itemSlogan":"外部清洗、内部除菌、除臭增香、外壳光亮","icon_big":"bingxiangchujun_big","icon":"bingxiangchaixi"]
        case 70:
            return ["itemName":"布艺除螨","itemSlogan":"除尘除螨、清洗去污、深层杀菌、美化增香","icon_big":"buyichuman_big","icon":"buyichuman"]
        case 71:
            return ["itemName":"美缝","itemSlogan":"缝隙清理、缝隙填充、美缝刮平、污渍清理","icon_big":"meifeng_big","icon":"meifeng"]
        case 72:
            return ["itemName":"管道疏通","itemSlogan":"管道清理、排堵疏通、消毒杀菌、污渍清扫","icon_big":"guandaoshutong_big","icon":"guandaoshutong"]
        case 73:
            return ["itemName":"地毯深层杀菌消毒","itemSlogan":"吸尘除污、清洗养护、深层杀菌、毛发清理","icon_big":"ditanshajun_big","icon":"ditanshencengshajun"]
        case 74:
            return ["itemName":"卫生间深层杀菌消毒","itemSlogan":"地面清扫、器具擦洗、油污去除、深层杀菌","icon_big":"weishengjian_big","icon":"weishengjianshenceng"]
        case 75:
            return ["itemName":"厨房深层杀菌消毒","itemSlogan":"地面清扫、厨具擦洗、厨房光亮、杀菌消毒","icon_big":"chufang_big","icon":"chufangshenceng"]
        case 101:
            return ["itemName":"自定义商品","itemSlogan":"专心服务、用心保证、随时响应、一站体验","icon_big":"richangbaojie_big","icon":"tybj"]
        default:
            return ["itemName":"自定义商品","itemSlogan":"专心服务、用心保证、随时响应、一站体验","icon_big":"richangbaojie_big","icon":"tybj"]
        }
    }
    
    
    /**
     * 获得阿姨语言技能
     * @param id  语言ID
     */
    static func language(id:Int) ->String {
        switch id {
        case 0:
            return "普通话"
        case 1:
            return "英语"
        case 2:
            return "德语"
        case 3:
            return "日语"
        case 4:
            return "韩语"
        case 5:
            return "四川话"
        case 6:
            return "上海话"
        case 7:
            return "东北话"
        case 8:
            return "广东话"
        case 9:
            return "客家话"
        case 10:
            return "闽南话"
        case 99:
            return "其他"
        default:
            return "其他"
        }
        
    }
    
    /**
     * 获得阿姨菜系
     * @param id  菜系ID
     */
    static func cuisine(id:Int) ->String {
        switch id {
        case 0:
            return "上海菜"
        case 1:
            return "浙江菜"
        case 2:
            return "川菜"
        case 3:
            return "粤菜"
        case 4:
            return "江苏菜"
        case 5:
            return "东北菜"
        case 6:
            return "鲁菜"
        case 7:
            return "潮州菜"
        case 8:
            return "湘菜"
        case 9:
            return "面食"
        case 10:
            return "西餐"
        case 11:
            return "海鲜"
        case 12:
            return "煲汤"
        case 99:
            return "其他"
        default:
            return "其他"
        }
        
    }
    
    /**
     * 获得阿姨教育程度
     * @param id  教育程度ID
     */
    static func education(id:Int) ->String {
        switch id {
        case 0:
            return "未上学"
        case 1:
            return "小学"
        case 2:
            return "初中"
        case 3:
            return "高中"
        case 4:
            return "中专"
        case 5:
            return "大专"
        case 6:
            return "本科"
        case 7:
            return "研究生"
        case 8:
            return "其他"
        default:
            return "其他"
        }
        
    }
    
    
    /**
     * 根据会员卡等级返回会员卡背景色
     * @param sort  会员卡级别
     */
    static func vipBackgroundColor(sort:Int?) ->String {
        
        if let sort = sort{
            
            switch sort {
            case 1:
                return "#78b966"
            case 2:
                return "#3f9266"
            case 3:
                return "#5bb2db"
            case 4:
                return "#418bbb"
            case 5:
                return "#5e86d4"
            case 6:
                return "#6d5a9b"
            case 7:
                return "#bb3c59"
            case 8:
                return "#e76352"
            case 9:
                return "#f7a52b"
            case 10:
                return "#f5c814"
            default:
                return "#78b966"
            }
            
        }else{
            return "#78b966"
        }
    }
    
    
}




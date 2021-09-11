//
//  TipsDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import Foundation

struct TipsDomain {
    
    enum TipsType {
        case mentalHealth
        case pregnancy
    }
    
    var id: String = UUID().uuidString
    var type: TipsType
    var title: String
    var description: String
    var url: String = ""
    
}

extension TipsDomain {
    
    static let tipsList: [TipsDomain] = [
        .init(type: .mentalHealth, title: "GINGER VS. NAUSEA", description: "consuming ginger may be an effective way to reduce nausea during pregnancy. Most experts consider ginger to be a safe, effective remedy during pregnancy"),
        .init(type: .mentalHealth, title: "STRETCH MARKS ARE FINE", description: "Pregnancy is one of the most common times when women notice stretch marks. If you do develop stretch marks during pregnancy, you may be glad to know that they will eventually fade. Over time, the red or pink color will mature into a pale silver or white color. You can work with your healthcare provider to find a diet and exercise plan that will help you avoid gaining too much while also giving you the nutrition you need to nourish yourself and your baby."),
        .init(type: .pregnancy, title: "KEGEL EXERCISES FOR PELVIC FLOOR", description: "These exercises can strengthen the pelvic floor muscles, which stretch during pregnancy and childbirth. If done correctly, Kegel can minimize stretching and make the muscles in your pelvic and vaginal area strong to assist during labor and to help minimize postpartum incontinence."),
        ]
    
}

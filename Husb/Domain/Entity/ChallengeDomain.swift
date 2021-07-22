//
//  ChallengeDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit


struct ChallengeDomain {
    
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var loveLanguage: LoveLanguageDomain
    var role: RoleDomain
    var steps: [ChallengeStepDomain] = []
    var isActive: Bool = false
    var funFact: FunFactDomain?
    var isCompleted: Bool = false
    var dueDate: Date?
    var addedDate: Date?
    var posterImage: UIImage?
    var momentImage: UIImage?
    
}

extension ChallengeDomain {
    
    @discardableResult
    mutating func update(with newObject: ChallengeDomain) -> ChallengeDomain {
        guard self.id == newObject.id else {
            return newObject
        }
        self.title = newObject.title
        self.description = newObject.description
        self.loveLanguage = newObject.loveLanguage
        self.role = newObject.role
        self.steps = newObject.steps
        self.isActive = newObject.isActive
        self.funFact = newObject.funFact
        self.posterImage = newObject.posterImage
        self.momentImage = newObject.momentImage
        return self
    }
    
}


extension ChallengeDomain {
    
    static let empty: ChallengeDomain = ChallengeDomain(
        title: "You Don't Have Any Current Challenges Yet",
        description: "Tap here to add new challenge or you can add it later in explore.",
        loveLanguage: .actOfService,
        role: .couple,
        posterImage: .noChallenge
    )
    
    static let actOfService: [ChallengeDomain] = [
        .init(
            id: "DRAW_HER_A_BUBBLE_BATH",
            title: "Draw Her a Bubble Bath",
            description: "Giving your partner a bubble bath can elevate your partner mood and can make you patrnet sleep better. If you put some romatic things also can improve your relationship with your partner.",
            loveLanguage: .actOfService,
            role: .hubby,
            steps: [
                .init(stepNumber: 1, description: "Buy a bubble bath bomb", isDone: false),
                .init(stepNumber: 2, description: "Get the warm water ready in the bathup", isDone: false),
                .init(stepNumber: 3, description: "Drop the bubble bomb in the water ", isDone: false),
                .init(stepNumber: 4, description: "Wait 1-3 minutes ", isDone: false),
                .init(stepNumber: 5, description: "Set up some candle if you want ", isDone: false),
                .init(stepNumber: 6, description: "Take your wife into the bath ", isDone: false)
            ],
            isActive: false,
            funFact: FunFactDomain(
                description: "Hot bath actually has a lot of medicinal benefits",
                url: "https://www.townandcountrymag.com/style/beauty-products/a18673205/hot-baths-benefits/"
            ),
            isCompleted: false,
            dueDate: nil,
            posterImage: .actsOfService,
            momentImage: nil
        ),
        // TODO: - Continue to add act of service challenge
    ]
    
    static let physicalTouch: [ChallengeDomain] = [
        .init(
            id: "MASSAGE_YOUR_WIFE",
            title: "Massage Your Wife",
            description: "Giving your partner regular massages you can help reduce the intensity, frequency and impact of stress and anxiety. You may also help to reduce heartburn, a common feature of pregnancy which can be exacerbated by stress, improve blood circulation (to raise red blood cell count and increase haemoglobin production), potentially even reducing the risk that she develops some form of iron deficiency.",
            loveLanguage: .physicalTouch,
            role: .hubby,
            steps: [
                .init(stepNumber: 1, description: "Get some massage oil (or body lotion if you don’t have any)", isDone: false),
                .init(stepNumber: 2, description: "Massage you wife", isDone: false),
                .init(stepNumber: 3, description: "Take a photo from the memorable moment", isDone: false),
            ],
            isActive: false,
            funFact: FunFactDomain(
                description: "Massage is known to stimulate the production of endorphins, the body’s in-built pain relief and mood-enhancing neurotransmitters.",
                url: "https://mybabymanual.co.uk/pregnancy/trimester-1/week-7/massage-your-pregnant-partner/"

            ),
            isCompleted: false,
            dueDate: nil,
            posterImage: .physicalTouch,
            momentImage: nil
        ),
        // TODO: - Continue to add physical touch challenge
    ]
    
    static let wordsOfAffirmation: [ChallengeDomain] = [
        .init(
            id: "WRITE_A_LOVE_LETTER",
            title: "Write a Love Letter",
            description: "Specify our emotions and celebrate our passion for life with a deeper understanding of our partner. Get a cathartic release of words that have been suppressed like buried treasure.",
            loveLanguage: .wordsOfAffirmation,
            role: .hubby,
            steps: [
                .init(stepNumber: 1, description: "Prepare your tools (Piece of paper, Pen) If you want to be fancy. Prepare with different colors", isDone: false),
                .init(stepNumber: 2, description: "First comes from the hearth like recall a romantic memory", isDone: false),
                .init(stepNumber: 3, description: "Just say it in your way, how much you love her & she means to you", isDone: false),
                .init(stepNumber: 4, description: "Send it without thinking", isDone: false),
                .init(stepNumber: 5, description: "Take a photo of your wife with your love letter", isDone: false)
            ],
            isActive: false,
            funFact: FunFactDomain(
                description: "Your love letter may not be the most perfect one ever written. But as long as it comes from you, and is sincere, it will be perfect in the eyes of the person who receives it. And in affairs of the heart, that's all that matters.",
                url: "https://www.thespruce.com/how-to-write-a-love-letter-3489978"

            ),
            isCompleted: false,
            dueDate: nil,
            posterImage: .wordsOfAffirmation,
            momentImage: nil
        ),
        // TODO: - Continue to add words of affirmation challenge
    ]
    
    static let qualityTime: [ChallengeDomain] = [
        .init(
            id: "ROMANTIC_DINNER",
            title: "Romantic Dinner",
            description: "Set up a romantic dinner with your wife. A dinner can be romantic even without candles or wine. It's the thought that counts!",
            loveLanguage: .qualityTime,
            role: .hubby,
            steps: [
                .init(stepNumber: 1, description: "It doesn't have to be anything fancy (unless you know for sure she likes it fancy)", isDone: false),
                .init(stepNumber: 2, description: "Make it light and healthy", isDone: false),
                .init(stepNumber: 3, description: "Make it apparent that time, effort, and consideration went into the whole thing (from the whole set up to the food)", isDone: false),
                .init(stepNumber: 4, description: "Being together is the most important thing ", isDone: false),
                .init(stepNumber: 5, description: "Capture the memorable moment!", isDone: false)
            ],
            isActive: false,
            funFact: FunFactDomain(
                description: "Dinner dates are important, fun and enjoyable for couples! It also brings you back to your first date.",
                url: "https://www.elitedaily.com/dating/dinner-dates-healthy/988534"

            ),
            isCompleted: false,
            dueDate: nil,
            posterImage: .qualityTime,
            momentImage: nil
        ),
        // TODO: - Continue to add quality time challenge
    ]
    
    static let givingGifts: [ChallengeDomain] = [
        .init(
            id: "SURPRISE_PACKAGE",
            title: "Surprise Package",
            description: "Giving gifts to people can actually improve your relationship with them and bring them closer to you. It doesn’t matter how big or small the gift is, the essence of a gift is such that it cannot be measured in monetary value if given with honesty and out of love.",
            loveLanguage: .givingGifts,
            role: .hubby,
            steps: [
                .init(stepNumber: 1, description: "Buy something meaningful for her (or you can make one)", isDone: false),
                .init(stepNumber: 2, description: "Wrap it nicely", isDone: false),
                .init(stepNumber: 3, description: "Give it to your wife", isDone: false),
                .init(stepNumber: 4, description: "Capture the memorable moment!", isDone: false)
            ],
            isActive: false,
            funFact: FunFactDomain(
                description: "Gift giving is said to strengthen the bond between two people. It shows that you value the person in your life and care for their happiness",
                url: "https://luxurylifestyle.com/headlines/benefits-of-giving-gifts-to-loved-ones.html"

            ),
            isCompleted: false,
            dueDate: nil,
            posterImage: .givingGifts,
            momentImage: nil
        ),
        // TODO: - Continue to add giving gifts challenge
    ]
    
    static let allChallenges = ChallengeDomain.actOfService+ChallengeDomain.givingGifts+ChallengeDomain.physicalTouch+ChallengeDomain.qualityTime+ChallengeDomain.wordsOfAffirmation
    
    
    static let simpleThings: [ChallengeDomain] = [
        .init(
            id: "NIGHT_TIME_CUDDLE",
            title: "Night Time Cuddle",
            description: "",
            loveLanguage: .physicalTouch,
            role: .hubby,
            steps: [],
            isActive: false,
            funFact: nil,
            isCompleted: false,
            dueDate: nil,
            posterImage: .simpleThingsNightTimeCuddle,
            momentImage: nil
        ),
        .init(
            id: "GIVE_HER_HUGS",
            title: "Give Her Hugs",
            description: "",
            loveLanguage: .physicalTouch,
            role: .hubby,
            steps: [],
            isActive: false,
            funFact: nil,
            isCompleted: false,
            dueDate: nil,
            posterImage: .simpleThingsGiveHerAHug,
            momentImage: nil
        ),
        .init(
            id: "GUVE_HER_A_KISS",
            title: "Give Her a Kiss",
            description: "",
            loveLanguage: .physicalTouch,
            role: .hubby,
            steps: [],
            isActive: false,
            funFact: nil,
            isCompleted: false,
            dueDate: nil,
            posterImage: .simpleThingsGiveHerAKiss,
            momentImage: nil
        ),
    ]
}

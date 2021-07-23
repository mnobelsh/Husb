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
            .init(
                id: "MAKE_MORNING_TEA_FOR_HER",
                title: "Make Morning Tea For Her",
                description: "It is a nice, warm morning with the sun shining bright, and you wake up to finally begin your day with a hot cup of bed tea. it actually gives you a much better boost in the morning.",
                loveLanguage: .actOfService,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Boil water in a pot. Make sure the water is hot enough to smoulder the sexists who pass comments such as, “Why do you have a job? You should be home taking care of your family.”", isDone: false),
                    .init(stepNumber: 2, description: "Choose your desired flavour of tea. Here, you have the option of choosing from an assortment of flavours, unlike real life, where no matter what you do, you will end up married off to a mama's boy who probably can't even pour himself a glass of water.", isDone: false),
                    .init(stepNumber: 3, description: "Pour the hot water into a cup with the tea bag and let it soak", isDone: false),
                    .init(stepNumber: 4, description: "Serve the tea with some milk and sugar and a side of advice on how not to be a pathetic human being. ", isDone: false)
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "The right morning beverage can do wonders in terms of rehydrating you after sleeping for several hours, and it can also get the brain going, helping to set the tone for a productive day such as : Clears The Morning Brain Fog, A Better Source Of Caffeine, Gives Your Metabolism A Boost, Helps Recovery After A Workout, Regulates Blood Sugar For Diabetics, Reduces Intestinal Inflammation",
                    url: "https://www.letsdrinktea.com/benefits-of-drinking-tea-in-the-morning/"
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
            .init(
                id: "SILLY_KISSES",
                title: "Silly Kisses",
                description: "Kissing is intimate: You're right there in the space of your soul. It gets to the core of your heart and spirit because it's such a lovely way to express and receive love and affection. A kiss a day really can keep the doctor away.",
                loveLanguage: .physicalTouch,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Find a new way for a kiss", isDone: false),
                    .init(stepNumber: 2, description: "Try it with your partner", isDone: false),
                    .init(stepNumber: 3, description: "Capture the moment", isDone: false),
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "Kissing amps up your happy hormone. It will relax, restore and revitalize you....The feel-good chemicals in the brain get percolating: serotonin, dopamine, oxytocin",
                    url: "https://edition.cnn.com/2014/01/14/health/upwave-kissing/index.html"

                ),
                isCompleted: false,
                dueDate: nil,
                posterImage: .physicalTouch,
                momentImage: nil
            ),
            .init(
                id: "HOLDING_HANDS",
                title: "Holding Hands",
                description: "Holding hands with your significant other decrease the level of stress hormone called cortisol. Even the touch of a friend or a teammate can make us feel more content, connected, or better about ourselves. When we are stressed out, a light touch on our hand can help ease the strain, both physically and mentally.",
                loveLanguage: .physicalTouch,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Say that you got a magic trick to make her feel better", isDone: false),
                    .init(stepNumber: 2, description: "ask for a hand", isDone: false),
                    .init(stepNumber: 3, description: "hold her hand", isDone: false),
                    .init(stepNumber: 3, description: "Capture your magic trick", isDone: false),
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "Oxytocin is the hormone behind this benefit. Oxytocin strengthens empathy and communication between partners in a relationship, which is proven to be a contributing factor for long-lasting, happy relationships. Holding hands with your partner will improve your relationship and create a bond that will impact the quality of your relationship significantly.",
                    url: "https://www.lifehack.org/355489/study-discovers-7-surprising-benefits-holding-hands"

                ),
                isCompleted: false,
                dueDate: nil,
                posterImage: .physicalTouch,
                momentImage: nil
            ),
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
            .init(
                id: "STICKY_NOTES",
                title: "Surprise Sticky Notes",
                description: "Leave your partner a sticky notes with words that make your partner day better",
                loveLanguage: .wordsOfAffirmation,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Get a sticky notes & pen tools", isDone: false),
                    .init(stepNumber: 2, description: "Write some sweet notes! Dont for get to say how much you love your partner!", isDone: false),
                    .init(stepNumber: 3, description: "Put it in the mirror! (It can be fridge, bathroom, etc)", isDone: false),
                    .init(stepNumber: 4, description: "Send it without thinking", isDone: false),
                    .init(stepNumber: 5, description: "Take a photo of your Notes", isDone: false)
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "Hidden love notes are an easy way to show your loved one that you are thinking about them by bringing a surprise to their heart and smile to their face at unexpected times.",
                    url: "https://holidappy.com/greeting-cards/Love-Notes-For-Your-Spouse"

                ),
                isCompleted: false,
                dueDate: nil,
                posterImage: .wordsOfAffirmation,
                momentImage: nil
            ),
            .init(//BELOMASDASDDSA
                id: "SURPRISE_PHONE_CALL",
                title: "Surprise Sticky Notes",
                description: "Leave your partner a sticky notes with words that make your partner day better",
                loveLanguage: .wordsOfAffirmation,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Get a sticky notes & pen tools", isDone: false),
                    .init(stepNumber: 2, description: "Write some sweet notes! Dont for get to say how much you love your partner!", isDone: false),
                    .init(stepNumber: 3, description: "Put it in the mirror! (It can be fridge, bathroom, etc)", isDone: false),
                    .init(stepNumber: 4, description: "Send it without thinking", isDone: false),
                    .init(stepNumber: 5, description: "Take a photo of your Notes", isDone: false)
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "Hidden love notes are an easy way to show your loved one that you are thinking about them by bringing a surprise to their heart and smile to their face at unexpected times.",
                    url: "https://holidappy.com/greeting-cards/Love-Notes-For-Your-Spouse"

                ),
                isCompleted: false,
                dueDate: nil,
                posterImage: .wordsOfAffirmation,
                momentImage: nil
            ),
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
            .init(
                id: "COUPLE_DANCE",
                title: "Do A Couple Dance",
                description: "Dancing! Anyone can dance! It doesn't have to be a formal romantic dance, even a goofy fun weird dance doesn't matter as long as it's together!",
                loveLanguage: .qualityTime,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Clear some space for you and your partner to move around", isDone: false),
                    .init(stepNumber: 2, description: "Choose the music you and your partner would love to dance to (from slow soft songs to jumpy and fun ones)", isDone: false),
                    .init(stepNumber: 3, description: "Make the first move, your wife might feel shy", isDone: false),
                    .init(stepNumber: 4, description: "Be careful of large excessive movements (especially when your wife is farther along in her pregnancy)", isDone: false),
                    .init(stepNumber: 5, description: "Capture the memorable moment!", isDone: false)
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "How can dancing bring you closer with your soulmate? Dancing together allows couples to physically reconnect. It also integrates several brain functions at once—kinesthetic, rational, musical and emotional—further increasing your neural connectivity. Dance also builds trust. Most importantly, it's fun! Dancing could be a way to break out of you and your soulmate's comfort zone and explore a new activity together.",
                    url: "https://www.mydomaine.com/dance-with-spouse-connecting-in-marriage-2302967"

                ),
                isCompleted: false,
                dueDate: nil,
                posterImage: .qualityTime,
                momentImage: nil
            ),
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
            .init(
                id: "BRING HER FAVORITE FLOWER",
                title: "Surprise Package",
                description: "Flowers have long been a symbol of love and care and while you might find people who say that flowers wither and they aren’t so important, one can’t deny the role flowers play in our daily lives and how important they are. Everyone cares in one way or the other.",
                loveLanguage: .givingGifts,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Search for her favorite flower", isDone: false),
                    .init(stepNumber: 2, description: "Buy the best one you can find", isDone: false),
                    .init(stepNumber: 3, description: "Make it presentable & Give it to her", isDone: false),
                    .init(stepNumber: 4, description: "Capture the memorable moment!", isDone: false)
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "Sometimes words can’t say it all and this is when flowers can bring warmth and comfort in someone’s lives. Considering sending flowers to anyone who requires some sort of emotional support right now and see how it’ll boost their morale and bring positivity in their lives.",
                    url: "https://www.lifehack.org/386311/the-8-best-reasons-send-flowers-your-loved-ones"

                ),
                isCompleted: false,
                dueDate: nil,
                posterImage: .givingGifts,
                momentImage: nil
            ),
            .init(
                id: "PRINT_AND_FRAME_HER_FAVORITE_PHOTO_OF_THE_MOMENT",
                title: "Frame Her Favourite Photo Of The Moment",
                description: "Capturing a moment in time isn't just about securing a memory—it can help you appreciate your life more every day.",
                loveLanguage: .givingGifts,
                role: .hubby,
                steps: [
                    .init(stepNumber: 1, description: "Find her favorite photo", isDone: false),
                    .init(stepNumber: 2, description: "Print it (make sure it’s not blurry)", isDone: false),
                    .init(stepNumber: 3, description: "Buy the frame & Frame it", isDone: false),
                    .init(stepNumber: 3, description: "Give it to your special one", isDone: false),
                    .init(stepNumber: 4, description: "Capture the memorable moment!", isDone: false)
                ],
                isActive: false,
                funFact: FunFactDomain(
                    description: "Having photos of things you love gives you the satisfaction of doing that.",
                    url: "https://www.goodhousekeeping.com/health/wellness/advice/a18949/take-more-pictures/"

                ),
                isCompleted: false,
                dueDate: nil,
                posterImage: .givingGifts,
                momentImage: nil
            ),
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

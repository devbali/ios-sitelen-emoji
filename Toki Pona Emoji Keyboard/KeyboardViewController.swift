//
//  KeyboardViewController.swift
//  Toki Pona Emoji Keyboard
//
//  Created by Dev Bali on 01/05/20.
//  Copyright © 2020 Awara Badal Developments. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBOutlet var q: UIButton!
    @IBOutlet var w: UIButton!
    @IBOutlet var e: UIButton!
    @IBOutlet var r: UIButton!
    @IBOutlet var t: UIButton!
    @IBOutlet var y: UIButton!
    @IBOutlet var u: UIButton!
    @IBOutlet var i: UIButton!
    @IBOutlet var o: UIButton!
    @IBOutlet var p: UIButton!
    @IBOutlet var a: UIButton!
    @IBOutlet var s: UIButton!
    @IBOutlet var d: UIButton!
    @IBOutlet var f: UIButton!
    @IBOutlet var g: UIButton!
    @IBOutlet var h: UIButton!
    @IBOutlet var j: UIButton!
    @IBOutlet var k: UIButton!
    @IBOutlet var l: UIButton!
    @IBOutlet var z: UIButton!
    @IBOutlet var x: UIButton!
    @IBOutlet var c: UIButton!
    @IBOutlet var v: UIButton!
    @IBOutlet var b: UIButton!
    @IBOutlet var n: UIButton!
    @IBOutlet var m: UIButton!
    @IBOutlet var colon: UIButton!
    @IBOutlet var space: UIButton!
    @IBOutlet var period: UIButton!
    
    @IBOutlet var suggestion1: UIButton!
    @IBOutlet var suggestion2: UIButton!
    @IBOutlet var suggestion3: UIButton!
    

    func resetCaps () {
        for key in alphabets {
            let title = key.title(for: []) ?? ""
            key.setTitle(title.lowercased(), for: [])
        }
        upperrn = false
    }

    @IBAction func capspress(_ sender: UIButton) {
        upperrn = !upperrn
        for key in alphabets {
            let title = key.title(for: [])
            if upperrn {
                key.setTitle(title!.uppercased(), for: [])
            } else {
                key.setTitle(title!.lowercased(), for: [])
            }
        }
    }

    @objc func alphabetpress(_ sender: UIButton) {
        proxy.insertText(sender.currentTitle ?? " ")
        updatebuffer()
    }

    @IBAction func colonpress(_ sender: Any) {
        collapsebuffer()
        proxy.insertText("➗️")
    }
    
    @IBAction func enterpress(_ sender: Any) {
        collapsebuffer()
        proxy.insertText("\n")
    }

    @IBAction func spacepress(_ sender: Any) {
        if !collapsebuffer() {
            proxy.insertText(" ")
        }
    }

    @IBAction func uspress(_ sender: Any) {
        collapsebuffer()
        proxy.insertText("🔣")
    }
    @IBAction func backpress(_ sender: Any) {
        proxy.deleteBackward()
        updatebuffer()
    }
    
    @IBAction func periodpress(_ sender: Any) {
        collapsebuffer()
        proxy.insertText("➖️")
    }

    @IBAction func s1press(_ sender: Any) {
        collapsebuffer()
    }
    @IBAction func s2press(_ sender: Any) {
        collapsebuffer(i: 1)
    }
    @IBAction func s3press(_ sender: Any) {
        collapsebuffer(i: 2)
    }
    
    
    var proxy: UITextDocumentProxy!
    var heightConstraint: NSLayoutConstraint!
    var alphabets: [UIButton]!
    var keys: [UIButton]!
    var suggestions: [UIButton]!

    var upperrn: Bool = false
    var capsmode: Bool = false
    var buffer: String = ""
    
    let alphs : [Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var upperalphs: [Character] = []
    
    let words = ["mi","li","e","toki","pona","ni","a","la","ala","sina","lon","jan","tawa","pi","sona","tenpo",
        "ona","wile","mute","taso","o","kama","ken","pilin","nimi","ike","lili","tan","tomo","pali","ma",
        "sitelen","kepeken","musi","jo","moku","lukin","sama","telo","lape","seme","kin","ilo","ale","pini",
        "ante","suli","ijo","anu","nasa","kulupu","suno","pana","kalama","lipu","tu","nasin","sin","pakala",
        "en","wawa","olin","lawa","awen","sewi","seli","kon","soweli","weka","mu","wan","ali","lete","sike",
        "nanpa","kasi","moli","kute","suwi","utala","pimeja","mama","sijelo","pan","luka","uta","open","ko",
        "jaki","kala","pu","insa","esun","kili","poka","mani","len","linja","meli","kiwen","poki","supa",
        "kule","mije","waso","walo","pipi","palisa","anpa","noka","akesi","loje","mun","nena","unpa",
        "sinpin","selo","monsi","jelo","monsuta","laso","oko","alasa","lupa","majuna","kipisi","leko",
        "namako","apeja","powe","pake","tonsi"]
    let emojis = ["👈","▶️","⏩️","🗣","👍","👇","❗️","🔼","❌","👉","📍","👤","↪️","⏹️","🧠","⏰️","👆","💭",
        "👐","🤔","👋","🚶","💪","❤️","💬","👎","🐭","↩️","🏠","✊️","🏝","🖼","🔧","😃","👜","🍽","👀","⚖️",
        "💧","😴","❓️","❕","⚙️","♾️","🏁","🔀","🐘","🐚","☯️","🌀","👥","☀️","📤","🔈","📄","✌️","🛣","🎁",
        "💥","➕️","⚡️","💕","😶","⚓️","⬆️","🔥","💨","🐒","🛫","😹","☝️","♾️","❄️","⭕️","#️⃣","🌴","💀","👂",
        "🍭","⚔️","⚫️","👪","🏋️","🍞","✋️","👄","🔓","🍦","💩","🐟","📖","⏺️","🛒","🍎","↔️","💰","👕","〰️",
        "👧","💎","📦","🛏","🌈","👨","🦅","⚪️","🐞","📏","⬇️","🦵","🦎","🔴","🌙","🗻","🍆","➡️","🔲","⬅️",
        "💛","👹","🔵","👁️","🏹","🕳","👵","✂️","🧱","🧂","😢","🧞","🚧","♐"]
    let horizontals : [[Character]] = [["s",],["n",],[],["s",],["w",],[],[],["j",],["u","o",],["k",],["l","j",],["k",],
        ["n",],["m",],["p","i",],["o",],["w",],["e","t",],["a",],[],["i",],[],["e",],[],["u","t",],[],[],]
    let allalphs : [Character] = ["a","e","i","o","u","n","w","t","p","s","j","k","l","m"]
    let vowels : [Character] = ["a","e","i","o","u"]
    let consonants : [Character] = ["w","t","p","s","j","k","l","m"]
    let places : [String] = ["akanisan","olan","sipe","sasali","amewikansamowa","antola","ankola","anwila","antasika",
        "ansika","alensina","aja","alupa","asenson","oselija","esalasi","asepasan","pawama","palani","panla","papeto",
        "pelalusi","pesije","pelis","penen","pemuta","tukika","polipa","posan","posuwana","pupetoja","pasila","pijot",
        "pisinalan","pune","pokasi","pukinapaso","upulunsi","kanpusi","kamelun","kanata","kanalija","kapupesi",
        "kalibinetelan","kesimen","santapiken","sejuta","sate","sile","sonko","kilima","kipeton","koko","kolonpa","komo",
        "jakonko","konko","kukialani","kosalika","kosiwa","lowasi","kupa","kulusu","kiposi","seki","tansi","tekokasija",
        "sipusi","tomini","tominika","ekato","masu","sapato","kinejekatolija","eliteja","esi","sawasi","isijopija","elopa",
        "pokan","foja","pisi","sumi","kanse","kijan","polinesi","telota","kapon","kanpija","katelo","tosi","kana","sipata",
        "elena","kalalinuna","kenata","watalu","wan","katemala","kensi","kine","kinepisa","kajan","awisi","imi","ontula",
        "onkon","mosijo","isilan","palata","intonesija","ilan","ilakija","alan","manin","isale","italija","sameka","nijon",
        "jesi","utun","kasatan","kenja","kilipasi","kosopa","kuwasi","kikitan","laju","lawi","lunpan","lesoto","lapewija",
        "lipija","lisensan","lijatuwa","lusepu","omun","maketonija","malakasi","malawi","malasija","sipeji","mali","mata",
        "maje","masini","mulitanija","mowisi","majo","mesiko","makonise","motowa","monako","monkolu","sinakola","monsale",
        "malipe","mosanpi","mijama","namipija","nawelo","nepa","netelan","nupekaletoni","nusilan","nikalawa","nise",
        "naselija","niwe","nopo","pukoson","majana","nosiki","uman","pakisan","pela","pilisin","panama","papuwanijukini",
        "palakawi","pelu","pilipina","piken","posuka","potuke","puwetoliko","kita","lajenon","lomani","losi","luwanta",
        "samowa","samalino","santume","sawusi","seneka","sopisi","sese","sijelalijon","sinkapo","sinmaten","lowenki",
        "lowensina","solomon","somalija","setapika","sajoja","anku","sasutan","epanja","lanka","sepatelemi","sateline",
        "sankinipi","senlusi","sematan","sepemiko","kenedin","sutan","siliname","sepapa","wensa","suwasi","sulija","tawan",
        "tojikiton","tansanija","tawi","simololosa","toko","tokela","tona","sinita","siten","tunisi","tuki","temenitan",
        "tekeko","tuwalu","mewikalan","pijenalan","ukanta","ukawina","alimala","juke","mewika","ulukawi","opekiton",
        "wanuwatu","wasikano","penesuwela","wije","upemoputuna","asala","jamanija","sanpija","sinpapuwe","inli","sukosi",
        "kinla","katala","esuka","peson","kusala","kuli","po","amelika","apika","asija","osejanija"]
    let placemojis : [String] = ["🇦🇫","🇦🇽","🇦🇱","🇩🇿","🇦🇸","🇦🇩","🇦🇴","🇦🇮","🇦🇶","🇦🇬","🇦🇷","🇦🇲","🇦🇼","🇦🇨","🇦🇺","🇦🇹","🇦🇿",
        "🇧🇸","🇧🇭","🇧🇩","🇧🇧","🇧🇾","🇧🇪","🇧🇿","🇧🇯","🇧🇲","🇧🇹","🇧🇴","🇧🇦","🇧🇼","🇧🇻","🇧🇷","🇮🇴","🇻🇬","🇧🇳","🇧🇬","🇧🇫","🇧🇮","🇰🇭",
        "🇨🇲","🇨🇦","🇮🇨","🇨🇻","🇧🇶","🇰🇾","🇨🇫","🇪🇦","🇹🇩","🇨🇱","🇨🇳","🇨🇽","🇨🇵","🇨🇨","🇨🇴","🇰🇲","🇨🇬","🇨🇩","🇨🇰","🇨🇷","🇨🇮","🇭🇷",
        "🇨🇺","🇨🇼","🇨🇾","🇨🇿","🇩🇰","🇩🇬","🇩🇯","🇩🇲","🇩🇴","🇪🇨","🇪🇬","🇸🇻","🇬🇶","🇪🇷","🇪🇪","🇸🇿","🇪🇹","🇪🇺","🇫🇰","🇫🇴","🇫🇯","🇫🇮",
        "🇫🇷","🇬🇫","🇵🇫","🇹🇫","🇬🇦","🇬🇲","🇬🇪","🇩🇪","🇬🇭","🇬🇮","🇬🇷","🇬🇱","🇬🇩","🇬🇵","🇬🇺","🇬🇹","🇬🇬","🇬🇳","🇬🇼","🇬🇾","🇭🇹","🇭🇲",
        "🇭🇳","🇭🇰","🇭🇺","🇮🇸","🇮🇳","🇮🇩","🇮🇷","🇮🇶","🇮🇪","🇮🇲","🇮🇱","🇮🇹","🇯🇲","🇯🇵","🇯🇪","🇯🇴","🇰🇿","🇰🇪","🇰🇮","🇽🇰","🇰🇼","🇰🇬",
        "🇱🇦","🇱🇻","🇱🇧","🇱🇸","🇱🇷","🇱🇾","🇱🇮","🇱🇹","🇱🇺","🇲🇴","🇲🇰","🇲🇬","🇲🇼","🇲🇾","🇲🇻","🇲🇱","🇲🇹","🇲🇭","🇲🇶","🇲🇷","🇲🇺","🇾🇹",
        "🇲🇽","🇫🇲","🇲🇩","🇲🇨","🇲🇳","🇲🇪","🇲🇸","🇲🇦","🇲🇿","🇲🇲","🇳🇦","🇳🇷","🇳🇵","🇳🇱","🇳🇨","🇳🇿","🇳🇮","🇳🇪","🇳🇬","🇳🇺","🇳🇫","🇰🇵",
        "🇲🇵","🇳🇴","🇴🇲","🇵🇰","🇵🇼","🇵🇸","🇵🇦","🇵🇬","🇵🇾","🇵🇪","🇵🇭","🇵🇳","🇵🇱","🇵🇹","🇵🇷","🇶🇦","🇷🇪","🇷🇴","🇷🇺","🇷🇼","🇼🇸","🇸🇲",
        "🇸🇹","🇸🇦","🇸🇳","🇷🇸","🇸🇨","🇸🇱","🇸🇬","🇸🇽","🇸🇰","🇸🇮","🇸🇧","🇸🇴","🇿🇦","🇬🇸","🇰🇷","🇸🇸","🇪🇸","🇱🇰","🇧🇱","🇸🇭","🇰🇳","🇱🇨",
        "🇲🇫","🇵🇲","🇻🇨","🇸🇩","🇸🇷","🇸🇯","🇸🇪","🇨🇭","🇸🇾","🇹🇼","🇹🇯","🇹🇿","🇹🇭","🇹🇱","🇹🇬","🇹🇰","🇹🇴","🇹🇹","🇹🇦","🇹🇳","🇹🇷","🇹🇲",
        "🇹🇨","🇹🇻","🇺🇲","🇻🇮","🇺🇬","🇺🇦","🇦🇪","🇬🇧","🇺🇸","🇺🇾","🇺🇿","🇻🇺","🇻🇦","🇻🇪","🇻🇳","🇼🇫","🇪🇭","🇾🇪","🇿🇲","🇿🇼","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🏴󠁧󠁢󠁳󠁣󠁴󠁿",
        "🏴󠁧󠁢󠁷󠁬󠁳󠁿","🏴󠁥󠁳󠁣󠁴󠁿","🏴󠁥󠁳󠁰󠁶󠁿","🏴󠁦󠁲󠁢󠁲󠁥󠁿","🏴󠁩󠁮󠁧󠁪󠁿","🏴󠁩󠁲󠀱󠀶󠁿","🏴󠁣󠁮󠀵󠀴󠁿","🌎","🌍","🌏","🌊"]
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if (view.frame.size.width == 0 || view.frame.size.height == 0) {
            return
        }

        setUpHeightConstraint()
    }
    
    func setUpHeightConstraint() {
        let customHeight = UIScreen.main.bounds.height * 0.4

        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: customHeight)
            heightConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue)

            view.addConstraint(heightConstraint)
        }
        else {
            heightConstraint.constant = customHeight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here

        let keyboardNib = UINib(nibName: "keyboardview", bundle: nil)
        let keyboardView = keyboardNib.instantiate(withOwner: self, options: nil) [0] as! UIView
        keyboardView.frame.size = self.view.frame.size
        view.addSubview(keyboardView)
        
        for alph in alphs {
            let uppercase = Character(String(alph).uppercased())
            upperalphs.append(uppercase)
        }

        alphabets = [q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m]
        for button in alphabets {
            button.addTarget(self, action:#selector(alphabetpress(_:)), for: .touchUpInside)
        }

        alphabets += [colon,period]
        suggestions = [suggestion1,suggestion2,suggestion3]

        proxy = textDocumentProxy as UITextDocumentProxy
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
        collapsebuffer()
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.

        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            view.subviews[0].backgroundColor = UIColor.gray
            for button in alphabets {
                button.setTitleColor(UIColor.white, for: [])
            }
            for button in [suggestion1,suggestion2,suggestion3] {
                button!.backgroundColor = UIColor.darkGray
            }
        } else {
            for button in alphabets {
                button.setTitleColor(UIColor.black, for: [])
            }
            for button in [suggestion1,suggestion2,suggestion3] {
                button!.backgroundColor = UIColor.lightGray
            }
        }
        updatebuffer()
    }

    func updatebuffer() {
        buffer = ""
        let s = proxy.documentContextBeforeInput
        if s != nil {
            for i in 1...s!.count {
                let sub = s![s!.index(s!.endIndex, offsetBy: -i)] //s[-i]
                if alphs.contains(sub) {
                    buffer = String(sub) + buffer
                } else if upperalphs.contains(sub) {
                    buffer = String(sub) + buffer
                    capsmode = true
                    break
                } else {
                    break
                }
            }
        }

        let a = proxy.documentContextAfterInput
        if a != nil {
            for i in a! {
                if alphs.contains(i) {
                    buffer.append(i)
                } else {
                    break
                }
            }
        }
        updatesuggestions()
    }

    func possiblewords (s : String, prev : Character) -> [String] {
        
        var string = s // so it is mutable
        if string == "" {
            return [""]
        }
        if string.count > 7 {
            string = String(string[...string.index(string.startIndex, offsetBy: 7)])
        }
        var letters : [String] = [] // Possible letters this one could represent
        if allalphs.contains(string[string.startIndex]) {
            letters.append(String(string[string.startIndex]))
        }
        let hor = horizontals[alphs.index(of: string[string.startIndex]) ?? 26] // 26 is hardcoded null array
        for i in hor {
            // n is in neither consonants or vowels
            if vowels.contains(i) && !vowels.contains(prev) || !vowels.contains(i) && !consonants.contains(prev) {
                letters.append(String(i))
            }
        }
        letters.append("") // Current letter might be a flat out mistake
        
        var strings : [String] = []
        for letter in letters {
            let sub = String(string[string.index(after: string.startIndex)...]) // sub = string[1:]
            var nextprev : Character
            if letter.count == 0 {
                nextprev = "n" // allows next letter to be whatever
            } else {
                nextprev = letter[letter.startIndex]
            }

            for word in possiblewords(s: sub, prev: nextprev) {
                strings.append(letter + word)
            }
        }
        
        return strings
    }

    func updatesuggestions () {
        if upperrn { resetCaps() }
        for button in suggestions {
            button.setTitle("", for: [])
        }
        let b = buffer.lowercased()
        if b == "" {return}

        let possibles = possiblewords(s: b, prev: "n")
        var allwords : [String] = []
        var allemojis : [String] = []
        if (capsmode) {
            allwords = places
            allemojis = placemojis
        } else {
            allwords = words
            allemojis = emojis
        }

        var sugcount = 0
        var already : [String] = []

        for possible in possibles {
            if sugcount > 2 {break}
            let i = allwords.firstIndex(of: possible)
            if i != nil {
                already.append(possible)
                suggestions[sugcount].setTitle(allemojis[i!], for: [])
                sugcount += 1
                if sugcount > 2 {break}
            }

            for j in 0..<allwords.count {
                let word = allwords[j]
                if word.count > possible.count && word[..<word.index(word.startIndex, offsetBy: possible.count)] == possible && !already.contains(word) {
                    already.append(word)
                    suggestions[sugcount].setTitle(allemojis[j], for: [])
                    sugcount += 1
                    if sugcount > 2 {break}
                }
            }
            if sugcount > 2 {break}
        }
    }

    @objc func collapsebuffer(i: Int = 0) -> Bool {
        if upperrn { resetCaps() }
        updatesuggestions()
        capsmode = false
        let replace = suggestions[i].title(for: [])
        for button in suggestions {
            button.setTitle("", for: [])
        }
        if replace != nil {
            for _ in 0..<buffer.count {
                proxy.deleteBackward()
            }
            buffer = ""
            proxy.insertText(replace!)
            return true
        }
        buffer = ""
        return false
            
    }

}

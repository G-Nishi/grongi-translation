import SwiftUI

struct ContentView: View {
    @State var inputText: String = ""
    @State var textArray: String = ""
    @State var text = 0
    @State var count = 0
    @State var outputText: String = ""
    @State var error: String = ""
    @State var text1: String = ""
    var word: [String:String] = ["あ":"ガ","い":"ギ","う":"グ","え":"ゲ","お":"ゴ","か":"バ","き":"ビ","く":"ブ","け":"ベ","こ":"ボ","さ":"ガ","し":"ギ","す":"グ","せ":"ゲ","そ":"ゴ","た":"ダ","ち":"ヂ","つ":"ヅ","て":"デ","と":"ド","な":"バ","に":"ビ","ぬ":"ブ","ね":"ベ","の":"ボ","は":"ザ","ひ":"ジ","ふ":"ズ","へ":"ゼ","ほ":"ゾ","ま":"ラ","み":"リ","む":"ル","め":"レ","も":"ロ","や":"ジャ","ゆ":"ジュ","よ":"ジョ","ら":"サ","り":"シ","る":"ス","れ":"セ","ろ":"ソ","わ":"バ","を":"ゾ","ん":"ン","が":"ガ","ぎ":"ギ","ぐ":"グ","げ":"ゲ","ご":"ゴ","ざ":"ザ","じ":"ジ","ず":"ズ","ぜ":"ゼ","ぞ":"ゾ","だ":"ザ","ぢ":"ジ","づ":"ズ","で":"ゼ","ど":"ゾ","ば":"ダ","び":"ヂ","ぶ":"ヅ","べ":"デ","ぼ":"ド","ぱ":"マ","ぴ":"ミ","ぷ":"ム","ぺ":"メ","ぽ":"モ","っ":"ッ"]
    var word2: [String:String] = ["あ":"ア","い":"イ","う":"ウ","え":"エ","お":"オ","か":"カ","き":"キ","く":"ク","け":"ケ","こ":"コ","さ":"サ","し":"シ","す":"ス","せ":"セ","そ":"ソ","た":"タ","ち":"チ","つ":"ツ","て":"テ","と":"ト","な":"ナ","に":"ニ","ぬ":"ヌ","ね":"ネ","の":"ノ","は":"ハ","ひ":"ヒ","ふ":"フ","へ":"ヘ","ほ":"ホ","ま":"マ","み":"ミ","む":"ム","め":"メ","も":"モ","や":"ヤ","ゆ":"ユ","よ":"ヨ","ら":"ラ","り":"シ","る":"ル","れ":"レ","ろ":"ロ","わ":"ワ","を":"ヲ","ん":"ン","が":"ガ","ぎ":"ギ","ぐ":"グ","げ":"ゲ","ご":"ゴ","ざ":"ザ","じ":"ジ","ず":"ズ","ぜ":"ゼ","ぞ":"ゾ","だ":"ダ","ぢ":"ヂ","づ":"ヅ","で":"デ","ど":"ド","ば":"バ","び":"ビ","ぶ":"ブ","べ":"ベ","ぼ":"ボ","ぱ":"パ","ぴ":"ピ","ぷ":"プ","ぺ":"ペ","ぽ":"ポ","ゃ":"ャ","ゅ":"ュ","ょ":"ョ","ぁ":"ァ","ぃ":"ィ","ぅ":"ゥ","ぇ":"ェ","ぉ":"ォ","っ":"ッ"]
    // っ　がついた時の処理を考えるのがめんどくさくなったので、一旦保留
    var body: some View {
        VStack {
            Text("平仮名のみのテキスト")
                .font(.largeTitle)
            TextField("テキスト", text: $inputText,
                      prompt: Text("テキストを入力"))
            Button {
                count = 0
                text1 = inputText
                error = ""
                outputText = ""
                if inputText.isEmpty {
                    print("テキストを入力してください")
                    inputText = ""
                    error = "テキストを入力してください"
                } else {
                    let textArray = Array(inputText.map { String($0) })
                    for i in textArray {
                        if i == "ー" {
                            if count == 0 {
                                error = "翻訳がありません"
                                break
                            } else {
                                count += 1
                                print("ーがついた")
                                if let lastChar = outputText.last {
                                    outputText.append(String(lastChar))
                                } else {
                                    break
                                }
                            }
                        } else if i == "ゃ" || i == "ゅ" || i == "ょ" || i == "ぁ" || i == "ぃ" || i == "ぅ" || i == "ぇ" || i == "ぉ" {
                            if count == 0 {
                                if let dh = word2[i]{
                                    outputText.append(dh)
                                }
                            } else {
                                let changeText = textArray[count-1]
                                if changeText == "ー"{
                                    if let ch = word2[i] {
                                        outputText.append(ch)
                                    }
                                } else {
                                    let indexToRemove = outputText.index(before: outputText.endIndex)
                                    var updatedOutputText = outputText
                                    updatedOutputText.remove(at: indexToRemove)
                                    outputText = updatedOutputText
                                    if let changeText2 = word2[changeText] {
                                        outputText.append(changeText2)
                                    }
                                    if let tra = word2[i] {
                                        count += 1
                                        outputText.append(tra)
                                    } else {
                                        break
                                    }
                                }
                            }
                        } else if let translatedValue = word[i] {
                            count += 1
                            outputText.append(translatedValue)
                        } else {
                            print("翻訳がありません")
                            error = "翻訳がありません"
                            outputText = ""
                            break
                        }
                    }
                    print(textArray)
                    text = textArray.count
                    print("文字数：\(text)")
                    print(count)
                }
            } label: {
                Text("グロンギ語へ翻訳")
            }
            Text(text1)
                .font(.title)
            Text(error)
            Text(outputText)
                .font(.title)
        }
        
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

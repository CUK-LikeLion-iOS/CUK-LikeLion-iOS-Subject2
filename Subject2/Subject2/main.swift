import Foundation

// lotteryRecord 변수에 저장하는 함수
func saveLotteryNumbers(lotteryNumbers: Set<Int>) -> Void {
    
    let lotteryRound = lotteryRecord.count + 1
    
    lotteryRecord[lotteryRound] = lotteryNumbers
}

// 새로운 당첨 번호 6개 뽑기
func pickNewLotteryNumbers() -> Set<Int> {
    
    var newLotteryNumbers : Set<Int> = Set<Int>()
    
    repeat {
        newLotteryNumbers.insert(Int.random(in: 1...45))
    } while (newLotteryNumbers.count < 6)
    
    return newLotteryNumbers
}

// N회차 로또 응모
func checkSameLotteryNumbers(myNumbers: Set<Int>, lotteryRound: Int) -> Void {
    
    guard let lotteryNumbers: Set<Int> = lotteryRecord[lotteryRound] else {
        print("\(lotteryRound)회차 로또 번호는 아직 없습니다.")
        return
    }
    let sameNumbers: Set<Int> = myNumbers.intersection(lotteryNumbers)
    
    if (sameNumbers.isEmpty) {
        print("아쉽지만 겹치는 번호가 없습니다.")
        return
    }
    
    print(
    """
    축하합니다! 겹치는 번호는
    \(stringifyLotteryNumbers(numbers: sameNumbers))
    입니다.
    """)
    
    let message: String
    switch sameNumbers.count {
    case 6:
        message = "1등입니다!!!!!!"
    case 5:
        message = "2등입니다!!!!!"
    case 4:
        message = "3등입니다!!!!"
    case 3:
        message = "4등입니다!!!"
    default:
        message = "다음 기회에..."
    }
    
    print(message)
}

// 당첨 및 겹치는 번호를 문자열로 변환 후 반환
func stringifyLotteryNumbers(numbers: Set<Int>) -> String {
    
    let numbersSorted: Array<Int> = numbers.sorted()
    var stringifiedNumbers: String = ""
    
    // 번호 6개에 오름차순으로 콤마 붙인 문자열
    for num in numbersSorted {
        if (num == numbersSorted.last!){
            stringifiedNumbers += String(num)
            break;
        }
        else {
            stringifiedNumbers += String(num) + ", "
        }
    }
    
    return stringifiedNumbers
}

// N회차 로또 번호 출력
func printLotteryNumbers(lotteryRound: Int) {
    
    guard let lotteryNumbers: Set<Int> = lotteryRecord[lotteryRound] else {
        print("\(lotteryRound)회차 로또 번호는 아직 없습니다.")
        return
    }
    
    print(
    """
    \(lotteryRound)회차의 로또 당첨 번호는
    \(stringifyLotteryNumbers(numbers: lotteryNumbers))
    입니다.
    """)
}





// main
var lotteryRecord = Dictionary<Int, Set<Int>>() // [회차: 당첨번호]

for _ in 1 ... 5 {
    saveLotteryNumbers(lotteryNumbers: pickNewLotteryNumbers())
}

printLotteryNumbers(lotteryRound: 2)

// 4회차 응모
let myNumbers: Set<Int> = [8, 11, 17, 26, 30, 42]
checkSameLotteryNumbers(myNumbers: myNumbers, lotteryRound: 4)

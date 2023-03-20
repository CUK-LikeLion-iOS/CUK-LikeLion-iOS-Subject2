import Foundation

// 새로운 로또 번호를 회차별로 lotteryRecord 변수에 저장하는 함수
func saveLotteryNumbers(lotteryNumbers : Set<Int>) -> Void {
    lotteryRecord[lotteryRecord.count + 1] = lotteryNumbers
}

// 새로운 당첨 번호 6개를 만드는 함수
func makeLotteryNumbers() -> Set<Int> {
    var lotteryNumbers : Set<Int> = Set<Int>()  // 당첨 번호 집합
    
    // 당첨 번호 집합이 6개가 될 때까지
    while (lotteryNumbers.count < 6) {
        let newNumber = Int.random(in: 1 ... 45)    // 1 ~ 45 사이의 난수를 생성한다
        
        if (lotteryNumbers.contains(newNumber)) {   // 만약 당첨 번호에 이미 존재하면
            continue                                // 다시 뽑는다
        }
        lotteryNumbers.insert(newNumber)            // 새로운 번호는 집합에 넣는다
    }
    
    return lotteryNumbers
}

// 나의 번호와 당첨 번호를 비교하여 겹치는 번호를 출력하는 함수
func checkLotteryNumbers(myNumbers : Set<Int>, lotteryNumbers : Set<Int>) -> Void {
    var sameNumbers : Set<Int> = myNumbers.intersection(lotteryNumbers)    // 나의 번호와 겹치는 당첨 번호
    
    if (sameNumbers.isEmpty) {  // 겹치는 번호가 없을 경우
        print("아쉽지만 겹치는 번호가 없습니다.")
    }
    else {                      // 겹치는 번호가 하나 이상 있을 경우
        print(
        """
        축하합니다! 겹치는 번호는
        \(getLotteryNumber(numbers: sameNumbers))
        입니다.
        """
        )
    }
}

// 당첨 번호 문자열을 반환하는 함수
func getLotteryNumber(numbers: Set<Int>) -> String {
    let numbersSorted : Array<Int> = numbers.sorted()   // 당첨 번호를 오름차순으로 정렬한 배열
    var res : String = ""                               // 반환할 문자열
    
    for num in numbersSorted {
        if (num == numbersSorted.last) {    // 마지막 원소면
            break                           // 반복문을 끝낸다
        }
        res += String(num) + ", "
    }
    res += String(numbersSorted.last!) // 배열은 항상 6개의 값을 가지고 있으므로 마지막 값은 항상 존재한다. 따라서 바인딩하지 않고 벗긴다
    
    return res
}

// main

// 로또 회차별 당첨번호
var lotteryRecord : Dictionary<Int, Set<Int>> = Dictionary<Int, Set<Int>>() // 키로 int, value로 Set<Int>를 가진다

// 5회차 추첨을 하여 저장한다
for _ in 1 ... 5 {
    saveLotteryNumbers(lotteryNumbers: makeLotteryNumbers())
}

// 2회차 당첨번호를 옵셔널 바인딩을 이용하여 출력한다
if let secondLotteryNumbers: Set<Int> = lotteryRecord[2] {
    print(
    """
    2회차의 로또 당첨 번호는
    \(getLotteryNumber(numbers: secondLotteryNumbers))
    입니다.
    """)
}

// 4회차 당첨번호와 내가 뽑은 번호를 비교해본다
let myNumbers : Set<Int> = [8, 11, 17, 26, 30, 42]  // 내가 뽑은 번호!

if let fourthLotteryNumbers = lotteryRecord[4] {
    checkLotteryNumbers(myNumbers: myNumbers, lotteryNumbers: fourthLotteryNumbers) // 약 800만분의 1 확률로 전부 다 맞힐 수 있다...
}

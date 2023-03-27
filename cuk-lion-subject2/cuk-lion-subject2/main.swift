//
//  main.swift
//  like-lion-subject2
//
//  Created by 김희은 on 2023/03/16.
//

import Foundation

func makeNumSet() -> Set<Int> {
    var lottoSet: Set<Int> = Set<Int>()
    
    while lottoSet.count != 6 {
        let num: Int = Int.random(in: 1...45) // 중복 제거를 할 필요 X.
        lottoSet.insert(num)
    }
    return lottoSet
}

func checkLottoNum(myLottoNumbers: Set<Int>) {
    var lottoNumSet = makeNumSet()
    var sameNumSet: Set<Int> = Set<Int>()

    // 겹치는 번호 교집합 추출
    sameNumSet = myLottoNumbers.intersection(lottoNumSet)
    
    if(sameNumSet.count > 0){
        var arraySameNum: [Int] = Array(sameNumSet)
        arraySameNum.sort()
        let sameNumString = arraySameNum.map { String($0) }.joined(separator: ", ") // set 대괄호 제거하여 출력
        
        print("축하합니다! 겹치는 번호는 \(sameNumString)입니다!")
    }
    else {
        print("아쉽지만 겹치는 번호가 없습니다.")
    }
}

func makeLottoDict(totalRounds: Int, previousDict: [String: Set<Int>]) -> [String: Set<Int>] {
    
    var lottoNumDict: Dictionary<String, Set<Int>> = [String: Set<Int>]()
    var lottoNumSet: Set<Int> = Set<Int>()

    for i in previousDict.count..<totalRounds {
        lottoNumSet = makeNumSet()
        lottoNumDict["\(i+1)회차"] = lottoNumSet
    }
    return lottoNumDict
}

func appendLottoDict(totalRounds: Int = 5) -> [String: Set<Int>] {
    var totalLottoDict: [String: Set<Int>] = [:]
    var newLottoDict: [String: Set<Int>]
    
    newLottoDict = makeLottoDict(totalRounds: totalRounds, previousDict: totalLottoDict)
    totalLottoDict.merge(newLottoDict, uniquingKeysWith: {(_, old) in old} ) // total에 new추가 - total과 교집합은 유지

    return totalLottoDict
}

func printLottoAtRound(atLottoRound:Int, lottoNumDict:[String: Set<Int>]) {
    // 로또 회차 없을 경우 예외처리
    guard let lottoNumAtRound = lottoNumDict["\(atLottoRound)회차"] else {
        print("\(atLottoRound)회차의 로또 당첨 번호를 불러오는 데 실패했습니다.")
        return
    }
    var arraylottoNumAtRound: [Int] = Array(lottoNumAtRound)
    arraylottoNumAtRound.sort()
    let lottoNumString = arraylottoNumAtRound.map { String($0) }.joined(separator: ", ") // set 대괄호 제거하여 출력
    
    print("\(atLottoRound)회차의 로또 당첨 번호는 \(lottoNumString) 입니다.")
}

func showLottoResult(atLottoRound: Int) {
    var lottoDict = appendLottoDict(totalRounds: 5)
    lottoDict = appendLottoDict(totalRounds: 8)
    printLottoAtRound(atLottoRound: atLottoRound, lottoNumDict: lottoDict)
}

let myLottoNumbers: Set<Int> = [46, 23, 12, 3, 5, 18]

checkLottoNum(myLottoNumbers: myLottoNumbers)

showLottoResult(atLottoRound: 8)

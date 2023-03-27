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
    var sameNum: Set<Int> = Set<Int>()

    // 겹치는 번호 교집합 추출
    sameNum = myLottoNumbers.intersection(lottoNumSet)
    
    if(sameNum.count > 0){
        var arraySameNum: [Int] = Array(sameNum)
        arraySameNum.sort()
        let sameNumString = arraySameNum.map { String($0) }.joined(separator: ", ") // set [] 제거 후 출력
        
        print("축하합니다! 겹치는 번호는 \(sameNumString)입니다!")
    }
    else {
        print("아쉽지만 겹치는 번호가 없습니다.")
    }
}

func makeLottoDict(lottoRounds: Int, previousDict: [String: Set<Int>]) -> [String: Set<Int>] {

    var lottoNumDict: Dictionary<String, Set<Int>> = [String: Set<Int>]()
    var lottoNum: Set<Int> = Set<Int>()

    for i in previousDict.count..<lottoRounds {
        lottoNum = makeNumSet()
        lottoNumDict["\(i+1)회차"] = lottoNum
    }
    return lottoNumDict
}

func appendLottoDict(lottoRounds: Int = 5) -> [String: Set<Int>] {
    var totalLottoDict: [String: Set<Int>] = [:]
    var newLottoDict: [String: Set<Int>] = [:]
    
    newLottoDict = makeLottoDict(lottoRounds: lottoRounds, previousDict: totalLottoDict)
    totalLottoDict.merge(newLottoDict, uniquingKeysWith: {(_, old) in old} ) // total + new

    return totalLottoDict
}

func showLottoAtRound(lottoRound:Int, lottoNumDict:[String: Set<Int>]) {
    // 로또 회차 없을 경우 예외처리
    guard let lottoNumByRound = lottoNumDict["\(lottoRound)회차"] else {
        print("\(lottoRound)회차의 로또 당첨 번호를 불러오는 데 실패했습니다.")
        return
    }
    var arraylottoNumByRound: [Int] = Array(lottoNumByRound)
    arraylottoNumByRound.sort()
    let lottoNumString = arraylottoNumByRound.map { String($0) }.joined(separator: ", ")
    
    print("\(lottoRound)회차의 로또 당첨 번호는 \(lottoNumString) 입니다.")
}

func showLottoResult(lottoRound: Int)
{
    var lottoDict = appendLottoDict(lottoRounds: 5)
    lottoDict = appendLottoDict(lottoRounds: 8)
    showLottoAtRound(lottoRound: lottoRound, lottoNumDict: lottoDict)
}

let myLottoNumbers: Set<Int> = [46, 23, 12, 3, 5, 18]

checkLottoNum(myLottoNumbers: myLottoNumbers)

showLottoResult(lottoRound: 8)

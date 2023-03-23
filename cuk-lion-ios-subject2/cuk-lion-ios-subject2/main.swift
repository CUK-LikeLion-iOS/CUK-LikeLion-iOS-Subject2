//
//  main.swift
//  cuk-lion-ios-subject2
//
//  Created by Jinyoung Yoo on 2023/03/16.
//
//
//

import Foundation


func generateWinngingLottoNumbers() -> Array<Int> {
    let winningLottoNumbers: ArraySlice<Int> = Array(1...45).shuffled()[0...5]

    return Array(winningLottoNumbers)
}


func checkMyLottoResult(winningLottoNumbers: [Int], myLottoNumbers: [Int]) {
    var myWinningLottoNumbers: [Int] = []

    // 당첨 번호 판별
    for myLottoNumber in myLottoNumbers {
        for winningLottoNumber in winningLottoNumbers {
            if (myLottoNumber == winningLottoNumber) {
                myWinningLottoNumbers.append(myLottoNumber)
            }
        }
    }

    // 당첨 번호 배열 정렬
    myWinningLottoNumbers.sort()

    
    // 당첨 번호 출력
    if (myWinningLottoNumbers.isEmpty) {
        print("아쉽지만 겹치는 번호가 없습니다.")
    }
    else {
        print("축하합니다! 겹치는 번호는 ", terminator: "")

        for index in 0..<myWinningLottoNumbers.endIndex {
            if (index == myWinningLottoNumbers.endIndex - 1) {
                print("\(myWinningLottoNumbers.last!) 입니다!")
            }
            else {
                print("\(myWinningLottoNumbers[index]), ", terminator: "")
            }
        }
    }
}


func showRoundResult(winningNumbers: [Int], round: Int) {
    
    print("\(round)회차 로또 당첨 번호는 ", terminator: "")

    for index in 0...5 {
        if index == 5 {
            print("\(winningNumbers[index]) 입니다.")
        } else {
            print("\(winningNumbers[index])", terminator: ", ")
        }
    }
}


func showLottoRoundHistory(lottoHistoryArchive: [String: [Int]], round: Int) {
    guard let roundWinningNumbers: [Int] = lottoHistoryArchive["\(round)회차"] else {
        print("\(round)회차에 대한 정보가 없습니다.")
        return
    }
    showRoundResult(winningNumbers: roundWinningNumbers, round: round)
}


func generateLottoHistory(lottoHistoryArchive prevLottoHistroy: [String: [Int]] , rounds: Int) -> [String: [Int]] {

    guard rounds > 0 else {
        print("1보다 작은 값이 들어왔자나!!!!!!!!!!!")
        exit(0)
    }

    var newLottoHistory: [String: [Int]] = prevLottoHistroy
    var prevRound = newLottoHistory.count


    // rounds만큼의 로또 회차 생성
    for _ in 1...rounds {
        let winningLottoNumbers: [Int] = generateWinngingLottoNumbers()
        
        newLottoHistory.updateValue(winningLottoNumbers, forKey: "\(prevRound + 1)회차")
        prevRound += 1
    }
    
    return newLottoHistory
}

func manageLottoHistory() {
    var lottoHistoryArchive: [String: [Int]] = [:]

    // rounds 만큼의 로또 회차 생성
    lottoHistoryArchive = generateLottoHistory(lottoHistoryArchive: lottoHistoryArchive, rounds: 5)
    lottoHistoryArchive = generateLottoHistory(lottoHistoryArchive: lottoHistoryArchive, rounds: 6)

    // 특정 로또 회차 출력
    showLottoRoundHistory(lottoHistoryArchive: lottoHistoryArchive, round: 8)
}



let myLottoNumbers: [Int] = [3, 6, 10, 24, 33, 42]

checkMyLottoResult(winningLottoNumbers: generateWinngingLottoNumbers(), myLottoNumbers: myLottoNumbers)

manageLottoHistory()


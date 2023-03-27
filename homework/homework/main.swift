import Foundation

var lottoNumber : Dictionary <String, Set<Int>> = [:]
let myLottoNumbers = createNum()

createDict (dict : lottoNumber, index : 5) // 1~5회차 의 로또넘버를 기록

let myWinningNum = lottoNumber["1회차"]?.intersection(myLottoNumbers) // 당첨번호 구하기

func compareNum (lottoNum : Set<Int>) // 당첨번호 비교
{
    let myLottoNumbers = recordWinNum (lottoNum : lottoNum) // 나의 당첨번호 구하기
    
    // 당첨번호가 있을때출력
    if myLottoNumbers.count > 0
    {
        print("축하합니다! 겹치는 번호는 " + myLottoNumbers + " 입니다.")
    }
    else {
        print("아쉽지만 겹치는 번호가 없습니다.")
    }
}

func recordWinNum (lottoNum : Set<Int>) -> String // 당첨번호 출력
{
    var recordNum = [Int]()
    var winNum : String = ""
    
    // 전달받은 lottoNum 출력
    for i in lottoNum {
        recordNum.insert(i, at: recordNum.endIndex)
    }
    
    // 입력받은 숫자를 String 형태로 변환
    for i in recordNum {
        winNum += String(i)
        
        // 마지막 숫자가 아닌 경우에는 문자열에 , 을 추가
        if i != recordNum[recordNum.count - 1] {
            winNum +=  ","
        }
    }
    return winNum
}

func createDict (dict : Dictionary<String,Set<Int>>, index : Int) // index 만큼 회차를 만들어주는 함수
{
    //index 번까지 숫자 생성
    for _ in 1...index
    {
        let x = String(lottoNumber.count+1) // 현재 딕셔너리 수 = 회차
        lottoNumber[x+"회차"] = createNum() // x번째 회차에 로또넘버 넣기
    }
}

func createNum () -> Set<Int> // lotto 번호 생성
{
    var lottoNum : Set<Int> = []
    
    while lottoNum.count < 6 {
        lottoNum.insert(Int.random(in: 1...45)) // 랜덤으로 1~45 까지 insert 해주는 작업
    }
    
    return lottoNum
}

func findLottoNumber (lottoNum:Set<Int>,index : Int) // 해당 회차의 당첨번호를 찾는 함수
{
    let script = recordWinNum (lottoNum : lottoNum) // 당첨번호 문자열인 recordWin을 script 로 설정
    
    print("\(index)회차의 로또 당첨 번호는 " + script + " 입니다.")
}
compareNum(lottoNum:myWinningNum ?? []) // lottoNum 이 nil 이면 빈 배열을 반환
findLottoNumber(lottoNum: lottoNumber["2회차"] ?? [],index :2)
createDict (dict : lottoNumber, index : 10) // 10회차 까지 더 저장
findLottoNumber(lottoNum: lottoNumber["15회차"] ?? [],index :15) // 15회차 까지 생긴것을 볼 수 있음


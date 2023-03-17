import Foundation

var lottoNumber : Dictionary <String, Set<Int>> = [:] // 로또 넘버를 담아주는 Dictionary
let myLottoNumbers = createNum() // 나의 로또 넘버를 생성

createDict (dict : lottoNumber, index : 5) // 1~5회차 의 로또넘버를 기록해줌
let myWinningNum = lottoNumber["1회차"]?.intersection(myLottoNumbers) //1회차와 myLottonumber의 교집합을 구하면 당첨 번호를 구한다.

func compareNum (lottoNum : Set<Int>) // 당첨번호를 출력하는 함수
{
    let myLottoNumbers = recordWinNum (lottoNum : lottoNum) // myLottoNumbers 를 recordWin 인자로 보내 당첨번호를 출력한다.
    
    // 당첨번호가 있을때만 번호를 출력함.
    if myLottoNumbers.count > 0
    {
        print("축하합니다! 겹치는 번호는 " + myLottoNumbers + " 입니다.")
    }
    else {
        print("아쉽지만 겹치는 번호가 없습니다.")
    }
}

func recordWinNum (lottoNum : Set<Int>) -> String // 1,2,3 과 같이 , 를 붙여주기 위해 만든 함수
{
    var recordNum = [Int]()
    var winNum : String = ""
    
    // recordNum 은 전달받은 lottoNum 을 계속해서 추가한다.
    for i in lottoNum {
        recordNum.append(i)
    }
    
    // 입력받은 num을 String 형태로 변환해주어서 문자열 형태로 추가한다.
    for i in recordNum {
        winNum += String(i)
        
        // 마지막 숫자가 아닌 경우에는 문자열에 , 을 추가해준다.
        if i != recordNum[recordNum.count - 1] {
            winNum +=  ","
        }
    }
    return winNum
}

func createDict (dict : Dictionary<String,Set<Int>>, index : Int) // 로또 넘버를 회차별로 만들어주는 함수 index 에 입력받은 수 만큼 추가한다.
{
    // 입력받은 회차 만큼 반복해서 createNum 을 호출해준다.
    for _ in 1...index
    {
        let x = String(lottoNumber.count+1) // 몇번째 회차인지 알기 위해서 현재 딕셔너리가 몇개가 있는지 매칭
        lottoNumber[x+"회차"] = createNum() // 매칭 된 값을 key 값에 넣어주어 순차적으로 당첨번호가 입력될 수 있게 세팅
    }
}

func createNum () -> Set<Int> // lotto 번호를 만드는 함수
{
    var lottoNum : Set<Int> = []
    
    while lottoNum.count < 6 { // 입력을 set으로 받았기 때문에 중복되는 수는 입력받지 않는다. 따라서 6이 되기 전 까지 while문으로 반복
        lottoNum.insert(Int.random(in: 1...45)) // 랜덤으로 1~45 까지 insert 해주는 작업
    }
    
    return lottoNum
}

func findLottoNumber (lottoNum:Set<Int>,index : Int) // 해당 회차의 당첨번호를 찾는 함수
{
    let script = recordWinNum (lottoNum : lottoNum) // 당첨번호 문자열인 recordWin을 script 로 설정
    
    print("\(index)회차의 로또 당첨 번호는 " + script + " 입니다.")
}
compareNum(lottoNum:myWinningNum ?? []) // lottoNum 이 nil 이면 빈 배열을 반환해준다.
findLottoNumber(lottoNum: lottoNumber["2회차"] ?? [],index :2)
createDict (dict : lottoNumber, index : 10) // 10회차 까지 더 저장
findLottoNumber(lottoNum: lottoNumber["15회차"] ?? [],index :15) // 15회차 까지 생긴것을 볼 수 있음

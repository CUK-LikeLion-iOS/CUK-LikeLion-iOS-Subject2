# LikeLion Subject 2

### 마크다운에 대하여
 [마크다운 기본기](https://www.youtube.com/watch?v=kMEb_BzyUqk)
 ---
### 난수 생성
- 과거의 Swift 난수 생성 함수들
1. arc4 계열의 함수들

    `let randomUInt32FromAtoB = arc4random_uniform(b - a + 1)) + a`
    
    이 함수는 0부터 인자값 - 1 사이의 정수를 UInt32 자료형으로 반환하며, 따라서 인자도 UInt32 정수형을 필요로 한다. 스위프트는 signed와 unsigned를 막론하고 64비트형을 기본 정수 자료형으로 사용하고 있기 때문에 함수를 사용할 때 상당히 번거롭다.

    또 네이밍이 스위프트 컨벤션과 어울리지 않는 이유는 이 함수가 OpenBSD 유닉스의 난수 생성을 위해 개발된 C 라이브러리이기 때문이고 macOS 또한 BSD 커널에 기반을 두고 있기 때문에 남아있는 레거시 코드이다.

    `let randomUInt32 = arc4random()`

    arc4random_uniform의 원조격 함수로 0 ~ 2^32 -1 사이의 unsigned int를 반환한다.

    `let randomDouble = drand48()`

    [0, 1) 사이의 실수를 반환하는 함수

    > arc4 계열의 보안적으로는 더 우수하지만 알고리즘의 속도나 코드 가독성면에서 떨어진다.

2. 배열을 이용한 난수 생성

    `let randomIntFromArray = [1, 2, 3, 4, 5].randomElement()!`

    배열 내에서 난수를 뽑을 수도 있다. 옵셔널 언래핑이 필요한데 빈 배열일수도 있기 때문.

    `let arrayShuffled = [1, 2, 3, 4, 5].shuffled()`

    이 함수는 배열 자체를 셔플하여 새로운 배열을 반환한다.

    `let arrayToBeShuffled = [1, 2, 3, 4, 5]`

    `arrayToBeShuffled.shuffle()`

    배열을 반환하지 않고 내부를 섞을 수도 있다.

- 스위프트 4.2 이후 난수 생성

3. random 메소드

    기본적으로 자료형.random(in: 범위) 형식으로 사용한다.

    `let randomIntFromAtoB = Int.random(in: a...b)`

    기본적인 random 메소드를 사용할 경우 SystemRandomNumberGenerator라는 기본 난수생성기를 이용한다. 그러나 만약 기본이 아닌 커스텀 RNG를 이용하고 싶다면, RandomNumberGenerator 매개 변수로 직접 만든 RNG 구조체를 넣어주면 되는데, 이 구조체는 적절한 프로토콜을 따라야 한다. 이는 자바의 인터페이스 / C++의 인터페이스 클래스와 매우 닮아있으며 프로토콜에 대해서는 추후에 정리하겠다.

    `var customRNG = CustomRNG(seed: 123456)`

    `let randomDoubleWithCustomRNG = Double.random(in: a...b, using: customRNG`


---

### 옵셔널

> 값이 있을 수도, 없을 수도 있는 변수

다음과 같은 형변환은 옵셔널을 반환한다.

`let intA = Int(stringA)`

만약 stringA가 정수로 표현할 수 있는 문자열을 가지고 있다면 (예를 들면 "2023") 정상적으로 형변환이 될 것이다. 하지만 "2023년"과 같은 문자열을 가지고 있다면 형변환이 불가능하다. 이 경우 intA에 nil 값이 담기게 된다. 따라서 String에서 Int로의 형변환은 옵셔널이다. 그러나 그 역은 옵셔널이 아니다.

`let stringB = String(intB)`

다음과 같은 코드를 생각해 보자. 이 때 intB는 언제나 String으로 변경될 수 있다. 따라서 stringB의 타입은 옵셔널이 아닌 일반 String일 것이다.

#### 옵셔널 값에 접근하는 방법

1. Unwrapping

    강제로 옵셔널 값에 접근하는 방법이다. 다음과 같이 접근할 수 있다.

    `let stringA: String? = "옵셔널 스트링"`

    `print(stringA!)`

    그런데 stringA에 nil 값을 대입하고 코드를 실행하면 nil값을 읽기 때문에 오류가 발생하게 된다. 옵셔널 값이 nil인 경우를 대비해 다음과 같이 처리할 수 있다.

    `print(string ?? "stringA is nil")`

    string에 값이 존재하면 string을 출력하고 nil 값일 경우에는 ?? 뒤의 문자열을 출력하게 된다. 이를 nil coalescing 이라고 한다

2. Binding

    언래핑을 하게 되면 옵셔널 값이 없을 때 크래쉬가 발생하는 위험이 있다. 바인딩은 두가지 방식이 있는데 옵셔널 값에 안전하게 접근할 수 있기 때문에 자주 이용된다.

    * `if let`
    * `guard let`

    먼저 `if let` 은 if문과 유사하게 if-else의 구조를 가지고 있다.

    ```
    var optionalStringA: String?
    if let stringA = optionalStringA {
        print(stringA)
    }
    else {
        print("optionalStringA is nil!")
    }
    ```

    else문은 옵셔널 값이 nil일 때 실행되며 없어도 무방하다.

    다음은 `guard let` 문이다.

    ```
    func foo() {
        var optionalIntA: Int?
        ...
        guard let intA = optionalIntA else {
            print("optionalIntA is nil!")
            return;
        }
        // do something with intA
        ...
    }
    ```

    `guard let`문은 함수 안에서만 사용할 수 있다. 만약 옵셔널 값이 없으면 이후 코드들을 실행할 수 없을 경우 함수를 끝내도록 방어해 주는 역할을 하기 때문이다. 따라서 else문 안에 return 혹은 throw문 같이 함수를 종료해주는 코드가 있어야 한다.

---

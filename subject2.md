### 과제 2

---

#### 1. Collection Type

- Array
- Set
- Dictionary

<br />

##### Array

> - 동적으로 크기가 조정 가능한 배열
> - 배열이 생성될 때는 고정된 크기의 메모리 공간을 할당하며, 배열의 크기가 변경되면 새로운 메모리 공간을 할당하고 이전의 원소를 새로운 공간으로 복사
> - 제네릭 타입으로 구현되어있으므로, 여러 타입의 원소를 저장 가능
> - map, filter, reduce 등의 함수형 프로그래밍에 유용한 메서드를 제공한다.

<br />
###### 💡 ARC(Automatic Reference Counting)

- ARC란 자동 참조 계수 기반 메모리 관리 기법으로 객체의 참조 횟수가 0이 되면 해당 객체의 메모리를 자동으로 해제한다.
  <br />

  - Swift에서는 모든 것이 객체이자 구조체이므로 객체의 참조 횟수를 계속 카운트하다가 참조 횟수가 0이 되면 메모리를 해제함으로써 메모리 누수를 방지한다.
  - ARC는 컴파일러가 코드를 분석하여 객체의 참조 계수를 자동으로 증가시키거나 감소시키는 코드를 삽입한다.
  - Swift에서는 일부 경우 수동으로 참조 계수를 관리해야 할 수 있다. 예를 들어, 서로 참조하는 객체 간의 순환 참조(circular reference)가 발생할 경우 참조 계수가 0이 되지 않아 메모리 누수(memory leak)가 발생할 수 있다. 이러한 경우에는 weak, unowned 등의 키워드를 사용하여 참조 타입을 선언하고, weak 참조나 unowned 참조를 사용하여 순환 참조를 방지할 수 있다.
    <br />

- 가비지 콜렉터와 무엇이 다른가?

  - 가비지 콜렉터는 메모리 사용량에 따라 주기적으로 메모리를 해제하는 방식으로 동작함으로써 비지 콜렉터가 메모리를 해제하는 시점을 예측할 수 없기 때문에 프로그램 성능에 영향을 미칠 수 있다. 반면에, ARC는 객체의 참조 횟수를 기반으로 메모리를 관리하기 때문에 가비지 콜렉터보다 예측 가능한 메모리 관리가 가능하다.
    <br />

<br />

##### Dictionary

Swift의 Dictionary는 키와 값으로 이루어진 쌍(Pair)의 집합을 나타내는 자료구조이다. 키와 값은 모두 제네릭(Generic) 타입이므로, 서로 다른 타입의 데이터를 저장할 수 있다.

Dictionary는 내부적으로 해시 테이블(Hash Table)을 사용하여 데이터를 저장하고 검색한다. 해시 테이블은 데이터를 해시 함수를 사용하여 배열((버킷) 내에 적절한 위치에 저장한다. 해시 함수를 사용하여 키에 대한 해시값을 계산하면, 이 값을 배열(버킷) 내에 저장할 인덱스로 사용한다. 이를 통해, 데이터를 빠르게 검색하고 저장할 수 있다.

Swift의 Dictionary는 해시 충돌(Collision)을 방지하기 위해 체이닝(Chaining)이라는 기법을 사용한다. 체이닝은 충돌이 발생한 경우, 해당 인덱스에 이미 저장된 데이터와 함께 연결 리스트를 만들어 데이터를 추가한다.

이때, Swift는 해시 충돌을 최소화하기 위해 키 값을 이중으로 해싱한다. 이중 해시는 두 개의 해시 함수를 사용하여 충돌을 최소화 한다. 먼저, 첫 번째 해시 함수가 반환한 값을 배열(버킷) 인덱스로 사용한다. 만약 이 배열(버킷)에 이미 키가 존재한다면, 두 번째 해시 함수를 사용하여 다른 배열(버킷) 인덱스를 찾는다. 사용된 해싱 알고리즘은 MurmurHash3라고 하는 알고리즘이라고 한다.

[해시 테이블 설명 영상](https://www.youtube.com/watch?v=HraOg7W3VAM)
<br />

##### Set

Swift의 Set은 Dictionary와 마찬가지로 Hash Table로 구현되어 있다. Swift의 Set은 Dictionary와 달리, 키(Key)가 없이 값(Value)만을 저장한다. 이를 해결하기 위해, Set은 원소 값(Value) 자체를 해시값으로 사용한다. [Hashable](https://developer.apple.com/documentation/swift/hashable) 프로토콜을 준수하는 원소들은 자신의 해시값을 반환할 수 있으며, 이 값을 이용하여 배열 내에 저장할 인덱스로 사용한다.

Swift의 Set은 검색 속도가 빠르며, 중복을 허용하지 않기 때문에 유용하게 사용된다. 이때, 중복된 원소를 자동으로 막아주는 원리는 해당 원소의 해시 값에 해당하는 버킷의 인덱스에 해당 원소가 저장될 텐데, 이때 그 인덱스의 버킷에 똑같은 값이 있으면 추가를 하지 않는다. 만약, 해시 충돌에 의해 다른 원소인데 같은 해시 값에 의해 이미 다른 원소가 존재하는 버킷에 저장되려고 할 때에는 Chaining 기법을 사용해 연결 리스트를 만들어 원소를 추가한다.

<br />

##### 💡 Collection & Sequence

> 데이터를 담는 Container 자료구조를 Swift에서는 Collection, Sequence 프로토콜을 사용해서 만든다.
> Sequence는 요소들의 목록을 의미한다. Sequence는 'Iterator'로 구성된 프로토콜이라고 생각하면 될 것 같다.
> Seuqence는 유한거나 무한할 수 있다. 무한할 수 있다는 말은 Sequence로 만들어진 타입이 몇 개의 요소로 구성되어 있는지 알 수 없다는 뜻이다.
>
> 반면 모든 Collection은 Sequence를 상속받아 구현되었으며, Collection은 Sequence가 지닌 두 가지 문제점을 해결했다.
> 모든 Collection은 유한하다. 따라서 항상 몇 개의 요소로 구성되어 있는지 알 수 있다는 것이다.
> 몇 개의 요소로 구성되어 있는지 알 수 있다는 말은 특정 요소에 임의 접근이 가능할 수 있다는 말이고 이로인해 접근 및 수정, 추가 ,삭제 등이 가능해진 것이다.

#### 2. Random 값 생성하기

<br />

- Int.random(in: )
  - Swift에서는 데이터 타입도 객체이다. 따라서 데이터 타입도 메서드를 가질 수 있다. Int 객체의 random 메서드로 Int 값들의 무작위 값을 생성할 수 있다.
    <br />
- randomElement()

  - Collection 프로토콜에 정의된 메서드이므로 Array, Set, Dictionary에서 해당 메서드를 사용할 수 있다.
    <br />

- shuffle()
  - randomElement()와 마찬가지로 Collection 프로토콜에 정의된 메서드이다.

<br />

#### 3. Array에 값을 추가하는 방법

<br />

- append() 메서드 사용하기
- +, += 연산자 사용하기
  - ex) [1, 2, 3] + [4, 5, 6]
- insert(\_:, at: ) 메서드 사용하기
  - myArray.insert(4, at: 3) // 3번째 인덱스에 추가

<br />

#### 4. 옵셔널 값 추출하기

- 옵셔널 바인딩: if-let, guard-let 문을 사용해서 옵셔널 값이 nil이 아닌 경우, 값을 안전하게 추출하고 일반적인 변수나 상수에 할당 하는 것

  - guard-let문은 조건을 만족하지 않는 경우에 일찍 반환하므로 가독성이 좋아진다.
  - <b>if-let 문은 바인딩된 값이 if-let 블록 안에서만 사용될 수 있는 반면에 guard-let 문은 바인딩 된 값이 guard-let 문 밖에서도 사용될 수 있다.</b>

```swift
if let value = optionalValue {
    // 옵셔널 값이 nil이 아니면 value에 값이 할당됩니다.
    print(value)
} else {
    // 옵셔널 값이 nil이면 실행됩니다.
    print("optionalValue is nil")
}
```

```swift
var optionalValue: Int? = 3
guard let safeValue = optionalValue else {
    return
}
// 옵셔널 바인딩으로 안전하게 추출한 값 사용
print(safeValue)
```

- 옵셔널 패턴: switch 구문에서 사용할 수 있는 옵셔널 추출 방식이다. switch 구문에서 사용하기 때문에 조금 더 복잡한 조건에 따라 옵셔널 값을 처리할 때 사용된다.

```swift
  switch optionalValue {
  case .some(let value) where value > 10:
  // 옵셔널 값이 nil이 아니고, value가 10보다 큰 경우에 실행됩니다.
  print("\(value) is greater than 10")
  case .some(let value):
  // 옵셔널 값이 nil이 아니고, value가 10보다 작거나 같은 경우에 실행됩니다.
  print("\(value) is less than or equal to 10")
  case .none:
  // 옵셔널 값이 nil인 경우에 실행됩니다.
  print("optionalValue is nil")
  }
```

- 강제 언래핑: 옵셔널 변수 뒤에 "!"를 붙여서 강제로 언래핑한다. <b> 이 방법은 옵셔널 값이 nil인 경우에 런타임 오류가 발생할 수 있으므로 주의해야 한다.<b>

- nil 병합 연산자: ?? 연산자를 사용하여 옵셔널 값이 nil인 경우에 기본값을 제공할 수 있다.

```swift
let optionalValue: Int? = nil
let unwrappedValue = optionalValue ?? 0
print(unwrappedValue) // 0
```

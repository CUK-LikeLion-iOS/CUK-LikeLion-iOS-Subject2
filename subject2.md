#### [마크다운 문법참고](https://gist.github.com/ihoneymon/652be052a0727ad59601)

#### Collection type - Set

1. 중복된 값을 방지할 수 있다.

- 원소의 존재여부를 판단하는 컬렉션 타입이기 때문에 중복이 있는지 바로 확인 가능해 데이터의 무결성을 보장하고 프로그램의 안정성을 높인다.
- 원소 검색

```swift
set.contains("banana")
```

2. 순서가 필요하지 않은 경우에 사용한다.

- 데이터를 빠르고 쉽게 검색할 수 있다.

3. 집합의 연산을 지원한다.

- 교집합, 합칩합 , 대칭 차집합 , 차집합을 구한 결과를 보여준다.
- set 해시 함수이기 때문에 각 입력값에 대해 고유한 해시값을 출력한다. 중복성이 없기에 데이터 처리에 유용하고 집합연산이 가능하다.

```swift
let setA: Set = [1, 2, 3, 4]
let setB: Set = [3, 4, 5, 6]
let intersection = setA.intersection(setB) // {3, 4} 교집합
let union = setA.union(setB) // {1, 2, 3, 4, 5, 6} 합집합
let symmetricDifference = setA.symmetricDifference(setB) // {1, 2, 5, 6} 차집합
let subtracting = setA.subtracting(setB) // {1, 2} A를 기준으로 한 대칭 차집합
```

---

#### Hash Table

![](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Hash_table_3_1_1_0_1_0_0_SP.svg/440px-Hash_table_3_1_1_0_1_0_0_SP.svg.png)

key 를 해시 함수를 이용해서 hash value 로 매핑하고 hash value를 index로 삼아 데이터를 buckets 에 저장한다.
원소의 검색이 따라서 (O(1))로 가능한 것

- 해시충돌
  해시 함수는 입력값의 길이가 어떻든 고정된 길이의 값을 출력하기 때문에 입력값이 다르더라도 같은 결과값이 나오는 경우가 있다.
  [온라인 SHA256 해시 생성기](https://www.convertstring.com/ko/Hash/SHA256)
  ![](https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Hash_table_4_1_1_0_0_1_0_LL.svg/480px-Hash_table_4_1_1_0_0_1_0_LL.svg.png)

  > 만약 해시테이블의 크기가 N 키의 개수가 K 일때 적재율은 K/N 이다. 만약 충돌이 발생한다면 O(k)만큼 시간복잡도가 걸린다.

  - 해결법
    ![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FCoiPf%2Fbtq2qyoJVrN%2FERiH4UbKnKHQyF4R0HGjOk%2Fimg.png)

> 개방주소법 ( Open Addressing ) : 다른 빈 버킷을 찾아 공간을 할당해주는것

      장점 : 데이터가 적을수록 속도가 빨라진다.
            연속된 공간에 데이터를 저장하기 때문에 캐시효율이 좋아진다.

      단점 : 해시충돌이 발생하면 인덱스값 자체가 바뀌어버린다.
            데이터가 많아질수록 성능이 급격하게 저하된다.

> 연결리스트 방법 (Separate Chaining) : 해당 버킷에 연결리스트를 만들어 원소 추가저장

      장점 : 해시충돌이 발생해도 인덱스값에는 변함이 없다.
            데이터 개수에 제약이 없다.

      단점 : 메모리 문제를 야기할 수 있다.
            테이블이 부하율에 따라 선형적으로 성능이 저하된다.

> 이중해시 : 다른 해시 함수를 한번 더 적용하여 충돌을 최소화 한다.

![](https://mblogthumb-phinf.pstatic.net/MjAxODA2MTdfMTIg/MDAxNTI5MTYzMTA1MjIy.Ia7uXwH23g5uoQNpasIT1ayX_yjmdYaxpSManBJCQXIg.bHGn8xFDGwPfwTNwjDxqrcLSiZaMDhlNJ1f6uCcdUxcg.PNG.beaqon/스크린샷_2018-06-17_오전_12.30.48.png?type=w800)

![](https://mblogthumb-phinf.pstatic.net/MjAxODA2MTZfMTIg/MDAxNTI5MTU2NDY3NTky.zqCfnIm_w4BhiunuJhT0f-Qhf9AkYnLSstBXRL9WKC8g.7h2cLgIS88cli3mplXSwuHROVUxKUVTjiOHeqCPbdtwg.PNG.beaqon/스크린샷_2018-06-16_오후_10.40.52.png?type=w800)

      a,b 해시함수 존재

      1. 데이터의 키를 해시값으로 변환

      2. 버킷이 비어있다면 데이터를 해당 버킷에 저장

      3. 이미 채워져있다면 해시 b를 이용해 다른 빈 공간의 버킷을 찾는다.

      4. 해시함수 b의 결과를 a에 더한 후 다시 새로운 빈 버킷을 찾는다.

      5. 새로운 버킷을 찾을경우 데이터를 해당 버킷에 저장한다.

      6.  새로운 버킷이 이미 데이터로 채워져있는 경우 b를 이용해 새로운 버킷을 찾을때까지 반복

      장점 : 선형 해시와 비교하여 해시 충돌을 더 잘 처리할 수 있다.
            해시 함수 2를 잘 선택하면 충돌을 더 빠르고 정확하게 처리할 수 있다.
            캐시의 지역성을 활용하여 성능이 향상될 수 있다.

      단점 : 해시 함수 2를 선택하는 것이 중요!  해시 함수 2가 잘못 선택되면 성능이 저하될 수 있음.
            해시 함수 2가 항상 충돌을 해결할 수 있는건 아님. 해시 함수 2를 사용하여도 충돌이 발생할 수 있다.
            해시 함수 2의 값이 해시 충돌을 일으키는 값과 상관관계가 있으면 해시 충돌이 더 발생할 가능성이 있음.

---

#### collection type 에서 사용하는 다양한 메서드

1. 요소추가 / 삭제

- append(\_ : ) : 배열의 끝에 요소를 추가합니다.
- insert(\_ :at: ) : 배열의 특정 인덱스에 요소를 추가합니다.
- remove(at: ) : 배열의 특정 인덱스에 있는 요소를 삭제합니다.
- removeAll() : 배열의 모든 요소를 삭제합니다.
- updateValue(\_ :forKey: ) : 딕셔너리에 값을 추가하거나, 기존 키에 새 값을 할당합니다.
- removeValue(forKey: ) : 딕셔너리에서 특정 키와 연결된 값을 삭제합니다.

2. 검색

- contains(\_ : ) : 배열이나 Set에 특정 요소가 포함되어 있는지 확인합니다.
- first(where: ) : 배열이나 Set에서 특정 조건을 만족하는 첫 번째 요소를 반환합니다.
- filter(\_: ) : 배열이나 Set에서 특정 조건을 만족하는 모든 요소를 반환합니다.
- min() : 배열이나 Set에서 최솟값을 반환합니다.
- max() : 배열이나 Set에서 최댓값을 반환합니다.

3. 정렬

- sort() : 배열을 오름차순으로 정렬합니다.
- sorted() : 배열을 정렬한 새로운 배열을 반환합니다.
- sorted(by:) : 배열을 사용자 정의 비교 함수를 기반으로 정렬합니다.

4. 원소의 수 반환

- count : 컬렉션의 크기나 길이를 반환

* 문자열 객체 사용시에 length 을 사용하기도 하지만 swift 에서는 count 프로퍼티를 사용하여 문자열의 길이를 반환한다.

- isEmpty : 주어진 컬렉션이 비어있는지 여부 반환

---

#### 수식 연산자 (+,-,\*,/,% ) 과 할당 연산자 ( = )

일반적으로 수식 연산자는 앞뒤에 공백을 사용하지 않는다. (c++과 같음 )
이는 수식 연산자의 우선순위가 높아서 주변에 다른 토큰이 있어도 구분이 쉽기 때문이다.

하지만 swift 에서는 등호 '=' 을 사용시 앞뒤로 공백을 넣어야 하는데, 이는 코드의 가독성을 높이기 위함이다.
코드를 읽는 사람에게 왼쪽과 오른쪽이 서로 다른 토큰이라는 것을 명확하게 알려주기 위함이다.

다른 언어와는 다르게 가독성을 높이기 위해 = 사이에 공백을 둔다.

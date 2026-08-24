# 트러블 슈팅

## 2026.08.25.

### GestureDetector의 onTap 매개변수에 대하여

#### 증상

* ```NavTab``` 위젯들을 클릭해도 아무런 변화가 일어나지 않는다.

#### 원인

* 가설조차 세울 수가 없어서 결국 클로드에게 원인을 물어보았다. 원인은 ```NavTab```의 ```GestureDetector```의 ```onTap``` 매개변수에 함수를 전달하는 방식이 잘못되었기 때문이다.

* 기존에 쓰던 방식은 다음과 같다.

``` dart
class NavTab extends StatelessWidget {

  // 이전 생략
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        // 이하 생략
      ),
    );
  }
}
```

* 기존에 쓰던 방식대로 작동하면, ```onTap```이라는 함수 자체가 반환된다. 그래서 아무런 반응이 일어나지 않는다. 매개변수에 전달된 함수 ```onTap```이 실행되도록 코드를 수정해야 한다.

#### 해결책1

* ```onTap```을 ```() => onTap()```으로 고친다. ```onTap()```에 있는 괄호는 이 함수를 실행시킨다는 의미이다. 

``` dart
class NavTab extends StatelessWidget {

  // 이전 생략
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        // 이하 생략
      ),
    );
  }
}
```

#### 해결책2

* ```onTap```의 자료형을 ```Function```이 아닌 ```VoidCallback```으로 바꾼다. 후자로 자료형을 설정하면 이와 같은 실수를 방지할 수 있다. 

``` dart
class NavTab extends StatelessWidget {

  // 이전 생략
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap),
        // 이하 생략
      ),
    );
  }
}
```

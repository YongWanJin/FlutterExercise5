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
        onTap: onTap,
        // 이하 생략
      ),
    );
  }
}
```

<br>

## 2026.08.26.

### UI 위젯의 렌더링 순서에 대하여

#### 증상

* 강의에서는  ```PostVideoButton``` 위젯을 작성할 때에 각 Container들에 padding을 넣었다. 하지만 내가 보기에는 padding을 각 Container들마다 설정하는 것이 일관된 방식이 아니라고 생각했다. 그래서 padding을 쓰지 않고 사이즈만 통일하는 방식으로 코딩을 했다.

* 다음은 post_video_button.dart를 최초로 수정한 코드 중 일부이다.

```dart
class _PostVideoButtonState extends State<PostVideoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onLongPressEnd: widget.onLongPressEnd,
      child: Stack(
        alignment: AlignmentGeometry.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 5,
            child: Container(
              height: 30,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(Sizes.size10),
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: Container(
              height: 30,
              width: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Sizes.size10),
              ),
            ),
          ),
          AnimatedContainer(
            height: 30,
            width: 48,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: widget.isSelected ? Colors.amber : Colors.white,
              borderRadius: BorderRadius.circular(Sizes.size6),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

* 그랬더니 오른쪽 Container(파란색 Container)가 삐져나오지 않았다. 반면 왼쪽 Container(빨간색 Container)는 정상적으로 삐져나왔다. 왜 ```clipBehavior```를 정상적으로 설정했음에도 불구하고 오른쪽 Container(파란색 Container)는 삐져나오지 않았는가? 

<img width="360" height="94" alt="Image" src="https://github.com/user-attachments/assets/b103d433-da73-4012-b2b7-10adee750fee" />

#### 원인

* FLUTTER DEVTOOLS: INSPECTOR를 통해 widget tree의 요소가 실제로 화면에서 어느 공간을 차지하고 있는지 확인해봤다. 그랬더니 4번째 ```NavTab```(inbox)의 윗부분을 덮지 못하고 있음을 확인하고 있었다.

<img width="371" height="104" alt="Image" src="https://github.com/user-attachments/assets/68454cfc-ef66-4e15-abf3-bfba6de8ebd4" />

* 클로드 코드 AI에게 질문을 해보았다. ```Row```의 ```children```들은 선언한 순서대로 출력을 한다. 그 순서가 화면을 덮는 순서에도 영향을 미친다. ```Row```에서 맨 마지막에 선언된 위젯은 맨 위 순서에 덮힌다고 한다.

#### 해결책 1

* ```PostVideoButton```에게 충분한 공간을 부여하면 된다. ```Expanded``` 위젯을 통해 다른 navigation icon들과 동일한 여백을 가질 수 있도록 해준다.

```dart
class _PostVideoButtonState extends State<PostVideoButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
      // 이하 생략 //
      ),
    );
  }
}
```

#### 해결책 2

* ```PostVideoButton```이 더 확실하게 옆에 있는 ```NavTab```들에게 영향을 받지 않고 자유롭게 공간을 차지하고 싶다면 new_navigation_screen.dart에서 ```PostVideoButton```와  ```NavTab```의 선언 순서를 ```Stack```을 통해 약간 바꿔주면 된다. 

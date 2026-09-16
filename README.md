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

<br>

## 2026.08.28.

### pubspec.yaml 설정에 관하여

#### 증상

* lib/features/videos/widgets/video_post.dart에 있는 코드 중 다음 부분에서 해당 에러 메시지가 발생하며 assets/videos에 들어있는 영상 파일을 불러오지 못하고 앱이 강제 종료되었다.

```dart
  void _initViedoPlayer() async {
    await _videoPlayerController.initialize();  // 에러가 발생한 부분
    _videoPlayerController.play();
    setState(() {});
  }
```

```
PlatformException (PlatformException(VideoError, Video player had error androidx.media3.exoplayer.ExoPlaybackException: Source error, null, null))
```

#### 원인

* pubspec.yaml에서 ```assets``` 항목의 들여쓰기가 잘못되어, flutter에서 영상이 들어있는 파일을 인식하지 못했다.

```yaml
flutter:
  uses-material-design: true
assets:
  - assets/videos/
```

#### 해결책

* ```assets``` 항목을 ```flutter``` 항목 아래에 위치할 수 있게 들여쓰기 한다. 

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/videos/
```

<br>

## 2026.08.30.

### 동영상 종료에 관하여

#### 증상

* 첫번째 동영상에서 다음 동영상으로 넘어갈 때 모두 건너뛰고 마지막 동영상이 재생되는 문제가 발생했다.

#### 가설 1

* 동영상이 끝났을 때 동작하는 함수에 무언가 이상이 있을 것이다. 동영상이 끝났을 때에 동작하는 함수를 찾아서 잘 살펴보자.

#### 원인

* lib/features/videos/widgets/video_post.dart에서 ```_videoPlayerController```의 생명주기를 끝내는 함수 ```dispose()``` 부분을 눈여겨 보자.

```dart

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
        // 재생 중인 동영상의 전체 길이와 현재 재생 위치가 같으면,
        // 그러니까 재생 중인 동영상 재생이 모두 끝나면,
        // onVideoFinished() 함수를 실행시킨다.
      }
    }
  }

  void _initViedoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initViedoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
    widget.onVideoFinished();
  }
```

* 이미 ```_onVideoChange()```에서 ```onVideoFinished()```를 동작하도록 되어있다. 그런데 ```dispose()``` 함수에서 다시 한 번 ```onVideoFinished()```가 동작한다. 동영상 재생이 모두 끝났을 때 동작할 함수가 두번 동작하는 것이다. 그래서 다음 동영상으로 넘어갔을 때 재생되지 않고 곧바로 끝나버리는 것이다.

#### 해결책

* ```dispose()``` 함수에 들어있는 코드 ```widget.onVideoFinished()```를 삭제한다.

<br>

## 2026.09.04

### 변수에 변화가 생기면 반드시 setState()를 사용하라!

#### 증상

* 요약된 설명란을 클릭하자마자 설명란 전체가 나오도록 설계했다. 하지만 해당 부분을 클릭하면 아무런 반응도 일어나지 않는다. 그런데 bottomNavigationBar에서 다른 탭을 클릭하고 다시 Home 탭을 클릭하면 영상 자세 설명란 전체가 뜬다. 반대의 경우도 마찬가지.

#### 가설1

* 영상 설명란 위젯인 '''BodyText'''에 들어있는 GestureDetector가 인식되지 않아서 그럴 것이다.

#### 가설1 폐기

* print()를 통해서 로그를 확인해보니, GestureDetector는 잘 작동된다.

#### 증상 다시 확인

* 요약된 설명란을 클릭하고 영상을 멈추거나 재생하면 설명란 전체가 나온다. 그리고 펼쳐진 설명란을 클릭하고 영상을 멈추거나 재생하면 설명란이 요약된다.

#### 가설2

* '''BodyText'''에 들어있는 GestureDetector가 작동될 때 실행되는 메소드 ```_onSeeMoreTap()```에서 변경된 사항이 영상을 멈추거나 재생할 때에 빌드된다. 즉, 영상을 멈추거나 재생할 때에 실행되는 메소드 ```_onTogglePause()``` 안에 들어있는 메소드 ```setState()```가 실행될 때 ```_onSeeMoreTap()```에서 변경된 사항이 비로소 빌드되는 것이다.

#### 해결책

```_onSeeMoreTap()```에서 ```setState()```를 추가한다. 그렇게 하여 ```BodyText```의 GestureDetector가 실행될 때 ```_onTogglePause()```와는 독립적으로 변경 사항을 빌드하도록 한다. 변경된 코드는 다음과 같다.

```Dart
void _onSeeMoreTap() {
  setState(() {
    _seeMore = !_seeMore;
  });
}
```

<br>

## 2026.09.16

### TabBarView 사용시 주의점

#### 증상

* lib/features/discover/discover_screen.dart 코드를 복습하던 도중, TabBarView 위젯만 입력하면 flutter 앱 자체가 부팅이 되지 않았다. TabBarView 위젯 부분을 테스트 용으로 아무리 간단하게 작성해도 앱 자체가 부팅이 되지 않는 문제가 발생했다. 다음은 내가 당시에 작성했던 코드이다.

```Dart
final tabs = ["Top", "Users", "Videos", "Sounds", "LIVE", "Shopping", "Brands"];

// 중략 //

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Discover"),
          bottom: TabBar(
            // 중략 //
            tabs: [
              for (var tab in tabs)
                Tab(
                  child: Text(tab, style: TextStyle(fontSize: Sizes.size16)),
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("asaaa")),
          ],
        ),
      ),
    );
  }
}

```

#### 원인

* TabBarView 위젯의 children의 개수가 DefaultTabController의 length와 맞지 않았기 때문이다. 탭은 7개가 존재하므로 보여줄 화면도 7개가 필요하다. 하지만 위의 경우에는 하나의 화면만 준비되어 있었다. 

#### 해결책

* TabBarView 위젯의 children의 개수도 7개로 맞춰준다.





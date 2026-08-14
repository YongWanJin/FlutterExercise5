import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";

  bool _obsecureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  /// 비밀번호 양식을 검사하는 기능
  bool _ispasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  /// 화면 아무데나 클릭하면 키보드가 사라지는 기능
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  /// 키보드 상에서 '다음' 또는 'Done'에 해당하는 버튼을 눌렀을 때 실행할 기능
  void _onsubmit() {
    if (!_ispasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BirthdayScreen()),
    );
  }

  /// 클릭할 시에 패스워드 입력칸의 모든 텍스트를 지우는 기능
  void _onClearTap() {
    _passwordController.clear();
  }

  /// 숨겨진 패스워드를 보여줄지 말지 설정하는 기능
  void _toggleObsecureText() {
    _obsecureText = !_obsecureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Sign up'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "Password?",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                autocorrect: false,
                onEditingComplete: _onsubmit,
                obscureText: _obsecureText,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.circleXmark,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObsecureText,
                        child: FaIcon(
                          _obsecureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: "Make it strong!",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              Text(
                'Your password must have:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _ispasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  Text("8 to 20 characters"),
                ],
              ),
              Gaps.v16,
              GestureDetector(
                onTap: _onsubmit,
                child: FormButton(disabled: !_ispasswordValid()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

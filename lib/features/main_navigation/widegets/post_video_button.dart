import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatefulWidget {
  const PostVideoButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    required this.onLongPressEnd,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final GestureLongPressEndCallback onLongPressEnd;

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
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
      ),
    );
  }
}

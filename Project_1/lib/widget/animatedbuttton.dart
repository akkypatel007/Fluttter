/*
import 'package:flutter/material.dart';

class AnimatedCircularButton extends StatefulWidget {
  final Image image;
  final double size;

  const AnimatedCircularButton({Key? key, required this.image, this.size = 40})
      : super(key: key);

  @override
  _AnimatedCircularButtonState createState() => _AnimatedCircularButtonState();
}

class _AnimatedCircularButtonState extends State<AnimatedCircularButton>
    with SingleTickerProviderStateMixin {
  bool _isTapped = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
    setState(() {
      _isTapped = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    setState(() {
      _isTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: () {
        _controller.reverse();
        setState(() {
          _isTapped = false;
        });
      },
      child: TweenAnimationBuilder<double>(
        tween:,
        duration: Duration(milliseconds: 200),
        builder: (context, value, child) {
          return Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isTapped ? Colors.grey[300] : Colors.transparent,
              border: Border.all(color: Colors.grey[300]!, width: 2),
              backgroundBlendMode: BlendMode.multiply,
              // backgroundPosition: Alignment(-value, -value),
              image:
                  DecorationImage(image: widget.image.image, fit: BoxFit.cover),
            ),
            child: child,
          );
        },
        child: Icon(Icons.circle, size: widget.size, color: Colors.transparent),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class AnimatedCircularButton extends StatefulWidget {
  final Image image;
  final double size;

  const AnimatedCircularButton({Key? key, required this.image, this.size = 40})
      : super(key: key);

  @override
  _AnimatedCircularButtonState createState() => _AnimatedCircularButtonState();
}

class _AnimatedCircularButtonState extends State<AnimatedCircularButton> {
  bool _isTapped = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isTapped = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: Ink(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: Colors.blue[300]!, width: 2),
          backgroundBlendMode: BlendMode.multiply,
          image: DecorationImage(image: widget.image.image, fit: BoxFit.cover),
        ),
        child: Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          child: AnimatedOpacity(
            opacity: _isTapped ? 0.5 : 1.0,
            duration: Duration(milliseconds: 200),
            child: Icon(Icons.circle,
                size: widget.size, color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}

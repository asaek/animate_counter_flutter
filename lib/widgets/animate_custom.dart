import 'package:flutter/material.dart';

const _splashRadius = 30.0;

class AnimateWidget extends StatefulWidget {
  const AnimateWidget({super.key});

  @override
  State<AnimateWidget> createState() => _AnimateWidgetState();
}

class _AnimateWidgetState extends State<AnimateWidget> {
  int _contador = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 240,
      // color: Colors.orangeAccent,
      child: Material(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              splashRadius: _splashRadius,
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _contador--;
                });
                print('Wee apunta toda tu energia a kyary');
              },
            ),
            GestureDetector(
              onPanUpdate: (details) {
                print(details.delta.dx);
                print(details.delta.dy);
              },
              child: SizedBox(
                height: 80,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFF3B3B3B),
                  child: FittedBox(
                    child: Text(
                      _contador.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _contador++;
                    });
                    print('Wee hechale ganas kyary esta ahi');
                  },
                ),
              ),
            ),
            IconButton(
              splashRadius: _splashRadius,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _contador++;
                });
                print('Wee hechale ganas kyary esta ahi');
              },
            ),
          ],
        ),
      ),
    );
  }
}

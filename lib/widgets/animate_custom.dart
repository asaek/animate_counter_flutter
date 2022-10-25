import 'package:flutter/material.dart';

const _splashRadius = 30.0;

class AnimateWidget extends StatefulWidget {
  const AnimateWidget({super.key});

  @override
  State<AnimateWidget> createState() => _AnimateWidgetState();
}

class _AnimateWidgetState extends State<AnimateWidget> {
  int _contador = 0;
  Alignment _dragAligment = Alignment.center;

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
    const maxHeight = 80.0;
    const maxWidth = 300.0;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Material(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(70),
        child: SizedBox(
          height: maxHeight,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    print(details.delta.dx);
                    print(details.delta.dy);

                    setState(() {
                      // _dragAligment += Alignment(
                      //   details.delta.dx / (constraints.maxWidth / 2),
                      //   0,
                      // );
                      if (_dragAligment.x > 1) {
                        _dragAligment = const Alignment(1.0, 0.0);
                      } else if (_dragAligment.x < -1) {
                        _dragAligment = const Alignment(-1.0, 0.0);
                      }
                    });
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

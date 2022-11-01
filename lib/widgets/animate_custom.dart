import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';

const _splashRadius = 30.0;

class AnimateWidget extends StatefulWidget {
  const AnimateWidget({super.key});

  @override
  State<AnimateWidget> createState() => _AnimateWidgetState();
}

class _AnimateWidgetState extends State<AnimateWidget>
    with SingleTickerProviderStateMixin {
  final _springDescription = const SpringDescription(
    mass: 1,
    stiffness: 500,
    damping: 15,
  );
  int _contador = 0;
  Alignment _dragAligment = Alignment.center;

  SpringSimulation? _springSimulation;

  Ticker? _ticker;
  // final bool _isPressed = false;

  void _startAnimation() {
    _ticker ??= Ticker(_onTick);
    _springSimulation = SpringSimulation(
      _springDescription,
      _dragAligment.x,
      0,
      0,
    );
    _ticker?.start();
  }

  void _stopAnimation() {
    _ticker?.stop();
  }

  void _onTick(Duration duration) {
    if (_springSimulation != null) {
      final time = duration.inMilliseconds / 1000.0;
      final value = _springSimulation!.x(time);
      setState(() {
        _dragAligment = Alignment(value, 0);
      });
      if (_springSimulation!.isDone(time)) {
        _stopAnimation();
      }
    }
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const maxHeight = 80.0;
    const maxWidth = 280.0;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: SizedBox(
        height: maxHeight,
        child: Align(
          alignment: _dragAligment,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxWidth - 60),
            child: Material(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(70),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // print(constraints.maxHeight);
                  return SizedBox(
                    height: maxHeight,
                    child: Stack(
                      children: [
                        _builtActionsButtons(),
                        _buildCentralButton(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCentralButton() {
    return Align(
      alignment: _dragAligment,
      child: GestureDetector(
        onPanUpdate: (details) {
          // print('Se ejecuta al arrastrar');
          setState(() {
            _dragAligment += Alignment(
              details.delta.dx / (200 / 2),
              0,
            );

            // print('DragAlitment: $_dragAligment');
            // print('details.delta.dx: ${details.delta.dx}');

            if (_dragAligment.x > 1) {
              _dragAligment = const Alignment(1.0, 0.0);
            } else if (_dragAligment.x < -1) {
              _dragAligment = const Alignment(-1.0, 0.0);
            }
          });
        },
        onPanEnd: (_) {
          // print('Se ejecuta al dejar de tocar');
          if (_dragAligment.x > 0) {
            _contador++;
          } else {
            _contador--;
          }
          _startAnimation();
        },
        onPanDown: (details) {
          // print('Se ejecuta al tocar');
          _stopAnimation();
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
    );
  }

  Widget _builtActionsButtons() {
    return Column(
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
    );
  }
}

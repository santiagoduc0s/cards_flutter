import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:metaballs/metaballs.dart';
import 'package:porfolio_santi/game/car_3d_game.dart';

class MetaballsBackground extends StatefulWidget {
  @override
  _MetaballsBackgroundState createState() => _MetaballsBackgroundState();
}

class _MetaballsBackgroundState extends State<MetaballsBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleDrawer() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  Future<void> _navigateTo(BuildContext context, Widget screen) async {
    // Close the drawer with animation before navigating
    await _controller.reverse();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: Duration(
            milliseconds: 400), // Adjust the duration to make it slower
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Metaballs background effect with Royal Blue color
          Metaballs(
            color: const Color(0xFF4169E1), // Royal Blue color
            effect: MetaballsEffect.follow(
              growthFactor: 1.2,
              radius: 0.7,
            ),
            metaballs: 50,
            animationDuration: const Duration(milliseconds: 400),
            speedMultiplier: 1.2,
            bounceStiffness: 2.5,
            minBallRadius: 1,
            maxBallRadius: 75,
            glowRadius: 0.8,
            glowIntensity: 0.6,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double slide = 250.0 * _animation.value;
              double scale = 1 - (_animation.value * 0.3);
              double rotateY = (_animation.value * 0.3);

              return Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale)
                  ..rotateY(-rotateY),
                alignment: Alignment.centerLeft,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('3D Drawer Animation'),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.menu,
                          color: Colors.black), // Hamburger icon
                      onPressed: _toggleDrawer, // Open/close the drawer
                    ),
                  ),
                  body: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(.6),
                      ),
                      child: Center(
                        child: Text(
                          'Metaballs Background',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          _buildDrawer(), // 3D Drawer
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double translateX = -250.0 * (1 - _animation.value);
        double rotateY = -0.5 * (1 - _animation.value);

        return Transform(
          transform: Matrix4.identity()
            ..translate(translateX)
            ..rotateY(rotateY),
          alignment: Alignment.centerRight,
          child: Container(
            width: 250,
            color: Colors.blueAccent,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    '3D Drawer Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _navigateTo(context, HomeScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _navigateTo(context, SettingsScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.white),
                  title: Text(
                    'About',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _navigateTo(context, AboutScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.gamepad, color: Colors.white),
                  title: Text(
                    '3D game',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _navigateTo(context, Car3DGame());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Example screens for navigation
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to Home Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
      ),
      body: Center(
        child: Text('Welcome to Settings Screen'),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Screen'),
      ),
      body: Center(
        child: Text('Welcome to About Screen'),
      ),
    );
  }
}

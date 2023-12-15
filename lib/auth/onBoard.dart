import 'package:flutter/material.dart';
import 'login_screen.dart';

class onBoard extends StatefulWidget {
  const onBoard({Key? key}) : super(key: key);

  @override
  _onBoardState createState() => _onBoardState();
}

class _onBoardState extends State<onBoard> {
  @override
  Widget build(BuildContext context) {
    // initializing media query (for getting device screen size)
    return Scaffold(
      // body
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const onBoard2()),
                    );
                  },
                  backgroundColor: Colors.white, // Change color as needed
                  child: Icon(Icons.arrow_forward, color: Colors.black),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class onBoard2 extends StatefulWidget {
  const onBoard2({Key? key}) : super(key: key);

  @override
  _onBoard2State createState() => _onBoard2State();
}

class _onBoard2State extends State<onBoard2> {
  @override
  Widget build(BuildContext context) {
    // initializing media query (for getting device screen size)

    return Scaffold(
      // body
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const onBoard3()),
                    );
                  },
                  backgroundColor: Colors.white, // Change color as needed
                  child: Icon(Icons.arrow_forward, color: Colors.black),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class onBoard3 extends StatefulWidget {
  const onBoard3({Key? key}) : super(key: key);

  @override
  _onBoard3State createState() => _onBoard3State();
}

class _onBoard3State extends State<onBoard3> {
  @override
  Widget build(BuildContext context) {
    // initializing media query (for getting device screen size)
    return Scaffold(
      // body
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  backgroundColor: Colors.white, // Change color as needed
                  child: Icon(Icons.arrow_forward, color: Colors.black),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashLight extends StatefulWidget {
  const FlashLight({Key? key}) : super(key: key);

  @override
  _FlashLightState createState() => _FlashLightState();
}

class _FlashLightState extends State<FlashLight> {
  bool buttonTextFlag = false;
  String buttonText = 'FlashLight is oF';
  bool imageChange = false;
  String imagePath = 'assets/24.png';
  String imagepath2 = 'assets/flashlight.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              color: Color.fromARGB(31, 43, 42, 42),
              child: const Center(
                child: Text(
                  'FLASHLIGHT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.815,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 63, 62, 62),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          changeImage();
                        });
                      },
                      child: Image(
                        image: AssetImage(imagePath),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          buttonTextFlag = !buttonTextFlag;
                          imageChange = !imageChange;
                          textChnage();
                          changeImage();
                        });
                      },
                      child: Text(buttonText),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: Colors.red,
                          fixedSize: const Size(240, 20)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _turnONFlash(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } catch (_) {
      _showError('Could not enable flashlight', context);
    }
  }

  Future<void> _turnoFFlash(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } catch (_) {
      _showError('Could not enable flashlight', context);
    }
  }

  void _showError(String mes, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
  }

  void changeImage() {
    if (buttonTextFlag == true) {
      imagePath = 'assets/24.png';
    } else {
      imagePath = imagepath2;
    }
  }

  void textChnage() {
    if (buttonTextFlag == true) {
      buttonText = 'FlashLight is On';
      _turnONFlash(context);
    } else {
      buttonText = 'FlashLight is Off';
      _turnoFFlash(context);
    }
  }
}

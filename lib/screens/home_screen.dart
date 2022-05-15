import 'package:flutter/material.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  String? _response;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Stax'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // text input
            // TextField(
            //   controller: _controller,
            //   keyboardType: TextInputType.phone,
            //   decoration: const InputDecoration(
            //     labelText: 'Ussd code',
            //   ),
            // ),

            // dispaly responce if any
            if (_response != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(_response!),
              ),

            // buttons
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String? _res = await UssdAdvanced.multisessionUssd(
                      code: "*334*7*1#",
                      subscriptionId: -1,
                    );

                    setState(() {
                      _response = _res;
                    });
                    String? _res2 = await UssdAdvanced.sendMessage('0');
                    setState(() {
                      _response = _res2;
                    });
                    // await UssdAdvanced.cancelSession();
                  },
                  child: const Text('M-Pesa Balance'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    UssdAdvanced.sendUssd(
                      code: "*144#",
                      subscriptionId: 1,
                    );
                  },
                  child: const Text('Airtime Bal'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? _res = await UssdAdvanced.sendAdvancedUssd(
                        code: _controller.text, subscriptionId: 1);

                    setState(() {
                      _response = _res;
                    });
                  },
                  child: const Text('single Session\nRequest'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child:SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Share.share('Check out this amazing app: https://example.com');
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Share App", style: TextStyle(fontSize: 16)),
                SizedBox(width: 5),
                Icon(Icons.share, size: 18),
              ],
            ),
          ),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String _encryptedText = "";
  String _decryptedText = "";
  String _encryptionKey = "";

  /// Encrypts the input text using a custom algorithm
  String encrypt(String text, String key) {
    List<int> encryptedChars = [];
    for (int i = 0; i < text.length; i++) {
      int keyChar = key.codeUnitAt(i % key.length);
      encryptedChars.add(text.codeUnitAt(i) + keyChar);
    }
    return String.fromCharCodes(encryptedChars);
  }

  /// Decrypts the encrypted text back to its original form
  String decrypt(String encryptedText, String key) {
    List<int> decryptedChars = [];
    for (int i = 0; i < encryptedText.length; i++) {
      int keyChar = key.codeUnitAt(i % key.length);
      decryptedChars.add(encryptedText.codeUnitAt(i) - keyChar);
    }
    return String.fromCharCodes(decryptedChars);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Encryption & Decryption'),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _textController,
              decoration:const InputDecoration(
              labelText: 'Encription',
               hintText: 'Enter text to encrypt',     
               border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
               ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _keyController,
              decoration:const InputDecoration(
              labelText: 'Secret Key',
               hintText: 'Enter secret key to be use for encryption and decryption',     
               border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
               ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    if (_keyController.text.isEmpty) {
                      _showSnackBar('Secret key cannot be empty');
                      return;
                    }
                    setState(() {
                      _encryptionKey = _keyController.text;
                      _encryptedText = encrypt(_textController.text, _keyController.text);
                    });
                  },
                  child: const Text('Encrypt'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    if (_keyController.text.isEmpty) {
                      _showSnackBar('Secret key cannot be empty');
                      return;
                    }
                    if (_keyController.text != _encryptionKey) {
                      _showSnackBar('Secret key does not match the encryption key');
                      return;
                    }
                    setState(() {
                      _decryptedText = decrypt(_encryptedText, _keyController.text);
                    });
                  },
                  child: const Text('Decrypt'),
                ),
              ],
            ),
            const SizedBox(height: 20),
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("🔐 Encrypted:", style:  TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color:Colors.green)),
                Text(" $_encryptedText",style:const TextStyle(fontSize:25,color: Colors.black,fontWeight: FontWeight.bold),)
           
              ],
            ),
            const SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              const Text("🔓 Decrypted:", style:  TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color:Colors.red)),
                Text(" $_decryptedText",style:const TextStyle(fontSize:25,color: Colors.black,fontWeight: FontWeight.bold),)
           
              ],
            ),
             
          ],
        ),
      ),
    );
  }
}
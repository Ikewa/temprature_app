import 'package:flutter/material.dart';

void main() {
  runApp(TempConversionApp());
}

class TempConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.red, // Red theme for the app
      ),
      home: TempConverter(),
    );
  }
}

class TempConverter extends StatefulWidget {
  @override
  _TempConverterState createState() => _TempConverterState();
}

class _TempConverterState extends State<TempConverter> {
  bool _isFtoC = true; // Flag to track selected conversion
  TextEditingController _inputController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  // Conversion functions
  double _fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  double _celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0;
      double convertedTemp = _isFtoC
          ? _fahrenheitToCelsius(input)
          : _celsiusToFahrenheit(input);
      _result = convertedTemp.toStringAsFixed(2);

      // Add to history
      String conversion = _isFtoC
          ? 'F to C: ${input.toStringAsFixed(1)} => $_result'
          : 'C to F: ${input.toStringAsFixed(1)} => $_result';
      _history.add(conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
        backgroundColor: Colors.red, // App bar color set to red
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('F to C'),
                Radio(
                  value: true,
                  groupValue: _isFtoC,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFtoC = value!;
                    });
                  },
                ),
                Text('C to F'),
                Radio(
                  value: false,
                  groupValue: _isFtoC,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFtoC = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background color (white)
                foregroundColor: Colors.red, // Button text color (red)
                side: BorderSide(color: Colors.red), // Button border color
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              _result.isEmpty ? 'Result' : 'Result: $_result',
              style: TextStyle(fontSize: 20, color: Colors.red), // Red result text
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _history[index],
                      style: TextStyle(color: Colors.red), // Red history text
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

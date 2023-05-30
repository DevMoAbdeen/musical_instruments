import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';

class AllMusicalInstruments extends StatefulWidget {
  const AllMusicalInstruments({Key? key}) : super(key: key);

  @override
  State<AllMusicalInstruments> createState() => _AllMusicalInstrumentsState();
}

class _AllMusicalInstrumentsState extends State<AllMusicalInstruments> {
  final _flutterMidi = FlutterMidi();

  var guitar = "assets/Best of Guitars-4U-v1.0.sf2";
  var flute = "assets/Expressive Flute SSO-v1.2.sf2";
  var piano = "assets/Yamaha-Grand-Lite-SF-v1.1.sf2";

  String _value = 'assets/Yamaha-Grand-Lite-SF-v1.1.sf2';

  void load(String asset) async {
    print('Loading File...');
    _flutterMidi.unmute();
    ByteData byte = await rootBundle.load(asset);

    _flutterMidi.prepare(sf2: byte, name: _value.replaceAll('assets/', ''));
  }

  @override
  void initState() {
    load(_value);
    super.initState();
  }

  void _play(int midi) {
    _flutterMidi.playMidiNote(midi: midi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Musical Instruments"),
        actions: [
          DropdownButton<String>(
            style: const TextStyle(color: Colors.white),
            dropdownColor: Colors.blue,
            value: _value,
            items: [
              DropdownMenuItem(
                value: piano,
                child: const Text("Piano", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              DropdownMenuItem(
                value: flute,
                child: const Text("Flute", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              DropdownMenuItem(
                value: guitar,
                child: const Text("Guitar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _value = value!;
                load(_value);
              });
            },
          ),
        ],
      ),
      body: Center(
          child: InteractivePiano(
            highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
            naturalColor: Colors.white,
            accidentalColor: Colors.black,
            keyWidth: 50,
            noteRange: NoteRange.forClefs([
              Clef.Treble,
            ]),
            onNotePositionTapped: (position) {
              _play(position.pitch);
            },
          ),
        ),
    );
  }
}

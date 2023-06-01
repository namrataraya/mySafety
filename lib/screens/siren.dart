import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//my imports
import '../helpers/custom_appbar.dart';
import '../helpers/custom_text.dart';
import '../helpers/strings.dart';
import '../helpers/colors.dart';

class Siren extends StatefulWidget {
  @override
  State<Siren> createState() => _SirenState();
}

class _SirenState extends State<Siren> {
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  AudioPlayer audioPlayer = AudioPlayer();
  String audioPath = 'assets/police_siren.wav';
  bool isPlaying = false;
  bool audioPlayed = false;
  late Uint8List audioBytes;

  @override
  void initState() {
    //convert ByteData to Uint8List
    Future.delayed(Duration.zero, () async {
      ByteData bytes =
          await rootBundle.load(audioPath); //load audio from assets
      audioBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

      //get the duration of audio
      audioPlayer.onDurationChanged.listen((Duration d) {
        maxduration = d.inMilliseconds;
        setState(() {});
      });
      audioPlayer.onAudioPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: txt_play_siren),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/Siren.png'),
            SizedBox(height: 30),
            Container(
                child: Slider(
              activeColor: primary_color,
              value: double.parse(currentpos.toString()),
              min: 0,
              max: double.parse(maxduration.toString()),
              divisions: maxduration,
              label: currentpostlabel,
              onChanged: (double value) async {
                int seekval = value.round();
                int result =
                    await audioPlayer.seek(Duration(milliseconds: seekval));
                if (result == 1) {
                  //seek successful
                  currentpos = seekval;
                } else {
                  print("Seek unsuccessful.");
                }
              },
            )),
            SizedBox(height: 20),
            Container(
              child: Wrap(
                spacing: 10,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: primary_color),
                      onPressed: () async {
                        if (!isPlaying && !audioPlayed) {
                          int result = await audioPlayer.playBytes(audioBytes);
                          if (result == 1) {
                            //play success
                            setState(() {
                              isPlaying = true;
                              audioPlayed = true;
                            });
                          } else {
                            print("Error while playing audio.");
                          }
                        } else if (audioPlayed && !isPlaying) {
                          int result = await audioPlayer.resume();
                          if (result == 1) {
                            //resume success
                            setState(() {
                              isPlaying = true;
                              audioPlayed = true;
                            });
                          } else {
                            print("Error on resume audio.");
                          }
                        } else {
                          int result = await audioPlayer.pause();
                          if (result == 1) {
                            //pause success
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            print("Error on pause audio.");
                          }
                        }
                      },
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      label: CustomText(
                          text: isPlaying ? txt_pause : txt_play,
                          color: Colors.white)),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: primary_color),
                    onPressed: () async {
                      int result = await audioPlayer.stop();
                      if (result == 1) {
                        //stop success
                        setState(() {
                          isPlaying = false;
                          audioPlayed = false;
                          currentpos = 0;
                        });
                      } else {
                        print("Error on stop audio.");
                      }
                    },
                    icon: Icon(Icons.stop),
                    label: CustomText(text: txt_stop, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: MyAppBar(text: txt_play_siren),
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Center(
    //         child: GestureDetector(
    //           child: Image.asset('images/Siren.png'),
    //           onTap: () {
    //             // **** play audio **** //
    //             playSiren();

    //             // *** show Dialog *** //
    //             showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   content: Row(
    //                     children: [
    //                       InkWell(
    //                         child: CustomText(text: "Play", color: Colors.blue),
    //                         onTap: () {
    //                           playSiren();
    //                         },
    //                       ),
    //                       Spacer(),
    //                       InkWell(
    //                         child:
    //                             CustomText(text: "Pause", color: Colors.blue),
    //                         onTap: () {
    //                           pauseSiren();
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //             );
    //           },
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       CustomText(text: txt_play_siren, size: 20),
    //     ],
    //   ),
    // );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

//my imports
import '../helpers/custom_text.dart';
import '../helpers/custom_appbar.dart';
import '../helpers/strings.dart';
import '../models/youtube_model.dart';



class SelfDefense extends StatefulWidget {
  @override
  State<SelfDefense> createState() => _SelfDefenseState();
}

class _SelfDefenseState extends State<SelfDefense> {
  late YoutubePlayerController _youtubePlayerController;
  // final String defenseLink =
  //     "https://www.youtube.com/playlist?list=PLLALQuK1NDrigB-xTBLJV4vZwOXfxbPnM";
  List<YoutubeModel> videoList = [
    YoutubeModel(id: 1, youtubeId: 'K5UO9zA3GK4'),
    YoutubeModel(id: 2, youtubeId: '7XI1uAdr_s4'),
    YoutubeModel(id: 3, youtubeId: 'fji463dsZXo'),
    YoutubeModel(id: 4, youtubeId: 'sY-P5GBwggU'),
    YoutubeModel(id: 5, youtubeId: 'SWScAnWcwKc'),
  ];


  @override
  void initState() {
    super.initState();
    setState(() {
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoList[0].youtubeId,
        params: YoutubePlayerParams(
          showFullscreenButton: true,
          autoPlay: false,
          mute: false,
          showControls: true,
          enableCaption: true,
          // playlist: playlistVideos,
        ),
      );
    });
    // WidgetsBinding.instance!.addPostFrameCallback((_) {

    // });

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _youtubePlayerController.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: txt_self_defense),
      body: SafeArea(
        child: Column(
          children: [
            _buildYtbView(),
            _buildMoreVideoTitle(),
            _buildMoreVideosView(),
          ],
        ),
      ),
    );
  }

  _buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayerIFrame(controller: _youtubePlayerController),
    );
  }

  _buildMoreVideoTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 182, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: txt_more_videos,
            size: 18,
          ),
        ],
      ),
    );
  }

  _buildMoreVideosView() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
          itemCount: videoList.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                final _newCode = videoList[index].youtubeId;
                _youtubePlayerController.load(_newCode);
                _youtubePlayerController.stop();
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                margin: EdgeInsets.symmetric(vertical: 7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://i3.ytimg.com/vi/${videoList[index].youtubeId}/maxresdefault.jpg",
                          // "https://img.youtube.com/vi/${videoList[index].youtubeId}/0.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/ytbPlayBotton.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    ));
  }

  //  _buildMoreVideosView() {
  //   return Expanded(
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 15),
  //       child: ListView.builder(
  //           itemCount: videoList.length,
  //           physics: AlwaysScrollableScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             return GestureDetector(
  //               onTap: () {
  //                 final _newCode = videoList[index].youtubeId;
  //                 _youtubePlayerController.load(_newCode);
  //                 _youtubePlayerController.stop();
  //               },
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height / 5,
  //                 margin: EdgeInsets.symmetric(vertical: 7),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(18),
  //                   child: Stack(
  //                     fit: StackFit.expand,
  //                     children: <Widget>[
  //                       Positioned(
  //                         child: Image.network("https://i.pinimg.com/564x/32/c8/ef/32c8efbc31deb819d63715bda98932ee.jpg",
  //                         fit: BoxFit.cover),
  //                         // child: NetworkImage(
  //                         //   url:
  //                         //       "https://i.pinimg.com/originals/32/c8/ef/32c8efbc31deb819d63715bda98932ee.jpg",
  //                         //   fit: BoxFit.cover,
  //                         // ),
  //                       ),
  //                       Positioned(
  //                         child: Align(
  //                           alignment: Alignment.center,
  //                           child: Image.asset(
  //                             'assets/ytbPlayBotton.png',
  //                             height: 30,
  //                             width: 30,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }),
  //     ),
  //   );
  // }
}

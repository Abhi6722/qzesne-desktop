import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qzense_automation/controllers/camera_controller.dart';
import 'package:qzense_automation/utils/constants.dart';
import 'package:qzense_automation/widgets/Loading.dart';
import 'package:watcher/watcher.dart';
import 'package:file_picker/file_picker.dart';

class PhotoWatcher extends StatefulWidget {
  @override
  _PhotoWatcherState createState() => _PhotoWatcherState();
}

class _PhotoWatcherState extends State<PhotoWatcher> {
  String? _watchedPath;
  late DirectoryWatcher _directoryWatcher;

  @override
  void initState() {
    super.initState();
    _selectWatchedFolder();
  }

  Future<void> _selectWatchedFolder() async {
    String? result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      setState(() {
        _watchedPath = result;
      });

      _initWatcher();
    }
  }

  void _initWatcher() {
    _directoryWatcher = DirectoryWatcher(_watchedPath!);
    _directoryWatcher.events.listen((event) {
      if (event.type == ChangeType.ADD) {
        _processNewFile(event.path);
      }
    });
  }

  void _processNewFile(String filePath) {
    debugPrint('New file added: $filePath');
    Get.find<MyCameraController>().getAutoResult(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCameraController>(
      builder: (controller) {
        if (controller.result.isNotEmpty) {
          // Show UI for displaying the result
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.primaryColor,
              centerTitle: true,
              title: Center(
                child: Text(
                  '${controller.model.toUpperCase()} MODEL',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  controller.resetResult();
                  Get.back();
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      if (controller.showLoading) ...[
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              top: MediaQuery.of(context).size.height / 4),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Loading(
                            msg: 'Loading...',
                            model: controller.mlModel,
                          ),
                        ),
                      ],
                      if (!controller.showLoading) ...[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: controller.buildImageWidget(context),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  '${controller.species} Species : ${controller.result}',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${controller.species} Detected : ${controller.numberOfFishes}',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Good ${controller.species} : ${controller.goodFishes}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Bad ${controller.species} : ${controller.badFishes}',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      color: Constants.primaryColor,
                      child: const Text(
                        "*Results are Only Indicative To Aid Consumers",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 45,
                  //   left: 0,
                  //   right: 0,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Get.back();
                  //     },
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       width: 90,
                  //       height: 90,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Constants.primaryColor,
                  //         border: Border.all(
                  //           color: Colors.white,
                  //           width: 3,
                  //         ),
                  //       ),
                  //       child: const Icon(
                  //         Icons.camera_alt,
                  //         color: Colors.white,
                  //         size: 40,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.primaryColor,
              centerTitle: true,
              title: Center(
                child: Text(
                  '${controller.model.toUpperCase()} MODEL',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  controller.resetResult();
                  Get.back();
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.showLoading) ...[
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        top: MediaQuery.of(context).size.height / 4),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Loading(
                      msg: 'Loading...',
                      model: controller.mlModel,
                    ),
                  ),
                ],
                if (!controller.showLoading) ...[
                  Center(
                    child: _watchedPath != null
                        ? Text('Watching $_watchedPath for new photos...')
                        : Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  35), // Half of the height to make it fully rounded
                              color: Constants.primaryColor,
                            ),
                            child: MaterialButton(
                              height: 70,
                              onPressed: _selectWatchedFolder,
                              child: Text(
                                'Select Folder to Watch',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                  ),
                ]
              ],
            ),
          );
        }
      },
    );
  }
}

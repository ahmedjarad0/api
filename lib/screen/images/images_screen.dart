
import 'package:api/get/image_getx_controller.dart';
import 'package:api/helpers/api_helper.dart';
import 'package:api/helpers/context_extention.dart';
import 'package:api/models/api_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageScreen extends StatelessWidget with ApiHelper {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Images'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/upload_image_screen');
                },
                icon: const Icon(Icons.camera_alt_outlined)),
          ],
        ),
        body: GetBuilder<ImageGetController>(
          init: ImageGetController(),
          builder: (controller) {
            if (controller.images.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(fit: StackFit.expand, children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: controller.images[index].imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.images[index].image,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteImage(context,index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade500,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'Empty Images',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              );
            }
          },
        ));
  }

  void deleteImage(BuildContext context, int index) async {
    ApiResponse apiResponse = await ImageGetController.to.deletedImage(index);
    context.showSnackBar(
        message: apiResponse.message, error: !apiResponse.success);
  }
}

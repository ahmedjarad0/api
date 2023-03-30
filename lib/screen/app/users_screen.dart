import 'package:api/api/auth_api_controller.dart';
import 'package:api/api/user_api_controller.dart';
import 'package:api/models/api_response.dart';
import 'package:api/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(onPressed: ()async{
            ApiResponse apiResponse = await AuthApiController().logout();
            if(apiResponse.success){
              Navigator.pushReplacementNamed(context,'/login_screen');

            }
          }, icon: Icon(Icons.logout_outlined)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/images_screen');
          }, icon: Icon(Icons.insert_photo_outlined)),

        ],
      ),
      body: FutureBuilder<List<User>>(
        future: UserApiController().getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(snapshot.data![index].image),
                  ),
                  title: Text(snapshot.data![index].firstName),
                  subtitle: Text(snapshot.data![index].email),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'NO DATA',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 22),
              ),
            );
          }
        },
      ),
    );
  }
}

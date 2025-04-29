import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo15/AdminScreens/createData.dart';
import 'package:demo15/Screens/Products.dart';
import 'package:demo15/Screens/Reset.dart';
import 'package:demo15/Screens/chatScreen.dart';
import 'package:demo15/Screens/login.dart';
import 'package:demo15/Screens/own_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
   home({super.key});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

    String user_id = '';


  Future getUser() async {
        //   Using Shared Prefrenes
        SharedPreferences userCredential = await SharedPreferences.getInstance();
        var Uemail = userCredential.getString('email');
        debugPrint('user Email: $Uemail');
        return Uemail;
  }

  @override
  void initState() {

      getUser().then((value) {
      setState(() {
        user_id = value;
      });
      // print('${user_id}');
    });
    AnalyticsEvents.logScreenView(screenName: 'HomeScreen', ScreenIndex: '1');
    super.initState();
  }


  final List<String> images = [
    'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/936611/pexels-photo-936611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/936611/pexels-photo-936611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/936611/pexels-photo-936611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];

    final TextEditingController userPrompt = TextEditingController();
    final List<Message> messages = [];
    final ScrollController _scrollController = ScrollController();


    void chatBot() async {
    final model = GenerativeModel(
      model: '',
      apiKey: '',
    );

    final prompt = userPrompt.text;
    setState(() {
      messages.add(Message(text: prompt, isUser: true));
    });
    userPrompt.clear();

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    String? userResponse = response.text;

    setState(() {
      messages.add(Message(text: userResponse ?? 'Error', isUser: false));
    });


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Home Page',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
                leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          )
        ],
       ),

       

     drawer: Drawer(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('usersinfo').where("email", isEqualTo: user_id).snapshots(),
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error'));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var Name = snapshot.data!.docs[index]['name'];
                  var Address = snapshot.data!.docs[index]['address'];
                  var Phone = snapshot.data!.docs[index]['phone'];
                  String pImage = snapshot.data!.docs[index]['image'];

                  // For accessing particular id  in firestore datbase

                  var data_id = snapshot.data!.docs[index].id;
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        child: const DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text(
                            'User Profile',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: '${snapshot.data!.docs[index]['image']}',
                          width: 140, // diameter = 2 * radius
                          height: 140,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        // leading: Icon(Icons.),
                        title: Text(
                          '${snapshot.data!.docs[index]['name']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.delivery_dining_outlined,
                          color: Colors.red[500],
                        ),
                        title: Text(
                          '${snapshot.data!.docs[index]['address']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        title: Text(
                          '${snapshot.data!.docs[index]['phone']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    
                      Container(
                        height: 34,
                        margin:
                        EdgeInsets.symmetric(horizontal: 36, vertical: 40),
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Metropolis'),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => update_current_User(
                      //                 id1: data_id,
                      //                 name1: Name,
                      //                address1: Address,
                      //                phone_number1: Phone,
                      //                img1: pImage,
                      //                payment_method1: Payment,
                      //             ),
                      //           ));
                      //     },
                      //     icon: Icon(
                      //       Icons.edit,
                      //       color: Colors.blue,
                      //     )),
                      Text('Update User Profile'),
                    ],
                  );
                },
              );
            }
            return Center(
              child: Container(
                child: Text('There is no Data Found'),
              ),
            );
          },
        ),
      ),




       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: CarouselSlider(
           items: images.map((imageUrl){
             return ClipRRect(
               borderRadius: BorderRadius.circular(15),
               child: Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity,),
             );
           }).toList(),
            options: CarouselOptions(
             height: MediaQuery.of(context).size.height * 0.3,
             autoPlay: true,
             enlargeCenterPage: true,
             aspectRatio: 16 / 9,
             autoPlayCurve: Curves.easeInOut,
             enableInfiniteScroll: true,
             autoPlayAnimationDuration: Duration(seconds: 1),
             viewportFraction: 0.8
            )
            ),
       ),



floatingActionButton: FloatingActionButton(onPressed: (){

       showModalBottomSheet(
         isScrollControlled: true,
         context: context, builder: (context) {
         return  StatefulBuilder(builder: (context, setState) {
           return SizedBox(
             height: 600,
             child: Column(
               children: [
                 Expanded(
                   child: ListView.builder(
                     controller: _scrollController,
                     reverse:
                     false,
                     itemCount: messages.length,
                     itemBuilder: (context, index) {
                       final message = messages[index];
                       return Align(
                         alignment: message.isUser
                             ? Alignment.centerRight
                             : Alignment.centerLeft,
                         child: Container(
                           margin:
                           const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                           padding: const EdgeInsets.symmetric(
                               vertical: 10, horizontal: 15),
                           decoration: BoxDecoration(
                             color: message.isUser
                                 ? Colors.white
                                 : Colors.grey[
                             800],
                             borderRadius: BorderRadius.only(
                               topLeft: const Radius.circular(15),
                               topRight: const Radius.circular(15),
                               bottomLeft:
                               message.isUser ? const Radius.circular(15) : Radius.zero,
                               bottomRight:
                               message.isUser ? Radius.zero : const Radius.circular(15),
                             ),
                           ),
                           child: Text(
                             message.text,
                             style: TextStyle(
                               color: message.isUser
                                   ? Colors.black
                                   : Colors.white,
                             ),
                           ),
                         ),
                       );
                     },
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Expanded(
                         child: TextField(
                           controller: userPrompt,
                           style: const TextStyle(
                               color: Colors.white
                           ),
                           decoration: InputDecoration(
                             hintText: 'Type your message...',
                             hintStyle:
                             TextStyle(color: Colors.grey[500]),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: BorderSide.none,
                             ),
                             filled: true,
                             fillColor:
                             Colors.grey[900],

                           ),
                         ),
                       ),
                       const SizedBox(width: 8),
                       IconButton(
                         icon: const Icon(Icons.send,
                             color: Colors.black),
                         onPressed: chatBot,
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           );
         },);
       },);

      },child: Container(
        width: 40 ,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green
        ),
        child: const Icon(Icons.rocket),
      )),
    



    );
  }
}                                                                                                                                             
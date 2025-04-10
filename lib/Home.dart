import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo15/Screens/Products.dart';
import 'package:demo15/Screens/Reset.dart';
import 'package:demo15/Screens/chatScreen.dart';
import 'package:demo15/Screens/login.dart';
import 'package:demo15/Screens/own_services.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class home extends StatefulWidget {
   home({super.key});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  void initState() {
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          )
        ],
       ),

       

       drawer: Drawer(
        shadowColor: Colors.grey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
            
              height: MediaQuery.of(context).size.height * 0.15,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue
                ),
                child: Center(child: Text("Profile Page",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),))
                ),
            ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home Page'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => home() ));
                },
                ),
                 ListTile(
                leading: Icon(Icons.edit),
                title: Text('Change Password'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetScreen() ));
                },
                ),
                 ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text('Your Cart'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetScreen() ));
                },
                ),
                  ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen() ));
                },
                ),

                ListTile(
                leading: Icon(Icons.logout),
                title: Text('Product Screen'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductScreen() ));
                },
                ),
          ],
        ),
       ) ,




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
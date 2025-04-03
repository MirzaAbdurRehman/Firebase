import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  final List<String> images = [
    'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/936611/pexels-photo-936611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/936611/pexels-photo-936611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Home Screen',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.orange,
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
    );
  }
}
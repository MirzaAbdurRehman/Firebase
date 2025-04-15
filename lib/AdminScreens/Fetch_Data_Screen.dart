import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Clotrhing_Fetch_Screen extends StatefulWidget {
  const Clotrhing_Fetch_Screen({super.key});

  @override
  State<Clotrhing_Fetch_Screen> createState() => _Clotrhing_Fetch_ScreenState();
}

class _Clotrhing_Fetch_ScreenState extends State<Clotrhing_Fetch_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Clothing Products',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child:  StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('ClothingData').snapshots(),
                 builder: (context, snapshot){
                  if(ConnectionState.waiting == snapshot.connectionState){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasError){
                    return Center(child: Text('Error Found!...'),);
                  }
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        var productName = snapshot.data!.docs[index]['productName'];
                        var productPrice  = snapshot.data!.docs[index]['productPrice'];
                        var productInfo = snapshot.data!.docs[index]['productInfo'];
                        var productDescription  = snapshot.data!.docs[index]['productDescription'];
                         
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Card(
  elevation: 6,
  shadowColor: Colors.grey.withOpacity(0.5),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Name',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          productName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Divider(height: 20, thickness: 1.2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Rs: ${productPrice}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Product Info',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          productInfo,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Description',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        Text(
          productDescription,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    ),
  ),
)

                          );
                      }
                      );
                  }
                  return Center(
                    child: Container(
                    child: Text('There is No Data Found yet!...'),
                    ),
                  );
                 }),
               ),
          ],
        ),
      ),
    );
  }
}
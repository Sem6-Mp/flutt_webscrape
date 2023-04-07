import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:webscrp/engine.dart';
import 'package:webscrp/new_book.dart';
import 'package:webscrp/rom.dart';

class Mangapage extends StatelessWidget {
  fetchMovies() async {
    var url;
    url = await http.get(Uri.parse(
        "https://ruchirr02.github.io/mangaapi/"),);
    return json.decode(url.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            // tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            onTabChange: (index){
              if ( index ==0 ){
               
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context)=>Mangapage(),
                    ),
                    );
          
              }
              else if ( index==1 ){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context)=>Enginepage(),
                    ),
                    );
              }
              else if ( index==2 ){
               Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context)=>RomaPage(),
                    ),
                    );
              }
             
              else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context)=>NewBook(),
                    ),
                    );
              }
            },
            tabs:const [
              
              GButton(
                icon: Icons.book,
                text: 'Manga',),
              GButton(
                icon: Icons.engineering,
                text: 'Engineering'),
              GButton(
                icon: Icons.heart_broken,
                text: 'Romance'),
              GButton(
                icon: Icons.question_mark,
                text: 'New Books',),
              
            ]
            ),
        ),
      ),
      backgroundColor: Color(0xff191826),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'MANGA',
          style: TextStyle(fontSize: 25.0, color: Color(0xfff43370)),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff191826),
      ),
      body: FutureBuilder(
          future: fetchMovies(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        height: 250,
                        alignment: Alignment.centerLeft,
                        child: Card(
                          child: Image.network(
                              snapshot.data[index]['image_link']),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                snapshot.data[index]["title"],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data[index]["author"],
                                style: TextStyle(color: Color(0xff868597)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 100,
                                child: Text(
                                  snapshot.data[index]["rating"],
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
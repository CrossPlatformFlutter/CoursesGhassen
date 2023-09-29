
import 'package:flutter/material.dart';
import 'package:ghassen_courses/List_Users.dart';

void main(){
 runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
       debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Courses() ,
    );
  }

}

class Courses extends StatefulWidget{
  const Courses({super.key});
  @override
  State<Courses> createState()=>_Courses();
}

class _Courses extends State<Courses>{

   String text="I'am Rich";
   int i=0;
   int selectedIndex=0;
   String navigation="Home";

   void increment(){  
    setState((){
        i++;
    });
   }

   void chnagerIndex(int index){
    setState(() {
      selectedIndex=index;
      switch(index){
        case 0:
        navigation="Home";break;
        case 1:
        navigation="List";break;
      }
    });
   }

   @override
   Widget build(BuildContext context){
     return Scaffold(
      backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 17, 26, 13),
          title:  Center(
            child: Text("$text",style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
            ),
          )
        ),
        body:Center(
        child:
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Visibility(visible: i<20 ? true : false,child:  Image.asset("images/diamond.png")),
             Text("$i",style: const TextStyle(fontSize: 20)),
             const SizedBox(height: 40),
             Text("Index : ${navigation}")
          ],
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed:increment,child:const Icon(Icons.plus_one),),
        drawer: const Drawer(
            child: Column(
              children: [
                DrawerHeader(child: Text("Ghassen")),
              ],
            ),
        ),
        // bottomNavigationBar: const BottomAppBar(
        //       height: 60,
        //       color: Colors.blue, 
        //       shape: CircularNotchedRectangle(),
        //       child:Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           Icon(Icons.home),
        //           Icon(Icons.home),
        //       ],)
        // ),
        bottomNavigationBar:  BottomNavigationBar(
          backgroundColor: Colors.blue,
          currentIndex: selectedIndex,
          onTap: chnagerIndex,
          items: <BottomNavigationBarItem>[
               BottomNavigationBarItem(icon:   Icon(Icons.home) ,label: "Home"),
               BottomNavigationBarItem(icon:  IconButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>ListUsers()));//Navigator
               },icon: const Icon(Icons.list),),label: "List")
        ]),
     );
   }
}
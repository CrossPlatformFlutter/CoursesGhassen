import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghassen_courses/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListUsers extends StatefulWidget{
  ListUsers();
  @override
  State<ListUsers> createState(){
     return _ListUsers();
    }
}

class _ListUsers extends State<ListUsers>{


 FlutterSecureStorage storage=new FlutterSecureStorage();

 List<User> users=[];

  @override
  void initState() {
    super.initState();
     getFromLocalStoreg();
  }
 
  void SetLocalStorge(val)async{
    final usersJson = jsonEncode(val);
    await storage.write(key: "users", value:usersJson);
  }

  void getFromLocalStoreg()async{
      final usersJson = await storage.read(key: "users");
       if(usersJson!=null){
         final userdecode=jsonDecode(usersJson);
        /* for(var user in userdecode){
            users.add(user);
         }*/
         setState(() {
            users=userdecode.map<User>((user)=>User.fromjson(user)).toList();
         });
       }
  }


void deleteUser(int id){
     User index=users.firstWhere((element) => element.id==id);
     if(index!=null){
            users.remove(index);
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User deleted"))
    );
    Navigator.of(context).pop();
    SetLocalStorge(users);
    getFromLocalStoreg();
     }
  
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("ListUsers"),),
      body:users.isEmpty ? Center(child: Text("User Vide")) : ListView.builder(itemCount: users.length,itemBuilder: (context,index){
         return Card(
          elevation: 5,
          color: Colors.white,
          child: ListTile(
                textColor: Colors.black,
                title: Text("${users[index].nom}"),
                subtitle: Text("${users[index].email}"),
                leading: Text("${users[index].id}"),
                trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                       showDialog(context: context, builder:(context){
                          return AlertDialog(
                              title: Text("DO YOU WANNA DELETE ${users[index].nom}"),
                              actions: [
                                Row(
                                  children: [
                                    ElevatedButton(onPressed:(){deleteUser(users[index].id);}, child: Text("confirm")),
                                    ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Close")),
                                  ],
                                )
                              ],
                          );
                       });
                    },
                    icon: const Icon(Icons.delete,color: Colors.red,),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit,color: Colors.yellow,),
                  ),
                ],
              ),
              ),
         );
      }),
    );
  }
}
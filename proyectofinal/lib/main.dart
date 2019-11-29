import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db=Firestore.instance;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstRoute(),
  )
  );
}

class FirstRoute extends StatelessWidget {

//  final txtMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
        length: 4,
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 7, 94, 89),
          title: Text('(NO)Whatsapp'),
          
          actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                  onPressed: (){

                  },
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){
                  
                },
              )
            ],

            bottom: TabBar(
              tabs: [
                Tab(child:Icon(Icons.camera_alt)),
                Tab(child: Text('CHATS', style: TextStyle(fontSize: 11.0))),
                Tab(child: Text('ESTADOS', style: TextStyle(fontSize: 11.0))),
                Tab(child: Text('LLAMADAS', style: TextStyle(fontSize: 11.0))),
              ]
            ),
          ),
          body:  
          TabBarView(
              children: <Widget> [
                Center(child:Text('Cámara')),
                ListView(
                   children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                        ListTile(
                          leading: Image.asset('assets/Yaranaika.jpeg', width:50),
                          title: Text('Yaranaika'),
                          subtitle: Column(
                            children: <Widget>[
                              Container(
                                child: Text('Aqui se debe mostrar el mensaje'),
                              ),
                            ],
                          ),
                          onTap: (){
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondRoute()));
                           },
                        ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                        ListTile(
                          leading: Image.asset('assets/Ashe.jpg', width:60),
                          title: Text('Ashe'),
                          subtitle: Column(
                             children: <Widget>[
                               Container(
                                 child: Text('Aqui se debe de mostrar el mensaje'),
                               ),
                             ],
                           ),
                           onTap: (){
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ThirdRoute()));
                           },
                         ),
                         ],
                       ),
                     ),
                   ]
                  ),
    
                  Center(child:Text(' Mugrosos estados ')),
                  Center(child:Text(' Mostrar llamadas ')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          backgroundColor: Colors.green,
          onPressed: (){
            /*Navigator.push(
              context,
               MaterialPageRoute(builder: (context) => SecondRoute()),
              );*/      
          },
        ),
        
        ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  final txtMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 94, 89),
        title: Text('Yaranaika'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
      ),
      
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: (){

          },
        ),
         IconButton(
          icon: Icon(Icons.call),
          onPressed: (){

          },
        ),
         IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){

          },
        ),
      ],
      ),
      body: StreamBuilder(
            stream: Firestore.instance.collection('contacto1').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Text('placeholder');
              return ListView(
                children: <Widget>[
                  Card(child: ListTile(title: Text(snapshot.data.documents[0]['mensaje']))),
                  Card(child: ListTile(title: Text(snapshot.data.documents[1]['mensaje']))),
                  Card(child: ListTile(title: Text(snapshot.data.documents[2]['mensaje']))),
                  Card(child: ListTile(title: Text(snapshot.data.documents[3]['mensaje']))),
                  Card(child: ListTile(title: Text(snapshot.data.documents[4]['mensaje']))),
                ],
              );
            }
          ),
          bottomNavigationBar: BottomAppBar(
          child: TextField(
            decoration: InputDecoration(
              labelText:'Escribe un mensaje',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              )
            ),
            controller: txtMessage,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          backgroundColor: Colors.green,
          onPressed: (){
            insertar1(txtMessage.text);
            txtMessage.text = ' ';
          },
        ),
      );
  }
}

class ThirdRoute extends StatelessWidget {

  final txtMessage = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 94, 89),
        title: Text('Ashe'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: (){

          },
        ),
         IconButton(
          icon: Icon(Icons.call),
          onPressed: (){

          },
        ),
         IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){

          },
        ),
      ],
      ),
      body:StreamBuilder(
            stream: Firestore.instance.collection('contacto2').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Text('placeholder');
              return ListView(
                children: <Widget>[
                  Card(child: ListTile(title: Text(snapshot.data.documents[0]['mensaje1']))),
                  Card(child: ListTile(title: Text(snapshot.data.documents[1]['mensaje1']))),
                  Card(child: ListTile(title: Text(snapshot.data.documents[2]['mensaje1']))),
                  Card(child: ListTile(title: Text(snapshot.data.documents[3]['mensaje1']))),
                ],
              );
            }
          ),
          bottomNavigationBar: BottomAppBar(
          child: TextField(
            decoration: InputDecoration(
              labelText:'Escribe un mensaje',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              )
            ),
            controller: txtMessage,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          backgroundColor: Colors.green,
          onPressed: (){
            insertar2(txtMessage.text);
            txtMessage.text = ' ';
          },
        ),
    );
  }
}

void insertar1(String mensaje)async{
  await db.collection("contacto1").add({'mensaje':mensaje});
}

void insertar2(String mensaje)async{
  await db.collection("contacto2").add({'mensaje1':mensaje});
}

void eliminar1() async{
  await db.collection('contacto1').document(' ').delete();
}





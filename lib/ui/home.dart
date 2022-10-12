import 'package:flutter/material.dart';
import 'package:sqlite/ui/entryform.dart';
import 'package:sqlite/models/contact.dart';
import 'package:sqlite/helpers/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Home extends StatefulWidget{
  const Home();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Contact> contactList = [];
  int id = 0;

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Database'),
    ),
    body: createListView(),
    floatingActionButton: FloatingActionButton(tooltip: 'Tambah Data', onPressed: () async {
      var contact = await navigateToEntryForm(context, Contact(id,'', ''));
      if (contact.name != '' && contact.phone != '') {
        addContact(contact);
        id++;
        var x = contact.id.toString();
        var y = contact.name;
        var z = contact.phone;
        print(" " + x + y + z);
        
        
      }
      },child: const Icon(Icons.add),
    ),
    );
  }


Future<Contact> navigateToEntryForm(
  BuildContext context, Contact contact) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return EntryForm(contact);
    }));
    return result;
  }

  ListView createListView(){
    //Textsyle textStyle = (Theme.of(context).textTheme.subtitle1).getTextStyle();
    return ListView.builder(
      itemCount: count, 
      itemBuilder: (BuildContext context, int index){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
          title: Text(
            contactList[index].name, 
            //style: textStyle,
          ),
          subtitle: Text(contactList[index].phone),
          trailing: GestureDetector(
            child: const Icon(Icons.delete),
            onTap: (){
              deleteContact(contactList[index]);
            },
          ),
          onTap: () async {
            var contact = await navigateToEntryForm(context, contactList[index]);
            if (contact.name != '' && contact.phone != '') {
              editContact(contact);
            }
          },
          ),
        );
      },
    );
  }

  void addContact(Contact object) async {
    int result = await DbHelper.insert(object);
     if (result > 0){
       updateListView();
    }
  }

    void editContact(Contact object) async {
    int result = await DbHelper.update(object);
    if (result > 0){
      updateListView();
    }
  }

    void deleteContact(Contact object) async {
    int result = await DbHelper.delete(object.id);
    if (result > 0){
      updateListView();
    }
  }

  void updateListView(){
    final Future<Database> dbFuture = DbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Contact>> contactListFuture = 
      DbHelper.getContactList();
      contactListFuture.then((contactList){
        setState((){
          this.contactList = contactList;
          count = contactList.length;
        });
      });
    });
  }

}

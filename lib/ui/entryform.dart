import 'package:flutter/material.dart';
import 'package:sqlite/models/contact.dart'; 

class EntryForm extends StatefulWidget{
  final Contact contact;

  const EntryForm(this.contact);

  @override
  // ignore: no_logic_in_create_state
  EntryFormState createState() => EntryFormState(contact);
}

class EntryFormState extends State<EntryForm> {
  Contact contact;
  EntryFormState(this.contact);

  int id= 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context){
    if (contact != null){
      nameController.text = contact.name;
      phoneController.text = contact.phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: contact == null ? Text('Tambah Data'):
                          Text('Ubah Data'),
        leading : Icon(Icons.keyboard_arrow_left), 
      ),
      body: Padding(
        padding: EdgeInsets.only(top:15.0, left:10.0, right:10.0),
        child: ListView(
          children: <Widget> [
            //nama
            Padding(
              padding: EdgeInsets.only(top:15.0, bottom:15.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'nama', 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value){
                  //
                },
              ),
            ),
            //nohp
            Padding(
              padding: const EdgeInsets.only(top:15.0, bottom: 15.0),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Nomor HP', 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value){
                  //
                },
              ),
            ),

            //tombol
            Padding(
              padding: const EdgeInsets.only(top:15.0, bottom: 15.0),
              child: Row(
                children: <Widget> [
                  //tombol simpan
                  Expanded(
                    child: ElevatedButton( // raisedButton usang
                     // color: Theme.of(context).primaryColorDark,
                     // textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        'simpan', 
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (contact == null){
                          //tambah data
                          contact = Contact(id,nameController.text, phoneController.text);
                        }else {
                          //ubah data
                          contact.name = nameController.text;
                          contact.phone = phoneController.text;
                        }
                        //kembali ke layar sebelumnya
                        //dengan membawa objek contact
                        Navigator.pop(context, contact);
                      },
                    ),
                  ),
                  Container(width: 5.0,), 
                  //tombal batal 
                  Expanded(
                    child: ElevatedButton( // raisedButton usang
                     // color: Theme.of(context).primaryColorDark,
                     // textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        'Batal', 
                        textScaleFactor: 1.5,
                    ),
                    onPressed:(){
                      Navigator.pop(context);
                    },
                  ),
                  ),],
              ),
            )

          ],
        ),
      ),
    );
  } 
}
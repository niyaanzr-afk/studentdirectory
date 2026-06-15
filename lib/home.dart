import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentdirectory/service.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController registernocontroller = TextEditingController();
  TextEditingController coursecontroller = TextEditingController();
  void editbox(DocumentSnapshot doc) {
    namecontroller.text = doc["NAME"];
    registernocontroller.text = doc["REGISTER NO"];
    coursecontroller.text = doc["COURSE"];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                hintText: "NAME",
                hintStyle: GoogleFonts.orbitron(
                  color: Colors.black,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: registernocontroller,
              decoration: InputDecoration(
                hintText: "REGISTER NO",
                hintStyle: GoogleFonts.orbitron(
                  color: Colors.black,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: coursecontroller,
              decoration: InputDecoration(
                hintText: "COURSE",
                hintStyle: GoogleFonts.orbitron(
                  color: Colors.black,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updatestudent(
                  namecontroller.text,
                  registernocontroller.text,
                  coursecontroller.text,
                  doc.id,
                  context,
                );
              },
              child: Text(
                "SUBMIT",
                style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xE4F7EDB0),
                foregroundColor: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getstudents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("No Data"));
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(tileColor: const Color(0xE4F7EDB0),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    trailing: Row(
                      mainAxisSize: .min,
                      children: [
                        IconButton(
                          onPressed: () {
                            editbox(data[index]);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deletestudent(data[index].id, context);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                    title: Text(
                      data[index]["NAME"],
                      style: GoogleFonts.orbitron(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          data[index]["REGISTER NO"],
                          style: GoogleFonts.orbitron(fontSize: 18),
                        ),
                        Text(
                          data[index]["COURSE"],
                          style: GoogleFonts.orbitron(fontSize: 18),
                        ),
                      ],
                    ),
                  
                ),
              );
            },
          );
        },
      ),
      backgroundColor: const Color.fromARGB(246, 251, 251, 250),
      appBar: AppBar(
        title: Text(
          "Student Directory",
          style: GoogleFonts.orbitron(fontSize: 20, fontWeight: .bold),
        ),
        backgroundColor: Color(0xE4F7EDB0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("ADD STUDENT"),
                content: Column(
                  mainAxisSize: .min,
                  children: [
                    TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: "NAME",
                        hintStyle: GoogleFonts.orbitron(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      controller: registernocontroller,
                      decoration: InputDecoration(
                        hintText: "REGISTER NO",
                        hintStyle: GoogleFonts.orbitron(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      controller: coursecontroller,
                      decoration: InputDecoration(
                        hintText: "COURSE",
                        hintStyle: GoogleFonts.orbitron(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addstudent(
                          namecontroller.text,
                          registernocontroller.text,
                          coursecontroller.text,
                          context,
                        );
                        namecontroller.clear();
                        registernocontroller.clear();
                        coursecontroller.clear();
                      },
                      child: Text(
                        "SUBMIT",
                        style: GoogleFonts.orbitron(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xE4F7EDB0),
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: const Color(0xE4F7EDB0),
      ),
    );
  }
}

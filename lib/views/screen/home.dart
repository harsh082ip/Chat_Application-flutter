import 'package:chat_application/controller/fetch_info_controller.dart';
import 'package:chat_application/views/widget/recent_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 26, 32, 44),
        elevation: 0,
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 35.0,
            fontFamily: 'Satisfy',
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 35,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 26, 32, 44),
            child: StreamBuilder<QuerySnapshot>(
              stream: Fetch_Info.profilePicStream(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No Items Found'),
                  );
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final item =
                        documents[index].data() as Map<String, dynamic>;
                    return Recent_Messages(
                      profile_pic_url: item['profileUrl'],
                      name: item['nickname'],
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

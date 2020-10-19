import 'package:flutter/material.dart';
import 'optionsTab.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'topicTile.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/services/database.dart';

class NewTopic extends StatefulWidget {
  @override
  _NewTopicState createState() => _NewTopicState();
}

class _NewTopicState extends State<NewTopic> {

  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<SSUser>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: darkGray,
        appBar: AppBar(
          backgroundColor: yellow,
          elevation: 0.0,
          title: Text('New Topic'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.code),),
              Tab(icon: Icon(Icons.remove_red_eye),),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 550,
            child: Stack(
              children: <Widget>[
                BgImage(top: 270),
                TabBarView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'Please enter a title' : null,
                              decoration: textInputDecoration.copyWith(hintText: 'Title'),
                              onChanged: (val) {
                                setState(() => title = val);
                              },
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'Please enter a description' : null,
                              decoration: textInputDecoration.copyWith(hintText: 'Description'),
                              keyboardType: TextInputType.multiline,
                              minLines: 15,
                              maxLines: 15,
                              onChanged: (val) {
                                setState(() => description = val);
                              },
                            ),
                            SizedBox(height: 30,),
                            RaisedButton.icon(
                              icon: Icon(
                                Icons.save, 
                                color: white
                              ),
                              color: yellow,
                              label: Text(
                                'Save',
                                style: TextStyle(color: white, fontSize: 18),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  DatabaseService(uid: user.uid).updateTopic(
                                    Topic(
                                      topicID: null,
                                      title: title,
                                      description: description,
                                      publishDate: null,
                                      deadline: null,
                                      creatorID: user != null ? user.uid : '',
                                      creatorUsername: user != null ? user.username : '',
                                      sparksCount: 0,
                                    )
                                  ).then((_) {
                                    Navigator.pop(context);
                                  });
                                };
                              },
                            ),
                          ]
                        )
                      )
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TopicTile(topic: Topic(
                        topicID: 'previewTopic',
                        title: title,
                        description: description,
                        publishDate: null,
                        deadline: null,
                        creatorID: user != null ? user.uid : '',
                        creatorUsername: user != null ? user.username : '',
                        sparksCount: 0,
                      )),
                    )
                  ],
                ),
              ],
            )
          )
        ),
        endDrawer: OptionsTab(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'components/optionsTab.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'components/topicTile.dart';
import 'package:smartsparks/models/dataModels.dart';

class NewTopicPage extends StatefulWidget {
  @override
  _NewTopicPageState createState() => _NewTopicPageState();
}

class _NewTopicPageState extends State<NewTopicPage> {

  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
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
                                _formKey.currentState.validate();
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
                        creatorID: '', //To be replaced with the current user's id
                        creatorUsername: '', //To be replaced with the current user's username
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
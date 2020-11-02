import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/services/database.dart';
import 'package:smartsparks/services/topicService.dart';
import 'components/optionsTab.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'components/sparkTile.dart';
import 'package:smartsparks/models/dataModels.dart';

class NewSparkPage extends StatelessWidget {

  final Topic parentTopic;
  NewSparkPage(this.parentTopic);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    return StreamProvider<SSUser>.value(
      value: DatabaseService(uid: user.uid).ssuser,
      child: NewSpark(parentTopic),
    );
  }
}

class NewSpark extends StatefulWidget {

  final Topic parentTopic;
  NewSpark(this.parentTopic);

  @override
  _NewSparkState createState() => _NewSparkState();
}

class _NewSparkState extends State<NewSpark> {

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
          title: Text('New Spark'),
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
                            Text(
                              "Topic: " + widget.parentTopic.title,
                              style: TextStyle(color: white, fontSize: 15),
                            ),
                            SizedBox(height: 15,),
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
                              minLines: 14,
                              maxLines: 14,
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
                                  TopicService(topicID: widget.parentTopic.topicID).createSpark(
                                    Spark(
                                      parentTopic: widget.parentTopic.topicID,
                                      sparkID: 'previewSpark',
                                      title: title,
                                      description: description,
                                      publishDate: null,
                                      creatorID: user != null ? user.uid : '',
                                      creatorRank: user != null ? user.rank : '',
                                      commentsCount: 0,
                                      voters: [],
                                    )
                                  ).then((_) {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                            ),
                          ]
                        )
                      )
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: SparkTile(spark: Spark(
                        parentTopic: widget.parentTopic.topicID,
                        sparkID: 'previewSpark',
                        title: title,
                        description: description,
                        publishDate: null,
                        creatorID: user != null ? user.uid : '',
                        creatorRank: user != null ? user.rank : '',
                        commentsCount: 0,
                        voters: [],
                      ), tapEnabled: false),
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
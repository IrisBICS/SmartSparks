import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/services/database.dart';
import 'package:smartsparks/services/sparkService.dart';
import 'components/optionsTab.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'components/commentTile.dart';
import 'package:smartsparks/models/dataModels.dart';

class NewCommentPage extends StatelessWidget {

  final Spark parentSpark;

  NewCommentPage({this.parentSpark});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    return StreamProvider<SSUser>.value(
      value: DatabaseService(uid: user.uid).ssuser,
      child: NewComment(parentSpark: parentSpark),
    );
  }
}

class NewComment extends StatefulWidget {

  final Spark parentSpark;
  NewComment({this.parentSpark});

  @override
  _NewCommentState createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {

  final _formKey = GlobalKey<FormState>();

  String title = '';
  String body = '';

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
          title: Text('New Comment'),
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
                              'Spark: ' + widget.parentSpark.title,
                              style: TextStyle(color: white, fontSize: 15,),
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
                              validator: (val) => val.isEmpty ? 'Please enter a body' : null,
                              decoration: textInputDecoration.copyWith(hintText: 'Body'),
                              keyboardType: TextInputType.multiline,
                              minLines: 12,
                              maxLines: 12,
                              onChanged: (val) {
                                setState(() => body = val);
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
                                if (_formKey.currentState.validate()) {}
                              },
                            ),
                          ]
                        )
                      )
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: CommentTile(comment: Comment(
                        commentID: 'previewComment',
                        parentSpark: widget.parentSpark.sparkID,
                        title: title,
                        body: body,
                        publishDate: '',
                        authorID: user != null ? user.uid : '',
                        authorRank: user != null ? user.rank : '',
                        likes: [],
                      ),),
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
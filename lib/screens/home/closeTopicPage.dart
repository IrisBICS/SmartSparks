import 'package:flutter/material.dart';
import 'package:smartsparks/services/userService.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'components/optionsTab.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:smartsparks/services/topicService.dart';
import 'components/iconCount.dart';


class CloseTopicPage extends StatelessWidget {

  final Topic topic;

  CloseTopicPage({this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('Close Topic'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Stack(
            children: <Widget>[
              BgImage(top: 320),
              SparksFormWrapper(topic: topic),
            ],
          )
        )
      ),
      endDrawer: OptionsTab(),
    );
  }
}

class SparksFormWrapper extends StatelessWidget {

  final Topic topic;

  SparksFormWrapper({this.topic});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Spark>>.value(
      value: TopicService(topicID: topic.topicID).sparks,
      child: SparksForm(topic: topic),
    );
  }
}

class SparksForm extends StatelessWidget {

  final Topic topic;

  SparksForm({this.topic});

  final List<Spark> selectedSparks = [];

  void addSelectedSpark(Spark newSpark) {
    selectedSparks.add(newSpark);
  }

  void removeSelectedSpark(Spark spark) {
    selectedSparks.removeWhere((element) => element.sparkID == spark.sparkID);
  }

  @override
  Widget build(BuildContext context) {

    final sparks = Provider.of<List<Spark>>(context);

    return Column( //Missing close button
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            topic.title,
            style: TextStyle(color: white, fontSize: 25)
          )
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text(
            'Please select 1-3 sparks',
            style: TextStyle(color: white)
          )
        ),
        Container(
          height: 390,
          child: SparksListView(sparks: sparks, addSelectedSpark: addSelectedSpark, removeSelectedSpark: removeSelectedSpark)
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: RaisedButton(
            color: yellow,
            child: Text(
              'Close',
              style: TextStyle(color: white, fontSize: 18),
            ),
            onPressed: () async {
              for (var spark in selectedSparks) {
                await UserService(uid: spark.creatorID).addPointsAndUpdateRank(0, 100);
                for (var voter in spark.voters) {
                  await UserService(uid: voter).addPointsAndUpdateRank(20, 0);
                }
              }
              await TopicService(topicID: topic.topicID).deleteTopic().then((_) {
                Navigator.pop(context);
              });
            },
          )
        )
      ],
    );
  }
}

class SparksListView extends StatelessWidget {

  final List<Spark> sparks;
  final Function addSelectedSpark;
  final Function removeSelectedSpark;

  SparksListView({this.sparks, this.addSelectedSpark, this.removeSelectedSpark});

  @override
  Widget build(BuildContext context) {
    return sparks != null && sparks.length != 0 ? ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: sparks.length,
      itemBuilder: (BuildContext context, int index) {
        return SparkBanner(spark: sparks[index], addSelectedSpark: addSelectedSpark, removeSelectedSpark: removeSelectedSpark);
      }
    ): Center(
      child: Text(
        "No sparks for this topic...",
        style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SparkBanner extends StatefulWidget {

  final Spark spark;
  final Function addSelectedSpark;
  final Function removeSelectedSpark;

  SparkBanner({this.spark, this.addSelectedSpark, this.removeSelectedSpark});

  @override
  _SparkBannerState createState() => _SparkBannerState();
}

class _SparkBannerState extends State<SparkBanner> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? yellow : lightGray.withAlpha(180),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        title: Text(widget.spark.title),
        trailing: IconCount(count: widget.spark.voters.length, icon: Icons.arrow_upward, textColor: black, iconColor: black,),
        onTap: () {
          isSelected ? widget.removeSelectedSpark(widget.spark) : widget.addSelectedSpark(widget.spark);
          setState(() => isSelected = !isSelected);
        },
      ),
    );
  }
}
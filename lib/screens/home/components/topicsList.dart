import 'package:flutter/material.dart';
import 'topicTile.dart';
import 'package:smartsparks/models/dataModels.dart';

class TopicsList extends StatefulWidget {
  @override
  _TopicsListState createState() => _TopicsListState();
}

class _TopicsListState extends State<TopicsList> {

  final Topic sampleTopic = Topic(
    creatorID: 'C123',
    creatorUsername: 'Admin 1',
    topicID: 'T123',
    title: 'Sample topic',
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lacinia nisl, sit amet malesuada leo sagittis eget. Aenean maximus convallis lacus, eu ultrices enim convallis ut. Pellentesque sit amet lectus vitae lacus pellentesque consequat at ac augue. Sed efficitur quam a erat pretium, et lacinia dolor bibendum. Fusce eu enim vitae est tristique tincidunt. Integer mattis dolor a est aliquet, ut venenatis mauris faucibus. Fusce ac felis nec urna pharetra lobortis sit amet vel mi. Vivamus ante nisl, hendrerit gravida dolor ac, consequat pretium mi. Fusce scelerisque mollis leo sed malesuada.

Praesent a velit in lectus dictum scelerisque. Sed ultrices vehicula lorem ultricies cursus. Nunc urna ligula, pulvinar eget erat ut, pellentesque imperdiet est. Praesent blandit, lorem sed dictum vestibulum, ex mauris vulputate erat, et imperdiet massa lorem quis mi. Vivamus bibendum id turpis nec viverra. Ut venenatis mi sed massa sollicitudin, non commodo odio maximus. Sed convallis nec mauris eget feugiat. In lacinia massa ac augue pharetra facilisis. Proin efficitur tincidunt faucibus. Nullam vel eleifend dui.
  
Pellentesque non sem fermentum, consequat leo sit amet, pretium odio. Phasellus elementum cursus neque, at euismod risus vestibulum sit amet. Nullam leo sapien, placerat ut aliquam quis, elementum non lorem. Duis varius ligula ac eros condimentum pellentesque. Sed non nisi rhoncus, sodales metus vel, pharetra libero. Nam hendrerit metus velit, at egestas lacus pretium ut. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras vel convallis diam. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse potenti.
  ''',
  publishDate: '24/08/2020',
  deadline: '10/01/2021',
  sparksCount: 12,
  );

  //Get topics data from firebase

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.horizontal,
      itemCount: 5, //Count of all topics
      itemBuilder: (BuildContext context, int index) {
        return TopicTile(topic: sampleTopic); //Pass in topics data
      },
    );
  }
}
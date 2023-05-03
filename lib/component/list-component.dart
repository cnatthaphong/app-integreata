import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String namePath;
  final void Function() function;
  ListCard(
      {required this.title,
      required this.namePath,
      required this.function,
      Key? key})
      : super(key: key);
  Widget showImage() {
    if (this.namePath != '' && this.namePath == 'test') {
      return Container(
          margin: EdgeInsets.fromLTRB(0, 10, 5, 10),
          width: 100,
          height: 100,
          child: Image(
              image: NetworkImage(
                  "https://pbs.twimg.com/profile_images/1372236547685158915/Ux6CW6Mx_400x400.jpg")));
    } else if (this.namePath != '') {
      return Container(
          margin: EdgeInsets.fromLTRB(0, 10, 5, 10),
          width: 100,
          height: 100,
          child: Image(
              image: NetworkImage(
                  "http://integreata.com/shared/icons/Discipline/" +
                      this.namePath)));
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      color: Colors.blueGrey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Row(
                children: <Widget>[
                  showImage(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.black87),
                  )
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}

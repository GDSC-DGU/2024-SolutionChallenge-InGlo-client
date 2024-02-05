import 'package:flutter/material.dart';
import 'package:inglo/screens/issuelist/widgets/sdgs_list.dart';

class SDGSSelectPage extends StatelessWidget {
  const SDGSSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        title: const Text("choose SDGs", style: TextStyle(color: Color(0xFF233A66), fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFFF7EEDE),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline, size: 30,),
            tooltip: 'Show Snackbar', // icon 설명 tooltip
            onPressed: () {
              // 클릭하면 메시지를 띄운다.
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('which purpose you want solve?')));
            },
          ),
    ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: SDGSList(),
        ),
      ),
    );
  }
}

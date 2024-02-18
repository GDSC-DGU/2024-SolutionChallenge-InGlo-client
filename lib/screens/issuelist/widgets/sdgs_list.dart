import 'package:flutter/material.dart';
import 'package:inglo/screens/problem_definition/problem_definition.dart';

// 더미데이터
final List<Map<String, String>> itemData = [
  {"title": "1. No Poverty", "image": "assets/image/sdgs/sdgs1.png"},
  {"title": "2. Zero Hunger", "image": "assets/image/sdgs/sdgs2.png"},
  {"title": "3. Good Health And Well-Being", "image": "assets/image/sdgs/sdgs3.png"},
  {"title": "4. Quality Education", "image": "assets/image/sdgs/sdgs4.png"},
  {"title": "5. Gender Equality", "image": "assets/image/sdgs/sdgs5.png"},
  {"title": "6. Clean Water And Sanitation", "image": "assets/image/sdgs/sdgs6.png"},
  {
    "title": "7. Affordable And Clean Energy",
    "image": "assets/image/sdgs/sdgs7.png"
  },
  {
    "title": "8. Decent Work And Economic Growth",
    "image": "assets/image/sdgs/sdgs8.png"
  },
  {
    "title": "9. Industry, Innovation And Infrastructure",
    "image": "assets/image/sdgs/sdgs9.png"
  },
  {"title": "10. Reduced Inequalities", "image": "assets/image/sdgs/sdgs10.png"},
  {
    "title": "11. Sustainable Cities And Communities",
    "image": "assets/image/sdgs/sdgs11.png"
  },
  {
    "title": "12. Responsible Consumption And Production",
    "image": "assets/image/sdgs/sdgs12.png"
  },
  {"title": "13. Clime Action", "image": "assets/image/sdgs/sdgs13.png"},
  {"title": "14. Life Below Water", "image": "assets/image/sdgs/sdgs14.png"},
  {"title": "15. Life On Land", "image": "assets/image/sdgs/sdgs15.png"},
  {
    "title": "16. Peace, Justice And Strong Institutions",
    "image": "assets/image/sdgs/sdgs16.png"
  },
  {
    "title": "17. Partnerships For The Goals",
    "image": "assets/image/sdgs/sdgs17.png"
  },
];

class SDGSList extends StatelessWidget {
  const SDGSList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      itemCount: itemData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProblemDefinitionPage(),
                settings: RouteSettings(
                  arguments: index + 1,
                ),
              ),
            );
          }
          ,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(itemData[index]["image"]!),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}

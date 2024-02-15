import 'package:flutter/material.dart';
import 'package:inglo/screens/problem_definition/problem_definition.dart';

// 더미데이터
final List<Map<String, String>> itemData = [
  {"title": "1. No Poverty", "image": "assets/image/sdgs1.png"},
  {"title": "2. Zero Hunger", "image": "assets/image/sdgs2.png"},
  {"title": "3. Good Health And Well-Being", "image": "assets/image/sdgs2.png"},
  {"title": "4. Quality Education", "image": "assets/image/sdgs2.png"},
  {"title": "5. Gender Equality", "image": "assets/image/sdgs2.png"},
  {"title": "6. Clean Water And Sanitation", "image": "assets/image/sdgs2.png"},
  {
    "title": "7. Affordable And Clean Energy",
    "image": "assets/image/sdgs2.png"
  },
  {
    "title": "8. Decent Work And Economic Growth",
    "image": "assets/image/sdgs2.png"
  },
  {
    "title": "9. Industry, Innovation And Infrastructure",
    "image": "assets/image/sdgs2.png"
  },
  {"title": "10. Reduced Inequalities", "image": "assets/image/sdgs2.png"},
  {
    "title": "11. Sustainable Cities And Communities",
    "image": "assets/image/sdgs2.png"
  },
  {
    "title": "12. Responsible Consumption And Production",
    "image": "assets/image/sdgs2.png"
  },
  {"title": "13. Clime Action", "image": "assets/image/sdgs2.png"},
  {"title": "14. Life Below Water", "image": "assets/image/sdgs2.png"},
  {"title": "15. Life On Land", "image": "assets/image/sdgs2.png"},
  {
    "title": "16. Peace, Justice And Strong Institutions",
    "image": "assets/image/sdgs2.png"
  },
  {
    "title": "17. Partnerships For The Goals",
    "image": "assets/image/sdgs2.png"
  },
];

class SDGSList extends StatelessWidget {
  const SDGSList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                builder: (context) => const ProblemDefinitionPage(),
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

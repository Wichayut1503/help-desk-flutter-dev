import 'package:flutter/material.dart';
import 'package:flutter_application_1/style/colors.dart';

class CustomCategoriesList extends StatefulWidget {
  final Function(String) onCategorySelected;
  const CustomCategoriesList({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  State<CustomCategoriesList> createState() => _CustomCategoriesListState();
}

class _CustomCategoriesListState extends State<CustomCategoriesList> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              menuButton(
                onTap: () {
                  setState(() {
                    _index = 0;
                  });
                  widget.onCategorySelected("");
                },
                color: _index == 0 ? primary : form,
                text: "All",
                textColor: _index == 0 ? Colors.white : SecondaryText,
                width: _index == 0 ? 65 : 85,
              ),
              menuButton(
                  onTap: () {
                    setState(() {
                      _index = 1;
                    });
                    widget.onCategorySelected("1");
                  },
                  color: _index == 1 ? primary : form,
                  text: "Admin",
                  textColor: _index == 1 ? Colors.white : SecondaryText,
                  width: _index == 1 ? 85 : 85),
              menuButton(
                  onTap: () {
                    setState(() {
                      _index = 2;
                    });
                    widget.onCategorySelected("2");
                  },
                  color: _index == 2 ? primary : form,
                  text: "Client",
                  textColor: _index == 2 ? Colors.white : SecondaryText,
                  width: _index == 2 ? 85 : 85),
              menuButton(
                  onTap: () {
                    setState(() {
                      _index = 3;
                    });
                    widget.onCategorySelected("3");
                  },
                  color: _index == 3 ? primary : form,
                  text: "Operator",
                  textColor: _index == 3 ? Colors.white : SecondaryText,
                  width: _index == 3 ? 85 : 85),
              menuButton(
                  onTap: () {
                    setState(() {
                      _index = 4;
                    });
                    widget.onCategorySelected("4");
                  },
                  color: _index == 4 ? primary : form,
                  text: "Development",
                  textColor: _index == 4 ? Colors.white : SecondaryText,
                  width: _index == 4 ? 115 : 115),
              menuButton(
                  onTap: () {
                    setState(() {
                      _index = 5;
                    });
                    widget.onCategorySelected("7");
                  },
                  color: _index == 5 ? primary : form,
                  text: "Customer",
                  textColor: _index == 5 ? Colors.white : SecondaryText,
                  width: _index == 5 ? 85 : 85),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuButton({
    required String text,
    required Color color,
    required Color textColor,
    required double width,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
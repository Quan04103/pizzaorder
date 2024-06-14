import 'package:flutter/material.dart';

class DeliveryOptionItem extends StatelessWidget {
  final String title;
  final String time;
  final String price;
  final String description;
  final String selectedOption;
  final void Function(String) onSelected;

  const DeliveryOptionItem({
    super.key,
    required this.title,
    required this.time,
    required this.price,
    this.description = '',
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedOption == title;

    return TextButton(
      onPressed: () {
        onSelected(title);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.grey.withOpacity(0.2);
          }
          return null;
        }),
        overlayColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey.withOpacity(0.9);
          }
          return null;
        }),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF000000)),
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? const Color.fromARGB(255, 149, 225, 183)
              : const Color(0xFFF3F3F3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color:
                            isSelected ? Colors.white : const Color(0xFF000000),
                      ),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color:
                          isSelected ? Colors.white : const Color(0xFF000000),
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color:
                          isSelected ? Colors.white : const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
              if (description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 10,
                    color: isSelected ? Colors.white : const Color(0xFF000000),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

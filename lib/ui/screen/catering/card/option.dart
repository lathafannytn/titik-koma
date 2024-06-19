import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionCard extends StatefulWidget {
  final String uuid;
  final String name;
  final num price;
  final String description;
  final dynamic stock;
  final Function(bool) onToggle;

  OptionCard({
    required this.uuid,
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.onToggle,
  });

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool isChecked = false;
  String cupSize = 'Hot';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDetailsModal(context);
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: Icon(
                  Icons.image,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Rp ${widget.price.toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isChecked = !isChecked;
                    widget.onToggle(isChecked);
                  });
                },
                icon: Icon(
                  isChecked
                      ? Icons.check_circle_outline
                      : Icons.radio_button_unchecked,
                  color: isChecked ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        bool localChecked = isChecked;
        String localCupSize = cupSize;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Cup Size',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: Text('Hot'),
                        selected: localCupSize == 'Hot',
                        onSelected: (bool selected) {
                          setState(() {
                            localCupSize = 'Hot';
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: Text('Cold'),
                        selected: localCupSize == 'Cold',
                        onSelected: (bool selected) {
                          setState(() {
                            localCupSize = 'Cold';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Rp ${widget.price.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        localChecked = !localChecked;
                      });
                      Navigator.pop(context);
                      setState(() {
                        isChecked = localChecked;
                        cupSize = localCupSize;
                        widget.onToggle(isChecked);
                      });
                    },
                    icon: Icon(
                      localChecked
                          ? Icons.check_circle_outline
                          : Icons.radio_button_unchecked,
                      color: localChecked ? Colors.blue : Colors.grey,
                      size: 40,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

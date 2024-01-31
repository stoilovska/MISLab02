import 'package:flutter/material.dart';
import 'package:lab02_teodora_stoilovska/model/clothes.dart';

// Teodora Stoilovska 201076

void main() {
  runApp(
    const MaterialApp(
      title: 'Lab02 Teodora Stoilovska 201076',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Clothes> clothesList = [];
  String currentTypeAdd = 'Shirt';
  String currentColorAdd = 'Red';
  String currentTypeEdit = '';
  String currentColorEdit = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothes App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clothes App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => _showAddClothesDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Add New Clothes',
                  style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 20),
            const Text('All Clothes:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            Expanded(
              child: ListView.builder(
                itemCount: clothesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${clothesList[index].type} - ${clothesList[index].color}',
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 18)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditClothesDialog(index),
                          color: Colors.green,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteClothes(index),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddClothesDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Clothes'),
          content: Column(
            children: [
              _buildTypeDropdown(currentTypeAdd),
              _buildColorDropdown(currentColorAdd),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                _addClothes();
                Navigator.pop(context);
              },
              child: const Text('Confirm',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currentTypeAdd) {
            currentTypeAdd = value!;
          } else if (currentValue == currentTypeEdit) {
            currentTypeEdit = value!;
          }
        });
      },
      items: [
        'Boots',
        'Shirt',
        'Jeans',
        'Dress',
        'Hat',
        'Coat',
        'Gloves',
        'Trousers'
      ].map<DropdownMenuItem<String>>((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Type', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  Widget _buildColorDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currentColorAdd) {
            currentColorAdd = value!;
          } else if (currentValue == currentColorEdit) {
            currentColorEdit = value!;
          }
        });
      },
      items: [
        'Red',
        'Brown',
        'Blue',
        'Green',
        'Yellow',
        'Black',
        'White',
        'Orange'
      ].map<DropdownMenuItem<String>>((String color) {
        return DropdownMenuItem<String>(
          value: color,
          child: Text(color),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Color', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  void _addClothes() {
    if (currentTypeAdd.isNotEmpty && currentColorAdd.isNotEmpty) {
      setState(() {
        clothesList.add(Clothes(type: currentTypeAdd, color: currentColorAdd));
      });
    }
  }

  void _showEditClothesDialog(int index) {
    currentTypeEdit = clothesList[index].type;
    currentColorEdit = clothesList[index].color;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Clothes'),
          content: Column(
            children: [
              _buildTypeDropdown(currentTypeEdit),
              _buildColorDropdown(currentColorEdit),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                _editClothes(index);
                Navigator.pop(context);
              },
              child: const Text('Save',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editClothes(int index) {
    if (currentTypeEdit.isNotEmpty && currentColorEdit.isNotEmpty) {
      setState(() {
        clothesList[index].type = currentTypeEdit;
        clothesList[index].color = currentColorEdit;
      });
    }
  }

  void _deleteClothes(int index) {
    setState(() {
      clothesList.removeAt(index);
    });
  }
}

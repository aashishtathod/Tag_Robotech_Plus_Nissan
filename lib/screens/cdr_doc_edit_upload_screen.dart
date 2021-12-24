import 'dart:io';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:robotech/res/cdr_widgets.dart';
import 'package:robotech/res/constants.dart';
import 'package:robotech/res/custom_colors.dart';
import 'package:robotech/screens/cdr_screen.dart';

class CdrDocEditScreen extends StatefulWidget {
  late String dealerCode, vin, password;
  late int id;

  CdrDocEditScreen({
    Key? key,
    required this.vin,
    required this.id,
    required this.dealerCode,
    required this.password,
  }) : super(key: key);

  @override
  _CdrDocEditScreenState createState() => _CdrDocEditScreenState();
}

class _CdrDocEditScreenState extends State<CdrDocEditScreen> {
  bool one = false,
      two = false,
      three = false,
      four = false,
      five = false,
      all = false;

  late bool ok1, ok2, ok3, ok4, ok5;

  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile1;
  File? _selectedFile1;
  PickedFile? _imageFile2;
  File? _selectedFile2;
  PickedFile? _imageFile3;
  File? _selectedFile3;
  PickedFile? _imageFile4;
  File? _selectedFile4;
  PickedFile? _imageFile5;
  File? _selectedFile5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.vin,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            createCard1("Customer Booking Form"),
            createCard2("DMS Retail Invoice"),
            createCard3("Dms Gate Pass"),
            createCard4("Proof Of Payment"),
            createCard5("Registration Document"),
            createButtons(context),
          ],
        ),
      ),
    );
  }

  Future buttonClicked() async {
    if (all) {
      ok1 = true;
      ok2 = true;
      ok3 = true;
      ok4 = true;
      ok5 = true;
    } else {
      if (one) {
        _selectedFile1 != null ? ok1 = true : ok1 = false;
      } else {
        ok1 = true;
        _selectedFile1 == null;
      }

      if (two) {
        _selectedFile2 != null ? ok2 = true : ok2 = false;
      } else {
        ok2 = true;
        _selectedFile2 == null;
      }

      if (three) {
        _selectedFile3 != null ? ok3 = true : ok3 = false;
      } else {
        ok3 = true;
        _selectedFile3 == null;
      }

      if (four) {
        _selectedFile4 != null ? ok4 = true : ok4 = false;
      } else {
        ok4 = true;
        _selectedFile4 == null;
      }

      if (five) {
        _selectedFile5 != null ? ok5 = true : ok5 = false;
      } else {
        ok5 = true;
        _selectedFile5 == null;
      }
    }

    if (ok1 && ok2 && ok3 && ok4 && ok5) {
      createSnackBar("Uploading data, please wait !");

      try {
        var data = {
          "customer_booking_form": (one) ? "Yes" : "No",
          "DMS_retail_inv": (two) ? "Yes" : "No",
          "DMS_gate_pass": (three) ? "Yes" : "No",
          "payment_prof": (four) ? "Yes" : "No",
          "registration_document": (five) ? "Yes" : "No",
          "username": widget.dealerCode.toString(),
          "password": widget.password.toString(),
          "id": widget.id.toString(),
        };

        var response = await http.post(
          Uri.parse(postCdrData),
          body: data,
        );

        if (response.statusCode == 200) {
          showAlertDialog(context, "Success", "Data uploaded successfully.");
        }
      } catch (e) {
        print(e);
        createSnackBar("Failed to upload data.");
      }
    } else {
      createSnackBar("Please upload the required images , or make particular one  \"No\".");
    }
    //return null;
  }

  createCard1(String doc) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              createText2(doc),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Text("Toggle Button"),
                  Column(
                    children: [
                      CustomSwitch(
                          activeColor: kPrimaryColor,
                          value: one,
                          onChanged: (value) {
                            setState(() {
                              one = value;
                              if (one && two && three && four && five) {
                                all = true;
                              } else {
                                all = false;
                              }
                            });
                          })
                    ],
                  ),
                  Visibility(
                    visible: (!all && one),
                    child: InkWell(
                      onTap: () async {
                        try {
                          _imageFile1 = (await _picker.getImage(
                              source: ImageSource.camera))!;

                          setState(() {
                            if (_imageFile1 != null) {
                              _selectedFile1 = File(_imageFile1!.path);
                            }
                          });
                        } catch (e) {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: (_selectedFile1 == null)
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )
                            : Image(
                                image: FileImage(_selectedFile1!),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  createCard2(String doc) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              createText2(doc),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Text("Toggle Button"),
                  Column(
                    children: [
                      CustomSwitch(
                          activeColor: kPrimaryColor,
                          value: two,
                          onChanged: (value) {
                            setState(() {
                              two = value;
                              if (one && two && three && four && five) {
                                all = true;
                              } else {
                                all = false;
                              }
                            });
                          })
                    ],
                  ),
                  Visibility(
                    visible: (!all && two),
                    child: InkWell(
                      onTap: () async {
                        try {
                          _imageFile2 = (await _picker.getImage(
                              source: ImageSource.camera))!;

                          setState(() {
                            if (_imageFile2 != null) {
                              _selectedFile2 = File(_imageFile2!.path);
                            }
                          });
                        } catch (e) {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: (_selectedFile2 == null)
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )
                            : Image(
                                image: FileImage(_selectedFile2!),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  createCard3(String doc) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              createText2(doc),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Text("Toggle Button"),
                  Column(
                    children: [
                      CustomSwitch(
                          activeColor: kPrimaryColor,
                          value: three,
                          onChanged: (value) {
                            setState(() {
                              three = value;
                              if (one && two && three && four && five) {
                                all = true;
                              } else {
                                all = false;
                              }
                            });
                          })
                    ],
                  ),
                  Visibility(
                    visible: (!all && three),
                    child: InkWell(
                      onTap: () async {
                        try {
                          _imageFile3 = (await _picker.getImage(
                              source: ImageSource.camera))!;

                          setState(() {
                            if (_imageFile3 != null) {
                              _selectedFile3 = File(_imageFile3!.path);
                            }
                          });
                        } catch (e) {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: (_selectedFile3 == null)
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )
                            : Image(
                                image: FileImage(_selectedFile3!),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  createCard4(String doc) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              createText2(doc),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Text("Toggle Button"),
                  Column(
                    children: [
                      CustomSwitch(
                          activeColor: kPrimaryColor,
                          value: four,
                          onChanged: (value) {
                            setState(() {
                              four = value;
                              if (one && two && three && four && five) {
                                all = true;
                              } else {
                                all = false;
                              }
                            });
                          })
                    ],
                  ),
                  Visibility(
                    visible: (!all && four),
                    child: InkWell(
                      onTap: () async {
                        try {
                          _imageFile4 = (await _picker.getImage(
                              source: ImageSource.camera))!;

                          setState(() {
                            if (_imageFile4 != null) {
                              _selectedFile4 = File(_imageFile4!.path);
                            }
                          });
                        } catch (e) {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: (_selectedFile4 == null)
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )
                            : Image(
                                image: FileImage(_selectedFile4!),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  createCard5(String doc) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              createText2(doc),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Text("Toggle Button"),
                  Column(
                    children: [
                      CustomSwitch(
                          activeColor: kPrimaryColor,
                          value: five,
                          onChanged: (value) {
                            setState(() {
                              five = value;
                              if (one && two && three && four && five) {
                                all = true;
                              } else {
                                all = false;
                              }
                            });
                          })
                    ],
                  ),
                  Visibility(
                    visible: (!all && five),
                    child: InkWell(
                      onTap: () async {
                        try {
                          _imageFile5 = (await _picker.getImage(
                              source: ImageSource.camera))!;

                          setState(() {
                            if (_imageFile5 != null) {
                              _selectedFile5 = File(_imageFile5!.path);
                            }
                          });
                        } catch (e) {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: (_selectedFile5 == null)
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )
                            : Image(
                                image: FileImage(_selectedFile5!),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  showAlertDialog(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CDRScreen(
                  dealerCode: widget.dealerCode, password: widget.password);
            },
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),

      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget createButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                "Cancel",
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                buttonClicked();
              },
              child: const Text(
                "Submit",
              )),
        ),
      ],
    );
  }

  createSnackBar(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

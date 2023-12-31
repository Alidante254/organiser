import 'package:Organiser/models/sub_collections/event_model.dart';
import 'package:Organiser/widgets/form_items/buttons.dart';
import 'package:Organiser/widgets/form_items/dropdown.dart';
import 'package:Organiser/widgets/form_items/location_card.dart';
import 'package:Organiser/widgets/form_items/pickers.dart';
import 'package:Organiser/widgets/form_items/tag_chips.dart';
import 'package:Organiser/widgets/form_items/textfields.dart';
import 'package:flutter/material.dart';
import 'package:Organiser/models/sub_collections/event.dart';
import 'package:image_picker/image_picker.dart';


List<String> eventCategoryList = EventCategory.values
    .map((category) => category.toString().split('.').last)
    .toList();

List<String> repeatFrequencyList = RepeatFrequency.values
    .map((frequency) => frequency.toString().split('.').last)
    .toList();

class CreateEventPage extends StatefulWidget {
  final EventModel eventModel;

  CreateEventPage(this.eventModel);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  PickedFile? selectedImage;
  final ImagePicker _imagePicker = ImagePicker();
  String cartegoeyDropdownValue = eventCategoryList.first;
  String frequencyDropdownValue = repeatFrequencyList.first;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  ValueNotifier<String> selectedCategory = ValueNotifier<String>('');
  ValueNotifier<String> selectedFrequency = ValueNotifier<String>('');
  bool isMultiDay = false;
  bool isRepeating = false;
  bool sameEachDay = true;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  TextEditingController ticketsController = TextEditingController();
  TextEditingController costPerTicketController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, DateTime selectedDate, bool isFromDate) async {
    DateTime? pickedDate = await DatePickerUtil.pickDate(context, selectedDate);

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        if (isFromDate) {
          fromDate = pickedDate;
        } else {
          toDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, DateTime selectedDate, bool isStartTime) async {
    // Set default values
    TimeOfDay initialTime = isStartTime
        ? TimeOfDay(hour: 8, minute: 0)
        : TimeOfDay(hour: 16, minute: 0);

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime != null) {
      DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      setState(() {
        if (isStartTime) {
          startTime = selectedDateTime;
        } else {
          endTime = selectedDateTime;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image as PickedFile?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new Event'),
        centerTitle: true,
        actions: [
          selectedImage == null
              ? IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    _pickImage();
                  },
                )
              : Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _pickImage();
                      },
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Icon(Icons.cancel, color: Colors.red),
                    ),
                  ],
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StyledTextField(
                  controller: _titleController,
                  label: 'Event title',
                ),
                SizedBox(height: 16.0),
                StyledTextField(
                  controller: _descriptionController,
                  label: 'Event Description',
                  isMarkdownEnabled: true,
                ),
                SizedBox(height: 16.0),
                StyledDropdown(
                  selectedValue: cartegoeyDropdownValue,
                  items: eventCategoryList,
                  onChanged: (String value) {
                    setState(() {
                      cartegoeyDropdownValue = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TagChips(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Event Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Switch(
                          value: isMultiDay,
                          onChanged: (bool newValue) {
                            setState(() {
                              isMultiDay = newValue;
                            });
                          },
                        ),
                        Text('Multiple Days'),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        if (isMultiDay) Text("Begins:"),
                        StyledButtons.secondaryOutlinedButton(
                          onPressed: () => _selectDate(context, fromDate, true),
                          text: '${fromDate.toLocal()}'.split(' ')[0],
                          icon: Icons.calendar_month,
                        ),
                      ],
                    ),
                    if (isMultiDay)
                      Column(
                        children: [
                          Text("Ends:"),
                          StyledButtons.secondaryOutlinedButton(
                            onPressed: () =>
                                _selectDate(context, toDate, false),
                            text: '${toDate.toLocal()}'.split(' ')[0],
                            icon: Icons.calendar_month,
                          ),
                        ],
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Event Duration',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Switch(
                          value: sameEachDay,
                          onChanged: (bool newValue) {
                            setState(() {
                              sameEachDay = newValue;
                            });
                          },
                        ),
                        Text('Same each day'),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Starts:"),
                        StyledButtons.secondaryOutlinedButton(
                          onPressed: () => _selectTime(context, fromDate, true),
                          text:
                              '${fromDate.toLocal().hour.toString().padLeft(2, '0')}:${fromDate.toLocal().minute.toString().padLeft(2, '0')}',
                          icon: Icons.access_time,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Closes:"),
                        StyledButtons.secondaryOutlinedButton(
                          onPressed: () => _selectTime(context, toDate, false),
                          text:
                              '${toDate.toLocal().hour.toString().padLeft(2, '0')}:${toDate.toLocal().minute.toString().padLeft(2, '0')}',
                          icon: Icons.access_time,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                LocationCard(),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: StyledTextField(
                        controller: ticketsController,
                        label: 'Number of Tickets',
                        isMultiline: false,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: StyledTextField(
                        controller: costPerTicketController,
                        label: 'Cost per Ticket (\$)',
                        isMultiline: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Repeat Event',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: isRepeating,
                      onChanged: (bool newValue) {
                        setState(() {
                          isRepeating = newValue;
                        });
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: isRepeating,
                  child: Column(
                    children: [
                      StyledDropdown(
                        selectedValue: frequencyDropdownValue,
                        items: repeatFrequencyList,
                        onChanged: (String value) {
                          setState(() {
                            frequencyDropdownValue = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      StyledDropdown(
                        selectedValue: cartegoeyDropdownValue,
                        items: eventCategoryList,
                        onChanged: (String value) {
                          setState(() {
                            cartegoeyDropdownValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                StyledButtons.primaryElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _createEvent();
                    }
                  },
                  text: 'Create Event',
                  icon: Icons.check,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createEvent() {
    Event newEvent = Event(
      id: 'your_generated_id',
      title: _titleController.text,
      description: _descriptionController.text,
      category: 'Your Category',
      tags: ['Tag1', 'Tag2'],
      startDate: fromDate,
      endDate: toDate,
      isMultiDayEvent: true,
      startTime: TimeOfDay.fromDateTime(fromDate),
      endTime: TimeOfDay.fromDateTime(toDate),
      sameEachDay: false,
      isRepeating: false,
      repeatFrequency: 'Daily',
      timeMap: [
        {'day1': TimeOfDay.fromDateTime(fromDate)},
      ],
      location: 'Event Location',
      ticketCost: 10.0,
      numberOfTickets: 100,
      photoURL: '',
    );

    widget.eventModel.addEvent(newEvent);

    Navigator.pop(context);
  }
}

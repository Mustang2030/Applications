import 'package:flutter/material.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:scs/models/school/address.dart';
import 'package:scs/routes/routes.dart';

//rsl button in black and white
Container rslButton(BuildContext context, String isLogin, Function onTap,
    {Color? color}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black38;
            }
            return color ?? const Color(0xFF0F2E34);
          },
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        isLogin,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

//sl button in grey and white
Container slButton(BuildContext context, String isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.black;
          }
          return Colors.black;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        isLogin,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

//School Button
Container sclButton(BuildContext context, String isLogin, VoidCallback onTap,
    {Color? color}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      onPressed: onTap, // Use the onTap callback when button is pressed
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.black; // Color when pressed
          }
          return color ?? const Color(0xFF0F2E34);
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.school,
            color: Colors.white,
          ),
          Text(
            isLogin,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}

//Formfield
class StyledFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final BoxDecoration? boxDecoration;
  final VoidCallback? onPressed;
  final void Function(String)? onChanged;
  final bool readonly;
  final Future<void>? future;
  final bool isDropdown;
  final bool isAddress;
  final List<String>? dropdownItems;
  final List<Address>? addressItems;
  final String? selectedItem;
  final bool? selected;
  final TextInputType? keyboardType;

  // Nullable color properties
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? iconColor;
  final Color? borderColor;
  final Color? errorTextColor;
  final TextStyle? textStyle;

  const StyledFormField({
    super.key,
    this.controller,
    this.textStyle,
    this.isPassword = false,
    this.validator,
    this.decoration,
    this.boxDecoration,
    this.onPressed,
    this.onChanged,
    this.readonly = false,
    this.future,
    this.isDropdown = false,
    this.isAddress = false,
    this.dropdownItems,
    this.addressItems,
    this.selectedItem,
    this.selected,
    this.keyboardType,
    this.labelTextColor,
    this.hintTextColor,
    this.iconColor,
    this.borderColor,
    this.errorTextColor,
  });

  @override
  State<StyledFormField> createState() => _StyledFormFieldState();
}

class _StyledFormFieldState extends State<StyledFormField> {
  bool _obscureText = true; // Initially, obscure password text

  @override
  Widget build(BuildContext context) {
    // If this is a dropdown field, render a dropdown
    if (widget.isDropdown && widget.dropdownItems != null) {
      return SizedBox(
        height: 80,
        child: DropdownButtonFormField<String>(
          value: widget.selectedItem,
          decoration: widget.decoration,
          items: widget.dropdownItems!.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: widget.textStyle),
            );
          }).toList(),
          onChanged: (String? value) {
            if (widget.onChanged != null && value != null) {
              widget.onChanged!(value);
            }
          },
          validator: widget.validator,
        ),
      );
    }

    // Render a TextFormField for regular text input
    return SizedBox(
      height: 80,
      child: TextFormField(
        readOnly: widget.readonly,
        controller: widget.controller,
        onTap: widget.onPressed,
        onChanged: widget.onChanged,
        obscureText: widget.isPassword ? _obscureText : false,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        decoration: widget.decoration?.copyWith(
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Toggle the visibility
                    });
                  },
                )
              : null,
        ),
        style: widget.textStyle ?? const TextStyle(color: Colors.black),
      ),
    );
  }
}

//Formfield Decoration
InputDecoration formS(
  String labelText,
  String? hintText,
  IconData? iconData, {
  Color? labelTextColor,
  Color? hintTextColor,
  Color? iconColor,
  Color? borderColor,
  Color? errorTextColor,
}) {
  return InputDecoration(
    errorStyle: TextStyle(
      fontSize: 12,
      color: errorTextColor ?? Colors.red,
    ),
    errorMaxLines: 3,
    prefixIcon: iconData != null
        ? Icon(
            iconData,
            color: iconColor ?? Colors.black,
          )
        : null,
    enabled: true,
    hintText: hintText,
    hintStyle: TextStyle(
      color: hintTextColor ?? Colors.grey,
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: labelTextColor ?? Colors.black,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? Colors.black),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? Colors.black),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorTextColor ?? Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorTextColor ?? Colors.red),
    ),
  );
}

//formfield decorations for user registration and login
const enabledBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black12,
    width: 1,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const focusedBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black,
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const errorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const focusedErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

//Selector
class IconSelector extends StatefulWidget {
  const IconSelector({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IconSelectorState createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the selected icon
        if (selectedIcon != null)
          Icon(
            selectedIcon!,
            color: selectedIcon == Icons.close ? Colors.red : Colors.green,
          ),
        // ElevatedButton to trigger the pop-up dialog
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(color: Colors.white)),
          onPressed: () {
            _showIconSelectionDialog(context);
          },
          child: const Text(
            'Mark',
            style: TextStyle(color: Color(0xFF0F2E34)),
          ),
        ),
        // Optionally, add a reset button to allow changing the selection
        // if (selectedIcon != null)
        //   TextButton(
        //     onPressed: () {
        //       setState(() {
        //         selectedIcon = null; // Reset selection
        //       });
        //     },
        //     child: const Text(
        //       'Remove',
        //       style: TextStyle(color: Colors.black),
        //     ),
        //   ),
      ],
    );
  }

  void _showIconSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Absent or Present?'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    selectedIcon = Icons.close; // Set selected icon to "X"
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  setState(() {
                    selectedIcon =
                        Icons.check; // Set selected icon to check mark
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

//Subject MultiSelect
class MultiSelectFormField extends StatelessWidget {
  final List<String> items;
  final List<String>? selectedItems;
  final String? Function(List<String>?)? validator;
  final InputDecoration? decoration;
  final void Function(List<String>)? onConfirm;
  final String? title;
  final TextStyle? selectedItemsTextStyle;
  final DecoratedBox? decoratedBox;

  const MultiSelectFormField({
    super.key,
    required this.items,
    this.selectedItems,
    this.validator,
    this.decoration,
    this.onConfirm,
    this.title = "Select Subjects",
    this.selectedItemsTextStyle,
    this.decoratedBox,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField<String>(
      items: items.map((item) => MultiSelectItem<String>(item, item)).toList(),
      title: Text(title!),
      selectedItemsTextStyle:
          selectedItemsTextStyle ?? const TextStyle(color: Colors.black),
      selectedColor: Colors.black,
      decoration: const BoxDecoration(
          color: Colors.grey,
          border: Border(),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      onConfirm: (p0) {},
      validator: validator,
    );
  }
}

//contacts
class Person extends StatelessWidget {
  final String? name;
  final String? subject;
  const Person({
    this.name,
    this.subject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteManagerProvider.chatscreen);
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      "$name\t",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text("\t$subject"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Parents can view these announcements
class Announ extends StatelessWidget {
  final IconData? icon;
  final String? from;
  final String? mess;
  final IconData? icon2;

  const Announ({
    this.icon,
    this.from,
    this.mess,
    this.icon2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 70,
      onPressed: () {
        Navigator.pushNamed(context, RouteManagerProvider.dannounce);
      },
      child: Row(
        children: [
          const SizedBox(height: 10),
          IconButton(onPressed: () {}, icon: Icon(icon)),
          SizedBox(
            width: 325,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  from!,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(mess!),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Icon(
            icon2,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}

//Checking it
class CheckB extends StatefulWidget {
  final IconData? icon;
  final IconData? icon2;
  final String? from;
  final String? mess;
  final bool? initialCheck; // Initial checked state
  final Function(bool)?
      onToggle; // Callback to return the current state (true or false)

  const CheckB({
    this.icon,
    this.icon2,
    this.from,
    this.mess,
    this.initialCheck = false, // Default to unchecked
    this.onToggle,
    super.key,
  });

  @override
  State<CheckB> createState() => _CheckBState();
}

class _CheckBState extends State<CheckB> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialCheck ?? false;
  }

  void _toggleCheck() {
    setState(() {
      _isChecked = !_isChecked;
    });
    if (widget.onToggle != null) {
      widget.onToggle!(_isChecked); // Return true or false
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          SizedBox(
            width: 355,
            child: Text(
              widget.from!,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          IconButton(
            onPressed: _toggleCheck, // Call the toggle method
            icon: Icon(_isChecked ? widget.icon : widget.icon2),
          ),
        ],
      ),
    );
  }
}

//Students
//contacts
class Student extends StatelessWidget {
  final String? name;
  final String? subject;
  const Student({
    this.name,
    this.subject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteManagerProvider.childprot);
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      "$name\t",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text("\t$subject"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementTile extends StatelessWidget {
  final String from;
  final String message;
  final bool pending;
  final bool seen;
  final IconButton? delIcon;

  const AnnouncementTile({
    super.key,
    required this.from,
    required this.message,
    this.pending = false,
    required this.seen,
    this.delIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            seen ? Icons.check_circle : Icons.radio_button_unchecked,
            color: seen ? Colors.green : Colors.grey,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  from,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 20,
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          IconButtonsRow(
            pending: pending,
            delIcon: delIcon,
          ),
        ],
      ),
    );
  }
}

class IconButtonsRow extends StatelessWidget {
  final bool pending;
  final IconButton? delIcon;
  final IconButton? editIcon;

  const IconButtonsRow({
    super.key,
    required this.pending,
    this.delIcon,
    this.editIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (pending && editIcon != null) editIcon!,
        if (pending && delIcon != null) delIcon!,
      ],
    );
  }
}

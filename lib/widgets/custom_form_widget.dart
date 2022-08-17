import 'package:challenge/classes/sign_classes.dart';
import 'package:flutter/material.dart';

typedef Callback = void Function(FormData value);

class CustomFormWidget extends StatefulWidget {
  final String label;
  final bool isPassWord;
  final Callback callback;
  const CustomFormWidget({
    required this.label,
    required this.isPassWord,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  FormData formData = FormData("", false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 348,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 348,
          child: TextFormField(
            obscureText: widget.isPassWord && !formData.showPassword,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(102, 255, 255, 255),
              contentPadding: const EdgeInsets.all(16.0),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              suffixIcon: widget.isPassWord
                  ? IconButton(
                      icon: Icon(
                        formData.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          formData.showPassword = !formData.showPassword;
                        });
                        widget.callback(formData);
                      },
                    )
                  : null,
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
            onChanged: (value) {
              formData.input = value;
              widget.callback(formData);
            },
          ),
        )
      ],
    );
  }
}

part of 'blood_request.dart';

Widget _textField({required TextEditingController controller, TextInputType? keyboardType, int? maxLines}) {
  return Padding(
    padding: PaddingBorderConstant.paddingOnlyLeftHigh,
    child: TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Bu alan boş olamaz";
        }
        return null;
      },
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLines: maxLines ?? 1,
      decoration: const InputDecoration(hintText: "- - - -", border: InputBorder.none),
    ),
  );
}

class RequestBloodField extends StatelessWidget {
  const RequestBloodField({
    super.key,
    required this.fieldTitle,
    required this.field,
  });
  final String fieldTitle;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingBorderConstant.paddingVerticalHigh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formTitle(context, fieldTitle),
          Card(
              elevation: 7,
              margin: PaddingBorderConstant.paddingOnlyTopLow,
              child: SizedBox(width: context.deviceWidth, child: field)),
        ],
      ),
    );
  }
}

Padding _formTitle(BuildContext context, String title) {
  return Padding(
    padding: PaddingBorderConstant.paddingOnlyLeft,
    child: Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
    ),
  );
}

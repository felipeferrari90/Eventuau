double asDouble(String value) =>
    double.parse(value.replaceAll('.', '').replaceAll(',', '.'));

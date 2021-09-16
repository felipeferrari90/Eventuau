bool isDateTypeAndBeforeNow(String dataEmString) =>
    DateTime.tryParse(dataEmString.split('/').reversed.join('-'))
        .isBefore(DateTime.now());

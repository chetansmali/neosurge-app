class DropDownItem {
  final String name;
  final dynamic value;

  const DropDownItem(this.name, this.value);

  factory DropDownItem.fromJson(Map<String, dynamic> json) {
    return DropDownItem(
      json['type'] ?? json['name'] as String,
      json['id'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class DropDownConstants {
  DropDownConstants._();

  //List of Martial Status
  static const List<DropDownItem> maritalStatusList = [
    DropDownItem('Married', 1),
    DropDownItem('Unmarried', 2),
    DropDownItem('Others', 3),
  ];

  //List of Occupation Type
  static const List<DropDownItem> occupationTypeList = [
    DropDownItem('Agriculture', 1),
    DropDownItem('Business', 2),
    DropDownItem('Doctor', 3),
    DropDownItem('Forex Dealer', 4),
    DropDownItem('Government Service', 5),
    DropDownItem('Professional', 6),
    DropDownItem('Self Employed', 7),
    DropDownItem('Retired', 8),
    DropDownItem('Service', 9),
    DropDownItem('HouseWife', 10),
    DropDownItem('Student', 11),
    DropDownItem('Public Sector', 12),
    DropDownItem('Private Sector', 13),
    DropDownItem('Government Sector', 14),
    DropDownItem('Others', 15),
  ];

  //List of valid Address Proofs
  static const List<DropDownItem> addressProofList = [
    DropDownItem('Passport', 1),
    DropDownItem('Voter ID', 2),
    DropDownItem('Driving License', 3),
    //disabled because its not currently supported
    //DropDownItem('Aadhaar Card', 4),
  ];

  //List of Income Source
  static const List<DropDownItem> incomeSourceList = [
    DropDownItem('Salary', 1),
    DropDownItem('Business', 2),
    DropDownItem('Ancestral Property', 3),
    DropDownItem('Rental Income', 4),
    DropDownItem('Prize Money', 5),
    DropDownItem('Royality', 6),
    DropDownItem('Others', 7),
  ];

  // List of Account Types
  static const List<DropDownItem> accountTypeList = [
    DropDownItem('Savings', 1),
    DropDownItem('Current', 2),
    DropDownItem('NRE', 3),
    DropDownItem('NRO', 4),
  ];

  //List of Nominee Relationship
  static const List<DropDownItem> nomineeRelationshipList = [
    DropDownItem('Spouse', 1),
    DropDownItem('Father', 2),
    DropDownItem('Mother', 3),
    DropDownItem('Daughter', 4),
    DropDownItem('Son', 5),
    DropDownItem('Guardian', 6),
    DropDownItem('Friend', 7),
    DropDownItem('Brother', 8),
    DropDownItem('Sister', 9),
    DropDownItem('Grand Daughter', 10),
    DropDownItem('Grand Son', 11),
    DropDownItem('Brother-in-Law', 12),
    DropDownItem('Sister-in-Law', 13),
    DropDownItem('Mother-in-Law', 14),
    DropDownItem('Father-in-Law', 15),
  ];

  //List of States of India including Union Territories
  //This is the list.

  static const List<DropDownItem> statesOfIndiaList = [
    DropDownItem('Andaman and Nicobar Islands', 1),
    DropDownItem('Andhra Pradesh', 2),
    DropDownItem('Arunachal Pradesh', 3),
    DropDownItem('Assam', 4),
    DropDownItem('Bihar', 5),
    DropDownItem('Chandigarh', 6),
    DropDownItem('Chhattisgarh', 7),
    DropDownItem('Dadra and Nagar Haveli', 8),
    DropDownItem('Daman and Diu', 9),
    DropDownItem('Delhi', 10),
    DropDownItem('Goa', 11),
    DropDownItem('Gujarat', 12),
    DropDownItem('Haryana', 13),
    DropDownItem('Himachal Pradesh', 14),
    DropDownItem('Jammu and Kashmir', 15),
    DropDownItem('Jharkhand', 16),
    DropDownItem('Karnataka', 17),
    DropDownItem('Kerala', 18),
    DropDownItem('Ladakh', 19),
    DropDownItem('Lakshadweep', 20),
    DropDownItem('Madhya Pradesh', 21),
    DropDownItem('Maharashtra', 22),
    DropDownItem('Manipur', 23),
    DropDownItem('Meghalaya', 24),
    DropDownItem('Mizoram', 25),
    DropDownItem('Nagaland', 26),
    DropDownItem('Orissa', 27),
    DropDownItem('Puducherry', 28),
    DropDownItem('Punjab', 29),
    DropDownItem('Rajasthan', 30),
    DropDownItem('Sikkim', 31),
    DropDownItem('Tamil Nadu', 32),
    DropDownItem('Telangana', 33),
    DropDownItem('Tripura', 34),
    DropDownItem('Uttar Pradesh', 35),
    DropDownItem('Uttarakhand', 36),
    DropDownItem('West Bengal', 37)
  ];

  // List of Query Category
  static const List<DropDownItem> queryCategories = [
    DropDownItem("Equity", 1),
    DropDownItem("Loan Against Mutual Funds", 2),
    DropDownItem("Onboarding", 3),
  ];
}

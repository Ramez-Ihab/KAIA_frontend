enum Country {
  all('All', '', ''),
  egypt('Egypt', 'EG', 'EGY'),
  saudiArabia('Saudi Arabia', 'SA', 'KSA'),
  uae('UAE', 'AE', 'UAE'),
  lebanon('Lebanon', 'LB', 'LBN'),
  jordan('Jordan', 'JO', 'JOR'),
  kuwait('Kuwait', 'KW', 'KWT'),
  qatar('Qatar', 'QA', 'QAT'),
  bahrain('Bahrain', 'BH', 'BHR'),
  oman('Oman', 'OM', 'OMN'),
  palestine('Palestine', 'PS', 'PSE');

  final String label;
  final String isoCode;
  final String displayCode;
  const Country(this.label, this.isoCode, this.displayCode);
}

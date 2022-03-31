List<String> getLevels(){
  return [
    "BCS",
    "Bank",
    "Primary"
  ];
}


List<String> getDistrict(){
  List<String> kDistricts = ["Barguna",  "Barishal", "Bhola", "Jhalokati", "Patuakhali", "Pirojpur",
    "Bandarban","Brahmanbaria",   "Chandpur", "Chattogram", "Cumilla",    "Cox's Bazar","Feni",  "Khagrachhari","Lakshmipur", "Noakhali", "Rangamati",
    "Dhaka",    "Faridpur",       "Gazipur",  "Gopalganj",  "Kishoreganj","Madaripur",  "Manikganj","Munshiganj",  "Narayanganj","Narsingdi","Rajbari","Shariatpur","Tangail",
    "Bagerhat", "Chuadanga",      "Jashore",  "Jhenaidah",  "Khulna",     "Kushtia",    "Magura",   "Meherpur",    "Narail",     "Satkhira",
    "Jamalpur", "Mymensingh",     "Netrakona","Sherpur",
    "Bogura",    "Chapainawabganj","Joypurhat","Naogaon",    "Natore",     "Pabna",      "Rajshahi", "Sirajganj",
    "Dinajpur", "Gaibandha",      "Kurigram", "Lalmonirhat","Nilphamari", "Panchagarh", "Rangpur",  "Thakurgaon",
    "Habiganj", "Moulvibazar",    "Sunamganj","Sylhet"
  ];

  kDistricts.sort();

  return kDistricts;
}
class UserDetail {
  String? id;
  String? name;
  String? employeeCode;
  String? dob;
  String? email;
  String? mobile;
  String? alternateNumber;
  String? doj;
  String? adharCardNo;
  String? panCardNo;
  String? pfno;
  String? isciNumber;
  String? gender;
  String? salary;
  String? paidLeave;
  String? pendingLeave;
  String? status;
  String? pancard;
  String? adharCard;
  String? others;
  String? profileImage;
  String? coverImage;
  String? address;
  String? basicSalaryDa;
  String? hra;
  String? cca;
  String? medical;
  String? conveyance;
  String? exGracia;
  String? target;
  String? professionalTax;
  String? providentFund;
  String? tds;
  String? esic;
  String? labourWelfareFund;
  String? created;
  String? updated;

  UserDetail(
      {this.id,
      this.name,
      this.employeeCode,
      this.dob,
      this.email,
      this.mobile,
      this.alternateNumber,
      this.doj,
      this.adharCardNo,
      this.panCardNo,
      this.pfno,
      this.isciNumber,
      this.gender,
      this.salary,
      this.paidLeave,
      this.pendingLeave,
      this.status,
      this.pancard,
      this.adharCard,
      this.others,
      this.profileImage,
      this.coverImage,
      this.address,
      this.basicSalaryDa,
      this.hra,
      this.cca,
      this.medical,
      this.conveyance,
      this.exGracia,
      this.target,
      this.professionalTax,
      this.providentFund,
      this.tds,
      this.esic,
      this.labourWelfareFund,
      this.created,
      this.updated});

  UserDetail.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    employeeCode = json['employee_code'];
    dob = json['dob'];
    email = json['email'];
    mobile = json['mobile'];
    alternateNumber = json['alternate_number'];
    doj = json['doj'];
    adharCardNo = json['adhar_card_no'];
    panCardNo = json['pan_card_no'];
    pfno = json['pfno'];
    isciNumber = json['isci_number'];
    gender = json['gender'];
    salary = json['salary'];
    paidLeave = json['paid_leave'];
    pendingLeave = json['pending_leave'];
    status = json['status'];
    pancard = json['pancard'];
    adharCard = json['adhar_card'];
    others = json['others'];
    profileImage = json['profile_image'];
    coverImage = json['cover_image'];
    address = json['address'];
    basicSalaryDa = json['basic_salary_da'];
    hra = json['hra'];
    cca = json['cca'];
    medical = json['medical'];
    conveyance = json['conveyance'];
    exGracia = json['ex_gracia'];
    target = json['target'];
    professionalTax = json['professional_tax'];
    providentFund = json['provident_fund'];
    tds = json['tds'];
    esic = json['esic'];
    labourWelfareFund = json['labour_welfare_fund'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['employee_code'] = this.employeeCode;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['alternate_number'] = this.alternateNumber;
    data['doj'] = this.doj;
    data['adhar_card_no'] = this.adharCardNo;
    data['pan_card_no'] = this.panCardNo;
    data['pfno'] = this.pfno;
    data['isci_number'] = this.isciNumber;
    data['gender'] = this.gender;
    data['salary'] = this.salary;
    data['paid_leave'] = this.paidLeave;
    data['pending_leave'] = this.pendingLeave;
    data['status'] = this.status;
    data['pancard'] = this.pancard;
    data['adhar_card'] = this.adharCard;
    data['others'] = this.others;
    data['profile_image'] = this.profileImage;
    data['cover_image'] = this.coverImage;
    data['address'] = this.address;
    data['basic_salary_da'] = this.basicSalaryDa;
    data['hra'] = this.hra;
    data['cca'] = this.cca;
    data['medical'] = this.medical;
    data['conveyance'] = this.conveyance;
    data['ex_gracia'] = this.exGracia;
    data['target'] = this.target;
    data['professional_tax'] = this.professionalTax;
    data['provident_fund'] = this.providentFund;
    data['tds'] = this.tds;
    data['esic'] = this.esic;
    data['labour_welfare_fund'] = this.labourWelfareFund;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}

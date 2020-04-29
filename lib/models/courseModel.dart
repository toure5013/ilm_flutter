class CourseModel {
  String name;
  String description;
  String university;
  String noOfCource;
  String image;
  String tag1;
  String tag2;
  String id;
  String profFirstname;
  String profLastname;
  CourseModel({this.id, this.name, this.description, this.image, this.noOfCource, this.university, this.tag1, this.tag2,  this.profFirstname , this.profLastname});
}


class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        id : "nsjdbsqkjdbkjqs",
        name: "Data Science",
        description:
            "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
        image: "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg",
        university: "Jons Hopkins University",
        noOfCource: "17 courses",
        tag1: "Data science",
        tag2: "Machine Learning",
        profFirstname: "TOURE",
        profLastname: "SOULEYMANE"),
    CourseModel(
        id : "nsjdbsqkjdbkjqs",
        name: "Masse et poids",
        description:
            "This specialization from leading researchers at university of washington introduce to you to the exciting high-demand field of machine learning ",
        image: "https://media-exp1.licdn.com/dms/image/C5603AQG2GK8T5W_cDQ/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=SnOUo0gWh0EGDGwVKZ36OENpFLW933cr-i1tKqWC4-k",
        university: "University of washington",
        noOfCource: "8 courses",
        tag1: "Physique",
        tag2: "Force & énergie",
        profFirstname: "TOURE",
        profLastname: "SOULEYMANE"),
    CourseModel(
        id : "nsjdbsqkjdbkjqs",
        name: "Hydrocarbure",
        image: "https://media-exp1.licdn.com/dms/image/C5603AQG2GK8T5W_cDQ/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=SnOUo0gWh0EGDGwVKZ36OENpFLW933cr-i1tKqWC4-k",
        description:
            "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
        university: "Us San Diego",
        noOfCource: "10 courses",
        tag1: "Data Data",
        tag2: "Apache Spark",
        profFirstname: "TOURE",
        profLastname: "SOULEYMANE"),
  ];
}

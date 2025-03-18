class IntroModel {
  String? image;
  String? title;
  String? description;
  IntroModel({this.image, this.title, this.description});
}

List<IntroModel> contents = [
  IntroModel(
    title: 'Manage Outlet',
    image: 'assets/image 14.png',
    description:
        'Lorem ipsum dolor sit amet consectetur. Tellus et id est vulputate euismod vitae. Et in at eget convallis suscipit adipiscing.',
  ),
  IntroModel(
    title: 'Data is high secured',
    image: 'assets/image 15.png',
    description:
        'Lorem ipsum dolor sit amet consectetur. Tellus et id est vulputate euismod vitae. Et in at eget convallis suscipit adipiscing.',
  ),
  IntroModel(
    title: 'Easy to Use',
    image: 'assets/image 16.png',
    description:
        'Lorem ipsum dolor sit amet consectetur. Tellus et id est vulputate euismod vitae. Et in at eget convallis suscipit adipiscing.',
  )
];

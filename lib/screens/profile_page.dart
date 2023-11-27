import 'package:ds304/widgets/taglist.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://qph.fs.quoracdn.net/main-qimg-11ef692748351829b4629683eff21100.webp',
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            'Joan Louji',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Full stack Developer',
                            style: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                width: 1, color: Colors.grey.shade500),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.message,
                            color: Colors.blueGrey[400],
                          )),
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          padding: const EdgeInsets.only(left: 20),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              // Add your onPressed logic here
                            },
                            child: const Text(
                              'Follow',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Divider(
                  thickness: 1,
                  color: Colors.blueGrey[200],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            '203',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: const Text(
                            'Followers',
                            style:
                                TextStyle(fontSize: 15, color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            '932',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: const Text(
                            'Following',
                            style:
                                TextStyle(fontSize: 15, color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            '30',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: const Text(
                            'Projects',
                            style:
                                TextStyle(fontSize: 15, color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Divider(
                  thickness: 1,
                  color: Colors.blueGrey[200],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Skills',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 1, right: 1),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TagList(title: "Flutter"),
                          TagList(title: "React JS"),
                          TagList(title: "Node Js")
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 1, right: 1),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TagList(title: "Django"),
                          TagList(title: "Laravel"),
                          TagList(title: "Express JS"),
                          TagList(title: "Tensorflow"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Projects',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  'https://www.techuz.com/blog/wp-content/uploads/2019/06/Technology-Stack_Banner-1280x720.jpg',
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: const Text(
                                  'MERN Stack Project',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  'https://appsmaventech.com/images/blog/React-Native-Vs-Flutter-What-Is-Better-For-Your-Business.jpg',
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: const Text(
                                  'Flutter vs React',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/controller/branches/fetch_branches_provider.dart';
import 'package:flutter_application_1/controller/doctors/fetch_doctors_data_provider.dart';
import 'package:flutter_application_1/controller/fetch_departments_provider.dart';
import 'package:flutter_application_1/controller/fetch_offers_provider.dart';
import 'package:flutter_application_1/controller/fetch_posts_provider.dart';
import 'package:flutter_application_1/view/screens/all_Specialties_screen.dart';
import 'package:flutter_application_1/view/screens/all_articles_screen.dart';
import 'package:flutter_application_1/view/screens/appointments/make_appointments_screen.dart';
import 'package:flutter_application_1/view/screens/branches/all_branches_screen.dart';
import 'package:flutter_application_1/view/screens/doctors_list_screen.dart';
import 'package:flutter_application_1/view/screens/notifications_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDoctorsSelected = true;
  int selectionindex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FetchDoctorsDataProvider>(context, listen: false)
          .fetchDoctorsData(context);
      Provider.of<FetchBranchesProvider>(context, listen: false)
          .fetchBranches(context);
      Provider.of<FetchDepartmentsProvider>(context, listen: false)
          .fetchDepartments(context);
      Provider.of<FetchPostsProvider>(context, listen: false)
          .fetchPosts(context);
      Provider.of<FetchOffersProvider>(context, listen: false)
          .fetchOffers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MakeAppointmentScreen()));
            },
            child: Text(
              'حجز موعد',
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 130.w,
          ),
          Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Text(
              'مرحبًا، محمد!',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Stack(
                  //   children: [
                  //     IconButton(
                  //       icon: const Icon(Icons.notifications),
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     const NotificationsScreen()));
                  //       },
                  //     ),
                  //     Positioned(
                  //       right: 8,
                  //       top: 8,
                  //       child: Container(
                  //         padding: const EdgeInsets.all(4),
                  //         decoration: BoxDecoration(
                  //           color: backgroundColor,
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: Text(
                  //           '3',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 12.sp,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'ابحث هنا',
                        suffixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Image Banner
            Consumer<FetchOffersProvider>(
              builder: (context, provider, child) {
                if (provider.offersResponse == null) {
                  provider.fetchOffers(context);
                  return const Center(child: CircularProgressIndicator());
                }

                // Show CarouselSlider with fetched data
                final posts = provider.offersResponse!.data;
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: posts
                      .map((item) => Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(item.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SpecialistsScreen()));
                        },
                        child: Text(
                          "استعراض الكل",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Text(
                        "التخصصات",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Consumer<FetchDepartmentsProvider>(
                    builder: (context, fetchDepartmentsProvider, child) {
                      final departmentResponse =
                          fetchDepartmentsProvider.departmentResponse;
                      if (departmentResponse == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final departments = departmentResponse.data;

                      return SizedBox(
                        height: 90,
                        child: ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: departments.length,
                          itemBuilder: (context, index) {
                            final department = departments[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50, width: 70,
                                    child: Image.network(department
                                        .image), // Use index to get the image
                                  ),
                                  const SizedBox(height: 4),
                                  Text(department
                                      .name), // Use index to get the text
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: FilterButton(
                              icon: Icons.location_city,
                              label: 'الفروع',
                              backgroundColor: Colors.grey[200],
                              isSelected:
                                  !isDoctorsSelected, // Invert the state
                              onTap: () {
                                setState(() {
                                  isDoctorsSelected = false;
                                  selectionindex = 1;
                                });
                              }),
                        ),
                        const SizedBox(width: 8),
                        FilterButton(
                            icon: Icons.person,
                            label: 'الأطباء',
                            backgroundColor: Colors.grey[200],
                            isSelected:
                                isDoctorsSelected, // Use current selection state
                            onTap: () {
                              setState(() {
                                isDoctorsSelected = true;
                                selectionindex = 0;
                              });
                            }),
                        const SizedBox(
                          width: 170,
                        ),
                        // InkWell(
                        //   child: Image.asset("assets/images/filter.png"),
                        //   onTap: () {
                        //     showModalBottomSheet(
                        //       context: context,
                        //       isScrollControlled: true,
                        //       builder: (context) {
                        //         return const AppointmentsFilterWidget();
                        //       },
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  selectionindex == 0
                      ? RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text:
                                    'نقدم لكم في مركز بن رشد نخبة من\n الأطباء المتخصصين. ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                  text: 'استعراض الكل',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DoctorsListScreen()),
                                      );
                                    }),
                            ],
                          ),
                        )
                      : RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'اختر الفرع الاقرب لك ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                  text: 'استعراض الكل',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AllBranchesScreen()),
                                      );
                                    }),
                            ],
                          ),
                        )
                ],
              ),
            ),
            selectionindex == 0
                ? SizedBox(
                    height: 180,
                    child: Consumer<FetchDoctorsDataProvider>(
                      builder: (context, doctorsProvider, child) {
                        // Check if the data is still being fetched
                        if (doctorsProvider.doctorsResponse == null) {
                          return const Center(
                            child:
                                CircularProgressIndicator(), // Show loading spinner
                          );
                        }

                        // Get the list of doctors
                        final doctors = doctorsProvider.doctorsResponse!.data;

                        if (doctors.isEmpty) {
                          return const Center(
                            child: Text('No doctors available'),
                          );
                        }

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            final doctor = doctors[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Display doctor image, fallback to placeholder if null
                                    doctor.image != null
                                        ? Image.network(
                                            doctor.image,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/doctor_placeholder.png",
                                            height: 80,
                                            width: 80,
                                          ),
                                    const SizedBox(height: 8),
                                    // Display doctor name
                                    Text("${doctor.fname} ${doctor.lname}"),
                                    const SizedBox(height: 4),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: backgroundColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MakeAppointmentScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'حجز موعد',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 200,
                    child: Consumer<FetchBranchesProvider>(
                      builder: (context, fetchBranchesProvider, child) {
                        if (fetchBranchesProvider.branchResponse == null) {
                          return const Center(
                            child:
                                CircularProgressIndicator(), // Show loading spinner
                          );
                        }
                        final branches =
                            fetchBranchesProvider.branchResponse!.data;
                        if (branches.isEmpty) {
                          return const Center(
                            child: Text('No doctors available'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: branches.length,
                          itemBuilder: (context, index) {
                            final branch = branches[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      branch.image, // Replace with your asset
                                      height: 70,
                                      width: 180,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      branch.address,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      branch.brief,
                                      style: const TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: backgroundColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MakeAppointmentScreen()));
                                      },
                                      child: const Text(
                                        'حجز موعد',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllArticlesScreen()));
                    },
                    child: Text(
                      "استعراض الكل",
                      style: TextStyle(
                        fontSize: 13,
                        color: backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "مقالات صحية ",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Consumer<FetchPostsProvider>(
              builder: (context, fetchPostsProvider, child) {
                final articles = fetchPostsProvider.postResponse?.data ?? [];

                if (fetchPostsProvider.postResponse == null) {
                  // Show a loading spinner if the data is still being fetched
                  return const Center(child: CircularProgressIndicator());
                }

                if (articles.isEmpty) {
                  // Show a message if there are no articles
                  return const Center(
                    child: Text(
                      'لا توجد مقالات حالياً.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap:
                        true, // Prevents the ListView from taking infinite space
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables scrolling
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: buildArticleCard(
                          context,
                          content:
                              article.content, // Replace with actual date field
                          title: article.title,
                          imageUrl:
                              article.image, // Use the real image URL from API
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? backgroundColor;
  final bool isSelected;
  final Image? image;
  final VoidCallback onTap;

  const FilterButton({
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.isSelected = false,
    this.image,
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const dartRedColor = Color.fromRGBO(149, 0, 0, 1.0);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? dartRedColor : Colors.black,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? dartRedColor : Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildArticleCard(BuildContext context,
    {required String content,
    required String title,
    required String imageUrl}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  );
}

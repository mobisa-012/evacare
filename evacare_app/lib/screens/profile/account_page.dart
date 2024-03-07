// // ignore_for_file: deprecated_member_use
// import 'package:evacare/core/const/margins.dart';
// import 'package:evacare/core/const/path_const.dart';
// import 'package:evacare/core/services/auth_service.dart';
// import 'package:evacare/screens/onboarding/page/onboarding_page.dart';
// import 'package:evacare/screens/widgets/settings_container.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';


// class AccountPage extends StatefulWidget {
//   const AccountPage({super.key});

//   @override
//   State<AccountPage> createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {
//   @override
//   Widget build(BuildContext context) {
//     final photoUrl = FirebaseAuth.instance.currentUser!.photoURL;
//     final name = FirebaseAuth.instance.currentUser!.displayName;
//     final email = FirebaseAuth.instance.currentUser!.email;
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Stack(
//                 alignment: Alignment.topRight,
//                 children: [
//                   Center(
//                     child: photoUrl == null
//                     ? const CircleAvatar(
//                       backgroundImage: AssetImage(PathConstants.profileAvatr),
//                       radius: 60,
//                     ): CircleAvatar(
//                       radius: 60,
//                       child: ClipOval(
//                         child: FadeInImage.assetNetwork(
//                           placeholder: PathConstants.profileAvatr, 
//                           image: photoUrl,
//                           fit: BoxFit.cover,
//                           width: 200,
//                           height: 200,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const YMargin(y: 15),
//               Text(
//                 email!,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//               const YMargin(y: 8),
//               Text(
//                 name!,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500
//                 ),
//               ),
//               const YMargin(y: 15),
//               SettingsContainer(
//                 onTap: () => launch(
//                   'https://github.com/mobisa-012/T-Cs/blob/main/EvaCare.md'),
//                 child: const Text(
//                   'Terms and Conditions',
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500
//                   )
//                 )
//               ),
//               const YMargin(y: 10),
//               SettingsContainer(
//                 onTap: () => launch(
//                   'https://github.com/mobisa-012/T-Cs/blob/main/privacy_policy.md'),
//                 child: const Text(
//                   'Privacy Policy',
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500
//                   )
//                 )
//               ),
//               const YMargin(y: 10),
//               SettingsContainer(
//                 child: const Text(
//                   'Sign out',
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500
//                   ),
//                 ),
//                 onTap: () {
//                   AuthService().signOut();
//                   Navigator.pushReplacement(
//                     context, MaterialPageRoute(builder: (_) => const OnboardingPage()));
//                 },
//               ),
//               const YMargin(y: 10),
//               const Center(
//                 child: Text(
//                   'Join us',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//               ),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [                  
//                   TextButton(
//                       onPressed: () => launch(''
//                           // 'https://twitter.com/kwamboka_012/'
//                           ),
//                       style: TextButton.styleFrom(
//                           shape: const CircleBorder(),
//                           backgroundColor: Colors.white,
//                           elevation: 2),
//                       child: Image.asset(PathConstants.twitter,height: 20,)),
//                   TextButton(
//                       onPressed: () => launch( ''
//                           // 'https://www.instagram.com/kwamboka_mobisa/'
//                           ),
//                       style: TextButton.styleFrom(
//                           shape: const CircleBorder(),
//                           backgroundColor: Colors.white,
//                           elevation: 2),
//                       child: Image.asset(PathConstants.ig,height: 20,)),
//                 ],
//               ),
//               // Center(
//               //   child: IconButton(
//               //   icon: const Icon(Icons.arrow_forward_ios),
//               //   onPressed: () {
//               //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PomodoroScreen(focusDuration: 25, breakDuration: 0)));
//               //   },
//               // ),)
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'All user data will be here'
      ),
    );
  }
}
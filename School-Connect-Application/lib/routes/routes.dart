import 'package:flutter/material.dart';
import 'package:scs/pages/child/attendance.dart';
import 'package:scs/pages/child/markattendence.dart';
import 'package:scs/pages/child/report.dart';
import 'package:scs/pages/parent/parent.dart';
import 'package:scs/pages/parent/parentlandingpage.dart';
import 'package:scs/pages/parent/parentSchoolProfile.dart';
import 'package:scs/pages/parent/parentViewAnn.dart';
import 'package:scs/pages/parent/parentViewAttendance.dart';
import 'package:scs/pages/parent/parentViewChildProf.dart';
import 'package:scs/pages/parent/parentViewProf.dart';
import 'package:scs/pages/principal/principallanding.dart';
import 'package:scs/pages/communication/make_announcement.dart';
import 'package:scs/pages/principal/principalViewAttendance.dart';
import 'package:scs/pages/principal/principalViewGrades.dart';
import 'package:scs/pages/principal/principalviewprofile.dart';
import 'package:scs/pages/principal/principlaGradeLanding.dart';
import 'package:scs/pages/communication/view_announcements.dart';
import 'package:scs/pages/schools/schools_list.dart';
import 'package:scs/pages/systemadmin/admindetails.dart';
import 'package:scs/pages/systemadmin/rolesregistration.dart';
import 'package:scs/pages/systemadmin/schoolregistration.dart';
import 'package:scs/pages/systemadmin/sysadminViewProf.dart';
import 'package:scs/pages/systemadmin/systemadminlanding.dart';
import 'package:scs/pages/systemadmin/sysadminRegRoles.dart';
import 'package:scs/pages/systemadmin/sysadminregschool.dart';
import 'package:scs/pages/teachers/teacher.dart';
import 'package:scs/pages/principal/attendence.dart';
import 'package:scs/pages/principal/delannnounce.dart';
import 'package:scs/pages/principal/grades.dart';
import 'package:scs/pages/principal/pannounce.dart';
import 'package:scs/pages/principal/reports.dart';
import 'package:scs/pages/principal/teachprof.dart';
import 'package:scs/pages/teachers/teacherchatlist.dart';
import 'package:scs/reg_and_log/slogin.dart';
import 'package:scs/pages/teachers/childprot.dart';
import 'package:scs/pages/teachers/classroaste.dart';
import 'package:scs/pages/teachers/makereport.dart';
import 'package:scs/pages/teachers/subj.dart';
import 'package:scs/pages/teachers/teacherp.dart';
import 'package:scs/pages/communication/announce.dart';
import 'package:scs/pages/communication/chat_screen.dart';
import 'package:scs/pages/communication/contact_list.dart';
import 'package:scs/pages/communication/pcontactlist.dart';
import 'package:scs/pages/parent/announcement.dart';
import 'package:scs/pages/parent/childpro.dart';
import 'package:scs/pages/communication/detailed_announce.dart';
import 'package:scs/pages/parent/pprofile.dart';
import 'package:scs/reg_and_log/login.dart';
import 'package:scs/pages/teachers/subjectt.dart';
import 'package:scs/pages/teachers/tprofile.dart';

class RouteManagerProvider {
  static const String login = '/',
      slogin = '/slogin',
      register = '/register',
      adminprofile = '/adminprofile',
      principallandingpage = '/principallandingpage',
      parent = '/parent',
      teacher = '/teacher',
      teacherp = '/teacherp',
      schoolregistration = '/schoolregistration',
      roleregistration = '/roleregistration',
      contactlist = '/contactlist',
      pcontactlist = '/pcontactlist',
      chatscreen = '/chatscreen',
      announce = '/announce',
      childpro = '/childpro',
      attendance = '/attendance',
      announcementS = '/announcementS',
      dannounce = '/dannounce',
      report = '/report',
      pprofile = '/pprofile',
      mattendence = '/mattendence',
      schoolsList = '/schoolsList',
      subjectt = '/subjectt',
      classroaster = '/classroaster',
      childprot = '/childprot',
      makereport = '/makereport',
      tdetails = '/tdetails',
      subj = '/subj',
      gradespv = '/gradespv',
      teachprofpv = '/teachprofpv',
      attendencepv = '/attendencepv',
      pvreport = '/pvreport',
      pcannounce = '/pcannounce',
      delannounceS = '/delannounceS',
      gradeView = '/gradeView',
      landingPage = 'landing_page_principal',
      makeAnnouncements = 'make_announcements_principal',
      viewAttendance = 'viewAttendance_principal',
      viewProfile = 'profile_view_principal',
      viewAnnouncements = 'view_announcements_principal',
      learnerProfile = 'view_learner_principal',
      viewReport = 'view_report_principla',
      principalGradeLanding = 'principalGradeLanding',
      //System Admin Routes
      systemadminlanding = '/systemadminlandin',
      sysadminregschool = '/sysadminregschool',
      sysadminRegRoles = 'reg_roles_sysadmin',
      sysadminviewprofile = '/sysadminviewprofile',
      //Parents Routes
      parentlanding = '/parentlanding',
      parentChatListPage = 'parent_chat_page',
      parentViewChildProf = 'parent_view_child_prof',
      parentViewAttendance = 'parent_view_attendance',
      parentViewann = 'parent_view_ann',
      parentSchoolPofile = 'parent_school_profile',
      parentDetailedAnn = 'parent_detail_ann',
      chatScreen = 'chat',
      parentViewProf = 'parent_view_prof',
      parentViewReport = 'parent_view_report';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case slogin:
        return MaterialPageRoute(
          builder: (context) => const SLogin(),
        );
      case systemadminlanding:
        return MaterialPageRoute(
          builder: (context) => const SysAdminLandingPage(),
        );
      case principallandingpage:
        return MaterialPageRoute(
          builder: (context) => const PrincipalLandingPage(),
        );
      case parent:
        return MaterialPageRoute(
          builder: (context) => const ParentPage(),
        );
      case teacher:
        return MaterialPageRoute(
          builder: (context) => const Teacher(),
        );
      case schoolregistration:
        return MaterialPageRoute(
          builder: (context) => const SchoolRegistration(),
        );
      case roleregistration:
        return MaterialPageRoute(
          builder: (context) => const RoleRegistration(),
        );
      case contactlist:
        return MaterialPageRoute(
          builder: (context) => const ContactList(),
        );
      case pcontactlist:
        return MaterialPageRoute(
          builder: (context) => const PContactList(),
        );
      case chatscreen:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        );
      case announce:
        return MaterialPageRoute(
          builder: (context) => const Announcements(),
        );
      case childpro:
        return MaterialPageRoute(
          builder: (context) => const ChildProfile(),
        );
      case attendance:
        return MaterialPageRoute(
          builder: (context) => const Attendance(),
        );
      case announcementS:
        return MaterialPageRoute(
          builder: (context) => const AnnouncementS(),
        );
      case report:
        return MaterialPageRoute(
          builder: (context) => const Report(),
        );
      case pprofile:
        return MaterialPageRoute(
          builder: (context) => const ParentProfile(),
        );
      case mattendence:
        return MaterialPageRoute(
          builder: (context) => const MarkAttendance(),
        );
      case schoolsList:
        return MaterialPageRoute(
          builder: (context) => const SchoolsList(),
        );
      case dannounce:
        return MaterialPageRoute(
          builder: (context) => const DetailAnnounce(),
        );
      case subjectt:
        return MaterialPageRoute(
          builder: (context) => const SubjectT(),
        );
      case teacherp:
        return MaterialPageRoute(
          builder: (context) => const TeacherP(),
        );
      case classroaster:
        return MaterialPageRoute(
          builder: (context) => const ClassRoaster(),
        );
      case childprot:
        return MaterialPageRoute(
          builder: (context) => const ChildProfileT(),
        );
      case makereport:
        return MaterialPageRoute(
          builder: (context) => const MakeReport(),
        );
      case tdetails:
        return MaterialPageRoute(
          builder: (context) => const TeacherDetails(),
        );
      case subj:
        return MaterialPageRoute(
          builder: (context) => const Subject(),
        );
      case gradespv:
        return MaterialPageRoute(
          builder: (context) => const GradesPrince(),
        );
      case teachprofpv:
        return MaterialPageRoute(
          builder: (context) => const TeacherProf(),
        );
      case attendencepv:
        return MaterialPageRoute(
          builder: (context) => const AttendancePV(),
        );
      case pvreport:
        return MaterialPageRoute(
          builder: (context) => const PVReport(),
        );
      case pcannounce:
        return MaterialPageRoute(
          builder: (context) => const PAnnouncements(),
        );
      case delannounceS:
        return MaterialPageRoute(
          builder: (context) => const DelAnnouncementS(),
        );
      case adminprofile:
        return MaterialPageRoute(
          builder: (context) => const AdminDetails(),
        );
      case gradeView:
        return MaterialPageRoute(builder: (context) => ViewGradeOverviewPage());
      case landingPage:
        return MaterialPageRoute(
            builder: (context) => const PrincipalLandingPage());
      case viewProfile:
        return MaterialPageRoute(builder: (context) => ProfileView());
      case makeAnnouncements:
        return MaterialPageRoute(
            builder: (context) => MakeSchoolAnnouncementPage());
      case viewAttendance:
        return MaterialPageRoute(builder: (context) => ViewAttendancePage());
      case viewAnnouncements:
        return MaterialPageRoute(builder: (context) => AnnouncementsPage());
      case parentViewProf:
        return MaterialPageRoute(builder: (context) => parentViewProfile());
      case learnerProfile:
        return MaterialPageRoute(builder: (context) => ViewAttendancePage());
      case principalGradeLanding:
        return MaterialPageRoute(
            builder: (context) => principalGradeLandingPage());
      //System Admin Routing
      case sysadminregschool:
        return MaterialPageRoute(
            builder: (context) => SchoolRegistrationForm());
      case sysadminRegRoles:
        return MaterialPageRoute(builder: (context) => RolesRegistrationPage());
      case sysadminviewprofile:
        return MaterialPageRoute(builder: (context) => ProfileViewS());
      //Parent Routing
      case parentlanding:
        return MaterialPageRoute(builder: (context) => ParentLandingPage());
      case parentSchoolPofile:
        return MaterialPageRoute(builder: (context) => ParentSchoolProfile());
      case parentViewann:
        return MaterialPageRoute(
            builder: (context) => ParentsAnnouncementsPage());
      // case parentDetailedAnn:
      //   return MaterialPageRoute(builder: (context) => parentDetailedAnn());
      case chatScreen:
        return MaterialPageRoute(
            builder: (context) => const ChatScreen(
                // contactName: '',
                // contactImage: '',
                ));
      case parentChatListPage:
        return MaterialPageRoute(builder: (context) => TChatListScreen());
      // case parentViewChildProf:
      //   return MaterialPageRoute(builder: (context) => parentViewChildProf);
      // case parentViewReport:
      //   return MaterialPageRoute(builder: (context) => parentViewReport());
      case parentViewAttendance:
        return MaterialPageRoute(builder: (context) => AttendanceRecordPage());
      case parentViewChildProf:
        return MaterialPageRoute(builder: (context) => ChildProfilePage());

      default:
        throw const FormatException('Page does not exist');
    }
  }
}

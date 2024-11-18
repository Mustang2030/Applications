import 'package:flutter/material.dart';
import 'package:scs/pages/child/attendance.dart';
import 'package:scs/pages/child/teacher_mark_attendence.dart';
import 'package:scs/pages/child/report.dart';
import 'package:scs/pages/parent/chat/parent_chat_screen.dart';
import 'package:scs/pages/parent/parent_landing_page.dart';
// import 'package:scs/pages/parent/parentlandingpage.dart';
import 'package:scs/pages/parent/parent_view_list_announcements.dart';
import 'package:scs/pages/parent/parentViewAttendance.dart';
import 'package:scs/pages/parent/parentViewChildProf.dart';
import 'package:scs/pages/parent/parentViewProf.dart';
import 'package:scs/pages/principal/principal_landing_page.dart';
import 'package:scs/pages/communication/make_announcement.dart';
import 'package:scs/pages/principal/principalViewAttendance.dart';
import 'package:scs/pages/principal/principalViewGrades.dart';
import 'package:scs/pages/principal/principal_view_detail_announcement.dart';
import 'package:scs/pages/principal/principal_view_profile.dart';
import 'package:scs/pages/principal/principlaGradeLanding.dart';
import 'package:scs/pages/communication/view_announcements.dart';
import 'package:scs/pages/principal/school_management/add_subjects.dart';
import 'package:scs/pages/principal/school_management/grade_overview.dart';
import 'package:scs/pages/principal/school_management/manage_school_grades.dart';
import 'package:scs/pages/principal/school_management/manage_teacher_class_assignement.dart';
import 'package:scs/pages/principal/school_management/school_management.dart';
import 'package:scs/pages/principal/school_management/teach_class_prof.dart';
import 'package:scs/pages/principal/school_management/update_school_info.dart';
import 'package:scs/pages/schools/schools_list.dart';
import 'package:scs/pages/systemadmin/rolesregistration.dart';
import 'package:scs/pages/systemadmin/schoolregistration.dart';
import 'package:scs/pages/systemadmin/sysadminViewProf.dart';
import 'package:scs/pages/systemadmin/systemadminlanding.dart';
import 'package:scs/pages/teachers/subj_class_roaster/subj_class_roaster.dart';
import 'package:scs/pages/teachers/teacher_class_roaster.dart';
import 'package:scs/pages/principal/attendence.dart';
import 'package:scs/pages/principal/principal_view_list_announcements.dart';
import 'package:scs/pages/principal/grades.dart';
import 'package:scs/pages/principal/principal_make_announcement.dart';
import 'package:scs/pages/principal/reports.dart';
import 'package:scs/pages/principal/teachprof.dart';
import 'package:scs/pages/teachers/teacher_make_announcement.dart';
import 'package:scs/pages/teachers/teacher_view_detail_announcement.dart';
import 'package:scs/pages/teachers/teacher_view_list_announcements.dart';
import 'package:scs/pages/teachers/chat/teacherchatlist.dart';
import 'package:scs/reg_and_log/slogin.dart';
import 'package:scs/pages/teachers/childprot.dart';
import 'package:scs/pages/teachers/makereport.dart';
import 'package:scs/pages/teachers/subj_class_roaster/subj.dart';
import 'package:scs/pages/teachers/teacher_landing_page.dart';
import 'package:scs/pages/communication/announce.dart';
import 'package:scs/pages/teachers/chat/chat_screen.dart';
import 'package:scs/pages/parent/chat/parent_chat_list.dart';
import 'package:scs/pages/communication/pcontactlist.dart';
import 'package:scs/pages/child/childpro.dart';
import 'package:scs/pages/communication/detailed_announce.dart';
import 'package:scs/pages/parent/parent_view_profile.dart';
import 'package:scs/reg_and_log/login.dart';
import 'package:scs/pages/teachers/subjectt.dart';
import 'package:scs/pages/teachers/teacher_view_profile.dart';

class RouteManagerProvider {
  static const String login = '/',
      slogin = '/slogin',
      register = '/register',
      adminprofile = '/adminprofile',
      teacherp = '/teacherp',
      schoolregistration = '/schoolregistration',
      roleregistration = '/roleregistration',
      pcontactlist = '/pcontactlist',
      chatscreen = '/chatscreen',
      announce = '/announce',
      childpro = '/childpro',
      attendance = '/attendance',
      announcementS = '/announcementS',
      dannounce = '/dannounce',
      report = '/report',
      pprofile = '/pprofile',
      schoolsList = '/schoolsList',
      subjectt = '/subjectt',
      childprot = '/childprot',
      makereport = '/makereport',
      tdetails = '/tdetails',
      gradespv = '/gradespv',
      teachprofpv = '/teachprofpv',
      attendencepv = '/attendencepv',
      pvreport = '/pvreport',

      // Princial
      principallandingpage = '/principallandingpage',
      principalMakeAnnounce = '/principal_make_announce',
      principalDetailAnnounce = '/principal_detail_announce',
      principalListAnnounce = "/principalListAnnounce",
      principalManageSchool = "/principalManageSchool",
      principalUpdateSchool = "/principalUpdateSchool",

      // Principle Manage School
      principalAssignTeacherToClass = "/principleAssignTeacherToClass",
      principleAnnouncementGroup = '/principleAnnouncementGroup',
      manageGrades = "/manageGrades",
      addSubjects = "/addSubjects",
      gradeOverview = "/gradeOverview",
      teachClassProf = "/teachClassProf",

      // Parent
      parent = '/parent',
      parentViewListAnnouncemnt = '/parentViewListAnnouncemnt',
      parenViewDetailAnnouncement = "/parenViewDetailAnnouncement",
      contactlist = '/contactlist',
      parentChatScreen = '/parentChatScreen',

      // Teacher
      teacherViewListAnnouncent = '/teacherViewListAnnouncent',
      teacherMakeAnnouncement = "/teacherMakeAnnouncement",
      teacherViewDetailAnnouncement = "/teacherDetailViewAnnouncement",
      teacherClassRoaster = '/teacherClassRoaster',
      teacherChatList = '/teacherChatList',
      chatScreen = '/chatScreen',
      subj = '/subj',
      subjClassRoaster = '/subjClassRoaster',
      mattendence = '/mattendence',

      // Learner
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
      parentViewChildProf = 'parent_view_child_prof',
      parentViewAttendance = 'parent_view_attendance',
      parentViewann = 'parent_view_ann',
      parentSchoolPofile = 'parent_school_profile',
      parentDetailedAnn = 'parent_detail_ann',
      parentViewProf = 'parent_view_prof',
      parentViewReport = 'parent_view_report';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Login
      case login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case slogin:
        return MaterialPageRoute(
          builder: (context) => const SLogin(),
        );

      // Principal
      case principallandingpage:
        return MaterialPageRoute(
          builder: (context) => const PrincipalLandingPage(),
        );
      case principalMakeAnnounce:
        return MaterialPageRoute(
          builder: (context) => const PrincipalMakeAnnouncements(),
        );
      case principalDetailAnnounce:
        return MaterialPageRoute(
          builder: (context) => const PrincipalDetailAnnounce(),
        );
      case viewProfile:
        return MaterialPageRoute(builder: (context) => PrincipalProfileView());
      case principalListAnnounce:
        return MaterialPageRoute(
            builder: (context) => PrincipalListAnnouncementsPage());
      case principalUpdateSchool:
        return MaterialPageRoute(builder: (context) => UpdateSchoolInfo());
      case principalManageSchool:
        return MaterialPageRoute(builder: (context) => SchoolManagement());
      case manageGrades:
        return MaterialPageRoute(builder: (context) => ManageSchoolGrades());
      case addSubjects:
        return MaterialPageRoute(builder: (context) => AddSubjects());
      case gradeOverview:
        return MaterialPageRoute(builder: (context) => GradeOverview());
      case teachClassProf:
        return MaterialPageRoute(builder: (context) => TeachClassProf());

      // Principle Manage School
      case principalAssignTeacherToClass:
        return MaterialPageRoute(
            builder: (context) => ManageTeacherClassAssignemnt());

      // System Admin
      case systemadminlanding:
        return MaterialPageRoute(
          builder: (context) => const SysAdminLandingPage(),
        );
      case schoolregistration:
        return MaterialPageRoute(
          builder: (context) => const SchoolRegistration(),
        );
      case roleregistration:
        return MaterialPageRoute(
          builder: (context) => const RoleRegistration(),
        );

      // Parent
      case parent:
        return MaterialPageRoute(
          builder: (context) => const ParentPage(),
        );
      case parentViewListAnnouncemnt:
        return MaterialPageRoute(
          builder: (context) => const ParentsAnnouncementsPage(),
        );
      case schoolsList:
        return MaterialPageRoute(
          builder: (context) => const SchoolsList(),
        );
      case contactlist:
        return MaterialPageRoute(
          builder: (context) => const ContactList(),
        );
      case parentChatScreen:
        return MaterialPageRoute(
          builder: (context) => const ParentChatScreen(),
        );

      // Teacher
      case teacherMakeAnnouncement:
        return MaterialPageRoute(
            builder: (context) => TeacherMakeSchoolAnnouncementPage());
      case teacherViewDetailAnnouncement:
        return MaterialPageRoute(
            builder: (context) => TeacherViewDetailAnnounce());
      case teacherViewListAnnouncent:
        return MaterialPageRoute(
            builder: (context) => TeacherViewListAnnouncementsPage());
      case teacherClassRoaster:
        return MaterialPageRoute(
          builder: (context) => const TeacherClassRoaster(),
        );
      case teacherChatList:
        return MaterialPageRoute(builder: (context) => UserChatList());
      case chatScreen:
        return MaterialPageRoute(builder: (context) => const ChatScreen());
      case subj:
        return MaterialPageRoute(
          builder: (context) => const Subject(),
        );
      case subjClassRoaster:
        return MaterialPageRoute(
          builder: (context) => const SubjClassRoaster(),
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

      //In the waterS
      case childprot:
        return MaterialPageRoute(
          builder: (context) => const ChildProfileT(),
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

      case makereport:
        return MaterialPageRoute(
          builder: (context) => const MakeReport(),
        );
      case tdetails:
        return MaterialPageRoute(
          builder: (context) => const TeacherDetails(),
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
      case gradeView:
        return MaterialPageRoute(builder: (context) => ViewGradeOverviewPage());

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

      case sysadminviewprofile:
        return MaterialPageRoute(builder: (context) => ProfileViewS());
      //Parent Routing
      // case parentlanding:
      //   return MaterialPageRoute(builder: (context) => ParentLandingPage());

      case parentViewann:
        return MaterialPageRoute(
            builder: (context) => ParentsAnnouncementsPage());
      // case parentDetailedAnn:
      //   return MaterialPageRoute(builder: (context) => parentDetailedAnn());

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

-- MySQL dump 10.13  Distrib 5.6.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: edxtest
-- ------------------------------------------------------
-- Server version	5.6.32-1+deb.sury.org~xenial+0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-11-14 10:40:27.152319'),(2,'auth','0001_initial','2017-11-14 10:40:27.410249'),(3,'admin','0001_initial','2017-11-14 10:40:27.491567'),(4,'sites','0001_initial','2017-11-14 10:40:27.517638'),(5,'contenttypes','0002_remove_content_type_name','2017-11-14 10:40:27.666274'),(6,'api_admin','0001_initial','2017-11-14 10:40:27.842871'),(7,'api_admin','0002_auto_20160325_1604','2017-11-14 10:40:27.867669'),(8,'api_admin','0003_auto_20160404_1618','2017-11-14 10:40:28.316069'),(9,'api_admin','0004_auto_20160412_1506','2017-11-14 10:40:28.638681'),(10,'api_admin','0005_auto_20160414_1232','2017-11-14 10:40:28.724948'),(11,'api_admin','0006_catalog','2017-11-14 10:40:28.738587'),(12,'assessment','0001_initial','2017-11-14 10:40:31.316422'),(13,'assessment','0002_staffworkflow','2017-11-14 10:40:31.403045'),(14,'assessment','0003_expand_course_id','2017-11-14 10:40:32.030973'),(15,'auth','0002_alter_permission_name_max_length','2017-11-14 10:40:32.108361'),(16,'auth','0003_alter_user_email_max_length','2017-11-14 10:40:32.184431'),(17,'auth','0004_alter_user_username_opts','2017-11-14 10:40:32.245694'),(18,'auth','0005_alter_user_last_login_null','2017-11-14 10:40:32.317802'),(19,'auth','0006_require_contenttypes_0002','2017-11-14 10:40:32.321529'),(20,'instructor_task','0001_initial','2017-11-14 10:40:32.441254'),(21,'certificates','0001_initial','2017-11-14 10:40:33.466253'),(22,'certificates','0002_data__certificatehtmlviewconfiguration_data','2017-11-14 10:40:33.487280'),(23,'certificates','0003_data__default_modes','2017-11-14 10:40:38.590098'),(24,'certificates','0003_verbose_names','2017-11-14 10:40:38.688283'),(25,'certificates','0004_certificategenerationhistory','2017-11-14 10:40:38.853699'),(26,'certificates','0005_auto_20151208_0801','2017-11-14 10:40:38.956582'),(27,'certificates','0005_verbose_names','2017-11-14 10:40:42.446689'),(28,'certificates','0006_generatedcertificate_template_version','2017-11-14 10:40:42.580260'),(29,'certificates','0006_certificatetemplateasset_asset_slug','2017-11-14 10:40:42.655582'),(30,'certificates','0007_certificateinvalidation','2017-11-14 10:40:43.193709'),(31,'badges','0001_initial','2017-11-14 10:40:43.718281'),(32,'badges','0002_data__migrate_assertions','2017-11-14 10:40:43.751606'),(33,'badges','0003_schema__add_event_configuration','2017-11-14 10:40:44.039161'),(34,'block_structure','0001_config','2017-11-14 10:40:44.210167'),(35,'block_structure','0002_blockstructuremodel','2017-11-14 10:40:44.245246'),(36,'block_structure','0003_blockstructuremodel_storage','2017-11-14 10:40:44.269611'),(37,'block_structure','0004_blockstructuremodel_usagekeywithrun','2017-11-14 10:40:44.292390'),(38,'bookmarks','0001_initial','2017-11-14 10:40:44.859075'),(39,'branding','0001_initial','2017-11-14 10:40:45.234619'),(40,'course_modes','0001_initial','2017-11-14 10:40:45.348766'),(41,'course_modes','0001_verbose_names','2017-11-14 10:40:45.523972'),(42,'course_modes','0002_coursemode_expiration_datetime_is_explicit','2017-11-14 10:40:45.573443'),(43,'course_modes','0003_auto_20151113_1443','2017-11-14 10:40:45.602593'),(44,'course_modes','0004_auto_20151113_1457','2017-11-14 10:40:45.807628'),(45,'course_modes','0005_auto_20151217_0958','2017-11-14 10:40:45.840821'),(46,'course_modes','0006_auto_20160208_1407','2017-11-14 10:40:46.006817'),(47,'course_modes','0007_coursemode_bulk_sku','2017-11-14 10:40:46.058183'),(48,'course_groups','0001_initial','2017-11-14 10:40:47.721866'),(49,'bulk_email','0001_initial','2017-11-14 10:40:48.513401'),(50,'bulk_email','0002_data__load_course_email_template','2017-11-14 10:40:48.642831'),(51,'bulk_email','0003_config_model_feature_flag','2017-11-14 10:40:48.888596'),(52,'bulk_email','0004_add_email_targets','2017-11-14 10:40:49.690239'),(53,'bulk_email','0005_move_target_data','2017-11-14 10:40:49.712672'),(54,'bulk_email','0006_course_mode_targets','2017-11-14 10:40:50.252972'),(55,'catalog','0001_initial','2017-11-14 10:40:50.554577'),(56,'catalog','0002_catalogintegration_username','2017-11-14 10:40:50.830575'),(57,'catalog','0003_catalogintegration_page_size','2017-11-14 10:40:51.110510'),(58,'catalog','0004_auto_20170616_0618','2017-11-14 10:40:51.364721'),(59,'django_comment_common','0001_initial','2017-11-14 10:40:52.070286'),(60,'django_comment_common','0002_forumsconfig','2017-11-14 10:40:52.390799'),(61,'verified_track_content','0001_initial','2017-11-14 10:40:52.432577'),(62,'course_overviews','0001_initial','2017-11-14 10:40:52.534631'),(63,'course_overviews','0002_add_course_catalog_fields','2017-11-14 10:40:52.770875'),(64,'course_overviews','0003_courseoverviewgeneratedhistory','2017-11-14 10:40:52.806045'),(65,'course_overviews','0004_courseoverview_org','2017-11-14 10:40:52.854556'),(66,'course_overviews','0005_delete_courseoverviewgeneratedhistory','2017-11-14 10:40:52.883938'),(67,'course_overviews','0006_courseoverviewimageset','2017-11-14 10:40:52.950653'),(68,'course_overviews','0007_courseoverviewimageconfig','2017-11-14 10:40:53.278981'),(69,'course_overviews','0008_remove_courseoverview_facebook_url','2017-11-14 10:40:53.284952'),(70,'course_overviews','0009_readd_facebook_url','2017-11-14 10:40:53.291001'),(71,'course_overviews','0010_auto_20160329_2317','2017-11-14 10:40:53.400778'),(72,'ccx','0001_initial','2017-11-14 10:40:54.462079'),(73,'ccx','0002_customcourseforedx_structure_json','2017-11-14 10:40:54.798316'),(74,'ccx','0003_add_master_course_staff_in_ccx','2017-11-14 10:40:54.828108'),(75,'ccx','0004_seed_forum_roles_in_ccx_courses','2017-11-14 10:40:54.853320'),(76,'ccx','0005_change_ccx_coach_to_staff','2017-11-14 10:40:54.879113'),(77,'ccxcon','0001_initial_ccxcon_model','2017-11-14 10:40:54.924719'),(78,'ccxcon','0002_auto_20160325_0407','2017-11-14 10:40:54.953413'),(79,'djcelery','0001_initial','2017-11-14 10:40:55.399641'),(80,'celery_utils','0001_initial','2017-11-14 10:40:55.487788'),(81,'celery_utils','0002_chordable_django_backend','2017-11-14 10:40:55.605297'),(82,'certificates','0008_schema__remove_badges','2017-11-14 10:40:56.359040'),(83,'commerce','0001_data__add_ecommerce_service_user','2017-11-14 10:40:56.400516'),(84,'commerce','0002_commerceconfiguration','2017-11-14 10:40:56.769862'),(85,'commerce','0003_auto_20160329_0709','2017-11-14 10:40:57.087703'),(86,'commerce','0004_auto_20160531_0950','2017-11-14 10:40:57.798862'),(87,'commerce','0005_commerceconfiguration_enable_automatic_refund_approval','2017-11-14 10:40:58.170495'),(88,'commerce','0006_auto_20170424_1734','2017-11-14 10:40:58.526802'),(89,'contentserver','0001_initial','2017-11-14 10:40:58.919338'),(90,'contentserver','0002_cdnuseragentsconfig','2017-11-14 10:40:59.317521'),(91,'cors_csrf','0001_initial','2017-11-14 10:40:59.729284'),(92,'course_action_state','0001_initial','2017-11-14 10:41:00.578674'),(93,'course_groups','0002_change_inline_default_cohort_value','2017-11-14 10:41:00.615762'),(94,'course_groups','0003_auto_20170609_1455','2017-11-14 10:41:01.486035'),(95,'course_overviews','0011_courseoverview_marketing_url','2017-11-14 10:41:01.588770'),(96,'course_overviews','0012_courseoverview_eligible_for_financial_aid','2017-11-14 10:41:01.693723'),(97,'course_overviews','0013_courseoverview_language','2017-11-14 10:41:01.797778'),(98,'course_structures','0001_initial','2017-11-14 10:41:01.894648'),(99,'courseware','0001_initial','2017-11-14 10:41:09.586755'),(100,'coursewarehistoryextended','0001_initial','2017-11-14 10:41:09.878658'),(101,'coursewarehistoryextended','0002_force_studentmodule_index','2017-11-14 10:41:10.177145'),(102,'crawlers','0001_initial','2017-11-14 10:41:10.528479'),(103,'crawlers','0002_auto_20170419_0018','2017-11-14 10:41:10.825895'),(104,'credentials','0001_initial','2017-11-14 10:41:11.174475'),(105,'credentials','0002_auto_20160325_0631','2017-11-14 10:41:11.473568'),(106,'credentials','0003_auto_20170525_1109','2017-11-14 10:41:12.122302'),(107,'credit','0001_initial','2017-11-14 10:41:15.270083'),(108,'credit','0002_creditconfig','2017-11-14 10:41:15.717653'),(109,'credit','0003_auto_20160511_2227','2017-11-14 10:41:16.116147'),(110,'dark_lang','0001_initial','2017-11-14 10:41:16.626693'),(111,'dark_lang','0002_data__enable_on_install','2017-11-14 10:41:16.663096'),(112,'database_fixups','0001_initial','2017-11-14 10:41:16.735283'),(113,'django_comment_common','0003_enable_forums','2017-11-14 10:41:16.785848'),(114,'django_comment_common','0004_auto_20161117_1209','2017-11-14 10:41:17.237447'),(115,'django_comment_common','0005_coursediscussionsettings','2017-11-14 10:41:17.291630'),(116,'django_notify','0001_initial','2017-11-14 10:41:19.410252'),(117,'django_openid_auth','0001_initial','2017-11-14 10:41:20.054934'),(118,'oauth2','0001_initial','2017-11-14 10:41:23.318244'),(119,'edx_oauth2_provider','0001_initial','2017-11-14 10:41:24.092579'),(120,'edx_proctoring','0001_initial','2017-11-14 10:41:36.323157'),(121,'edx_proctoring','0002_proctoredexamstudentattempt_is_status_acknowledged','2017-11-14 10:41:37.383823'),(122,'edx_proctoring','0003_auto_20160101_0525','2017-11-14 10:41:39.443717'),(123,'edx_proctoring','0004_auto_20160201_0523','2017-11-14 10:41:40.477112'),(124,'edx_proctoring','0005_proctoredexam_hide_after_due','2017-11-14 10:41:41.520253'),(125,'edxval','0001_initial','2017-11-14 10:41:42.383821'),(126,'edxval','0002_data__default_profiles','2017-11-14 10:41:42.458650'),(127,'edxval','0003_coursevideo_is_hidden','2017-11-14 10:41:42.606835'),(128,'edxval','0004_data__add_hls_profile','2017-11-14 10:41:42.667520'),(129,'email_marketing','0001_initial','2017-11-14 10:41:44.196289'),(130,'email_marketing','0002_auto_20160623_1656','2017-11-14 10:41:54.957745'),(131,'email_marketing','0003_auto_20160715_1145','2017-11-14 10:41:59.970652'),(132,'email_marketing','0004_emailmarketingconfiguration_welcome_email_send_delay','2017-11-14 10:42:00.990829'),(133,'embargo','0001_initial','2017-11-14 10:42:06.880165'),(134,'embargo','0002_data__add_countries','2017-11-14 10:42:07.408062'),(135,'enterprise','0001_initial','2017-11-14 10:42:08.113280'),(136,'enterprise','0002_enterprisecustomerbrandingconfiguration','2017-11-14 10:42:08.198351'),(137,'enterprise','0003_auto_20161104_0937','2017-11-14 10:42:09.698119'),(138,'enterprise','0004_auto_20161114_0434','2017-11-14 10:42:10.646994'),(139,'enterprise','0005_pendingenterprisecustomeruser','2017-11-14 10:42:11.136373'),(140,'enterprise','0006_auto_20161121_0241','2017-11-14 10:42:11.597672'),(141,'enterprise','0007_auto_20161109_1511','2017-11-14 10:42:12.580940'),(142,'enterprise','0008_auto_20161124_2355','2017-11-14 10:42:14.184008'),(143,'enterprise','0009_auto_20161130_1651','2017-11-14 10:42:17.908484'),(144,'enterprise','0010_auto_20161222_1212','2017-11-14 10:42:19.337917'),(145,'enterprise','0011_enterprisecustomerentitlement_historicalenterprisecustomerentitlement','2017-11-14 10:42:20.995718'),(146,'enterprise','0012_auto_20170125_1033','2017-11-14 10:42:22.719043'),(147,'enterprise','0013_auto_20170125_1157','2017-11-14 10:42:26.182743'),(148,'enterprise','0014_enrollmentnotificationemailtemplate_historicalenrollmentnotificationemailtemplate','2017-11-14 10:42:28.638693'),(149,'enterprise','0015_auto_20170130_0003','2017-11-14 10:42:31.131100'),(150,'enterprise','0016_auto_20170405_0647','2017-11-14 10:42:51.600766'),(151,'enterprise','0017_auto_20170508_1341','2017-11-14 10:42:56.641765'),(152,'enterprise','0018_auto_20170511_1357','2017-11-14 10:42:59.278258'),(153,'enterprise','0019_auto_20170606_1853','2017-11-14 10:43:02.092733'),(154,'experiments','0001_initial','2017-11-14 10:43:08.736929'),(155,'experiments','0002_auto_20170627_1402','2017-11-14 10:43:08.861601'),(156,'external_auth','0001_initial','2017-11-14 10:43:09.950595'),(157,'grades','0001_initial','2017-11-14 10:43:10.226127'),(158,'grades','0002_rename_last_edited_field','2017-11-14 10:43:10.281411'),(159,'grades','0003_coursepersistentgradesflag_persistentgradesenabledflag','2017-11-14 10:43:11.385479'),(160,'grades','0004_visibleblocks_course_id','2017-11-14 10:43:11.469904'),(161,'grades','0005_multiple_course_flags','2017-11-14 10:43:12.023868'),(162,'grades','0006_persistent_course_grades','2017-11-14 10:43:12.149775'),(163,'grades','0007_add_passed_timestamp_column','2017-11-14 10:43:12.268694'),(164,'grades','0008_persistentsubsectiongrade_first_attempted','2017-11-14 10:43:12.345660'),(165,'grades','0009_auto_20170111_1507','2017-11-14 10:43:12.471499'),(166,'grades','0010_auto_20170112_1156','2017-11-14 10:43:12.537882'),(167,'grades','0011_null_edited_time','2017-11-14 10:43:12.740522'),(168,'grades','0012_computegradessetting','2017-11-14 10:43:13.339658'),(169,'instructor_task','0002_gradereportsetting','2017-11-14 10:43:13.919358'),(170,'integrated_channel','0001_initial','2017-11-14 10:43:14.031235'),(171,'lms_xblock','0001_initial','2017-11-14 10:43:14.695011'),(172,'microsite_configuration','0001_initial','2017-11-14 10:43:22.730301'),(173,'microsite_configuration','0002_auto_20160202_0228','2017-11-14 10:43:25.443334'),(174,'milestones','0001_initial','2017-11-14 10:43:26.743555'),(175,'milestones','0002_data__seed_relationship_types','2017-11-14 10:43:26.797856'),(176,'milestones','0003_coursecontentmilestone_requirements','2017-11-14 10:43:26.920997'),(177,'milestones','0004_auto_20151221_1445','2017-11-14 10:43:27.347398'),(178,'mobile_api','0001_initial','2017-11-14 10:43:28.788158'),(179,'mobile_api','0002_auto_20160406_0904','2017-11-14 10:43:28.912085'),(180,'mobile_api','0003_ignore_mobile_available_flag','2017-11-14 10:43:31.776352'),(181,'notes','0001_initial','2017-11-14 10:43:33.233173'),(182,'oauth2','0002_auto_20160404_0813','2017-11-14 10:43:37.601839'),(183,'oauth2','0003_client_logout_uri','2017-11-14 10:43:39.021863'),(184,'oauth2','0004_add_index_on_grant_expires','2017-11-14 10:43:40.467602'),(185,'oauth2_provider','0001_initial','2017-11-14 10:43:46.484597'),(186,'oauth2_provider','0002_08_updates','2017-11-14 10:43:51.165294'),(187,'oauth_dispatch','0001_initial','2017-11-14 10:43:52.797161'),(188,'oauth_provider','0001_initial','2017-11-14 10:43:56.195992'),(189,'organizations','0001_initial','2017-11-14 10:43:56.452416'),(190,'organizations','0002_auto_20170117_1434','2017-11-14 10:43:56.520181'),(191,'organizations','0003_auto_20170221_1138','2017-11-14 10:43:56.665650'),(192,'organizations','0004_auto_20170413_2315','2017-11-14 10:43:56.792099'),(193,'programs','0001_initial','2017-11-14 10:44:02.392572'),(194,'programs','0002_programsapiconfig_cache_ttl','2017-11-14 10:44:03.262917'),(195,'programs','0003_auto_20151120_1613','2017-11-14 10:44:06.174393'),(196,'programs','0004_programsapiconfig_enable_certification','2017-11-14 10:44:06.962458'),(197,'programs','0005_programsapiconfig_max_retries','2017-11-14 10:44:07.875884'),(198,'programs','0006_programsapiconfig_xseries_ad_enabled','2017-11-14 10:44:08.822954'),(199,'programs','0007_programsapiconfig_program_listing_enabled','2017-11-14 10:44:09.902487'),(200,'programs','0008_programsapiconfig_program_details_enabled','2017-11-14 10:44:11.053530'),(201,'programs','0009_programsapiconfig_marketing_path','2017-11-14 10:44:12.497427'),(202,'programs','0010_auto_20170204_2332','2017-11-14 10:44:15.330089'),(203,'programs','0011_auto_20170301_1844','2017-11-14 10:44:35.382112'),(204,'programs','0012_auto_20170419_0018','2017-11-14 10:44:36.894931'),(205,'redirects','0001_initial','2017-11-14 10:44:38.504983'),(206,'rss_proxy','0001_initial','2017-11-14 10:44:38.575781'),(207,'sap_success_factors','0001_initial','2017-11-14 10:44:43.792600'),(208,'sap_success_factors','0002_auto_20170224_1545','2017-11-14 10:44:54.207258'),(209,'sap_success_factors','0003_auto_20170317_1402','2017-11-14 10:44:58.104030'),(210,'sap_success_factors','0004_catalogtransmissionaudit_audit_summary','2017-11-14 10:44:58.178000'),(211,'self_paced','0001_initial','2017-11-14 10:45:00.062618'),(212,'sessions','0001_initial','2017-11-14 10:45:00.149606'),(213,'student','0001_initial','2017-11-14 10:45:40.518399'),(214,'shoppingcart','0001_initial','2017-11-14 10:46:21.630344'),(215,'shoppingcart','0002_auto_20151208_1034','2017-11-14 10:46:26.383749'),(216,'shoppingcart','0003_auto_20151217_0958','2017-11-14 10:46:32.203217'),(217,'site_configuration','0001_initial','2017-11-14 10:46:34.011726'),(218,'site_configuration','0002_auto_20160720_0231','2017-11-14 10:46:35.864409'),(219,'default','0001_initial','2017-11-14 10:46:38.089782'),(220,'social_auth','0001_initial','2017-11-14 10:46:38.100209'),(221,'default','0002_add_related_name','2017-11-14 10:46:39.076487'),(222,'social_auth','0002_add_related_name','2017-11-14 10:46:39.087385'),(223,'default','0003_alter_email_max_length','2017-11-14 10:46:39.180790'),(224,'social_auth','0003_alter_email_max_length','2017-11-14 10:46:39.192668'),(225,'default','0004_auto_20160423_0400','2017-11-14 10:46:40.256977'),(226,'social_auth','0004_auto_20160423_0400','2017-11-14 10:46:40.271510'),(227,'social_auth','0005_auto_20160727_2333','2017-11-14 10:46:40.350135'),(228,'social_django','0006_partial','2017-11-14 10:46:40.439560'),(229,'splash','0001_initial','2017-11-14 10:46:42.177446'),(230,'static_replace','0001_initial','2017-11-14 10:46:44.105960'),(231,'static_replace','0002_assetexcludedextensionsconfig','2017-11-14 10:46:46.108698'),(232,'status','0001_initial','2017-11-14 10:46:50.328314'),(233,'student','0002_auto_20151208_1034','2017-11-14 10:46:54.266272'),(234,'student','0003_auto_20160516_0938','2017-11-14 10:46:58.381463'),(235,'student','0004_auto_20160531_1422','2017-11-14 10:47:00.461276'),(236,'student','0005_auto_20160531_1653','2017-11-14 10:47:02.892946'),(237,'student','0006_logoutviewconfiguration','2017-11-14 10:47:04.877473'),(238,'student','0007_registrationcookieconfiguration','2017-11-14 10:47:07.091959'),(239,'student','0008_auto_20161117_1209','2017-11-14 10:47:09.199199'),(240,'student','0009_auto_20170111_0422','2017-11-14 10:47:11.312967'),(241,'student','0010_auto_20170207_0458','2017-11-14 10:47:11.328759'),(242,'submissions','0001_initial','2017-11-14 10:47:12.333347'),(243,'submissions','0002_auto_20151119_0913','2017-11-14 10:47:12.612477'),(244,'submissions','0003_submission_status','2017-11-14 10:47:12.759618'),(245,'survey','0001_initial','2017-11-14 10:47:15.569076'),(246,'teams','0001_initial','2017-11-14 10:47:22.637711'),(247,'theming','0001_initial','2017-11-14 10:47:25.161956'),(248,'third_party_auth','0001_initial','2017-11-14 10:47:37.284291'),(249,'third_party_auth','0002_schema__provider_icon_image','2017-11-14 10:47:48.384142'),(250,'third_party_auth','0003_samlproviderconfig_debug_mode','2017-11-14 10:47:50.312444'),(251,'third_party_auth','0004_add_visible_field','2017-11-14 10:48:02.378201'),(252,'third_party_auth','0005_add_site_field','2017-11-14 10:48:13.351636'),(253,'third_party_auth','0006_samlproviderconfig_automatic_refresh_enabled','2017-11-14 10:48:15.584031'),(254,'third_party_auth','0007_auto_20170406_0912','2017-11-14 10:48:20.082221'),(255,'third_party_auth','0008_auto_20170413_1455','2017-11-14 10:48:27.621485'),(256,'third_party_auth','0009_auto_20170415_1144','2017-11-14 10:48:35.725681'),(257,'third_party_auth','0010_add_skip_hinted_login_dialog_field','2017-11-14 10:48:43.793151'),(258,'third_party_auth','0011_auto_20170616_0112','2017-11-14 10:48:46.539144'),(259,'third_party_auth','0012_auto_20170626_1135','2017-11-14 10:48:55.534367'),(260,'track','0001_initial','2017-11-14 10:48:55.625266'),(261,'user_api','0001_initial','2017-11-14 10:49:03.588165'),(262,'util','0001_initial','2017-11-14 10:49:05.436712'),(263,'util','0002_data__default_rate_limit_config','2017-11-14 10:49:05.512736'),(264,'verified_track_content','0002_verifiedtrackcohortedcourse_verified_cohort_name','2017-11-14 10:49:05.608348'),(265,'verify_student','0001_initial','2017-11-14 10:49:25.786994'),(266,'verify_student','0002_auto_20151124_1024','2017-11-14 10:49:28.039573'),(267,'verify_student','0003_auto_20151113_1443','2017-11-14 10:49:30.380703'),(268,'video_config','0001_initial','2017-11-14 10:49:35.055306'),(269,'waffle','0001_initial','2017-11-14 10:49:37.696613'),(270,'waffle','0002_auto_20161201_0958','2017-11-14 10:49:37.774579'),(271,'waffle_utils','0001_initial','2017-11-14 10:49:40.188336'),(272,'wiki','0001_initial','2017-11-14 10:50:36.665911'),(273,'wiki','0002_remove_article_subscription','2017-11-14 10:50:36.743274'),(274,'wiki','0003_ip_address_conv','2017-11-14 10:50:44.222588'),(275,'wiki','0004_increase_slug_size','2017-11-14 10:50:46.883553'),(276,'workflow','0001_initial','2017-11-14 10:50:47.273738'),(277,'xblock_django','0001_initial','2017-11-14 10:50:49.991046'),(278,'xblock_django','0002_auto_20160204_0809','2017-11-14 10:50:52.967588'),(279,'xblock_django','0003_add_new_config_models','2017-11-14 10:51:02.668545'),(280,'xblock_django','0004_delete_xblock_disable_config','2017-11-14 10:51:06.015615'),(281,'social_django','0002_add_related_name','2017-11-14 10:51:06.043034'),(282,'social_django','0003_alter_email_max_length','2017-11-14 10:51:06.055343'),(283,'social_django','0001_initial','2017-11-14 10:51:06.067618'),(284,'social_django','0004_auto_20160423_0400','2017-11-14 10:51:06.079975'),(285,'social_django','0005_auto_20160727_2333','2017-11-14 10:51:06.092135'),(286,'contentstore','0001_initial','2017-11-14 10:52:33.188881'),(287,'course_creators','0001_initial','2017-11-14 10:52:33.293227'),(288,'tagging','0001_initial','2017-11-14 10:52:33.491681'),(289,'tagging','0002_auto_20170116_1541','2017-11-14 10:52:33.572981'),(290,'user_tasks','0001_initial','2017-11-14 10:52:34.964624'),(291,'user_tasks','0002_artifact_file_storage','2017-11-14 10:52:35.401590'),(292,'xblock_config','0001_initial','2017-11-14 10:52:35.960963'),(293,'xblock_config','0002_courseeditltifieldsenabledflag','2017-11-14 10:52:36.522171');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-14 10:52:48

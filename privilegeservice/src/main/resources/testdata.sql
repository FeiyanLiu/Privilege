-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: oomall
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `auth_new_user`
--

LOCK TABLES `auth_new_user` WRITE;
/*!40000 ALTER TABLE `auth_new_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_new_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_privilege`
--

LOCK TABLES `auth_privilege` WRITE;
/*!40000 ALTER TABLE `auth_privilege` DISABLE KEYS */;
INSERT INTO `auth_privilege` VALUES (2,'查看任意用户信息','/adminusers/{id}',0,'e935a1c80f67b643a14a35342e0e6035c853985dcc655f3cb66f8f389e12881f','2020-11-01 09:52:20','2020-11-02 21:51:45'),(3,'修改任意用户信息','/adminusers/{id}',2,'47c7b664dfe1392f11130b255fc2180bf29d0977c3f03140c6eb11d1a8ba9a11','2020-11-01 09:53:03','2020-11-02 21:51:45'),(4,'删除用户','/adminusers/{id}',3,'34c8fc0b1b95d3d1923193d4e33f577d898ba76a2b9a32f40012e2e8fce4e3cf','2020-11-01 09:53:36','2020-11-02 21:51:45'),(5,'恢复用户','/adminusers/{id}/release',2,'ed6f2194ba61f1ee561d0ae2e3074ceb4537b8a6ed3adac1751301d7226854f7','2020-11-01 09:59:24','2020-11-02 21:51:45'),(6,'禁止用户登录','/adminusers/{id}/forbid',2,'c92bd57248b366c24e64adee6645d13330aee4b74511f39572bcc1ea5740cdd2','2020-11-01 10:02:32','2020-11-02 21:51:45'),(7,'赋予用户角色','/adminusers/{id}/roles/{id}',1,'212e8971d4e3ded86d567fee22794b5c93084c6baa93ad5ad0898e4c18abe9fa','2020-11-01 10:02:35','2020-11-02 21:51:45'),(8,'取消用户角色','/adminusers/{id}/roles/{id}',3,'3a76849e4eb439060c53a3ab1c9c86692db0f25695966bd0d5d8e3d647e10de2','2020-11-01 10:03:16','2020-11-02 21:51:45'),(9,'新增角色','/roles',1,'0f0c7264ebf4471839e6f70a53cf8ba80db9be8425430c2bbc87ff425eab8370','2020-11-01 10:04:09','2020-11-02 21:51:45'),(10,'删除角色','/roles/{id}',3,'26cca90a93f45a63e8b833dd6c6e7719e26d19ee6a7310edabc5c639a1052b9e','2020-11-01 10:04:42','2020-11-02 21:51:45'),(11,'修改角色信息','/roles/{id}',2,'04c693372e4eed426572c53db4af7838f0ac73142abdce9571885b8fe8b47be7','2020-11-01 10:05:20','2020-11-02 21:51:45'),(12,'给角色增加权限','/roles/{id}/privileges/{id}',1,'d70522f0960bdd1cb61b45d1d221beb30cd5813d9a41eac23da339ec648f4fc4','2020-11-01 10:06:03','2020-11-02 21:51:46'),(13,'取消角色权限','/roleprivileges/{id}',3,'aa8f57955f6652636cdcee567abff1bacff7cb529cff3dba632b95fed328f3ac','2020-11-01 10:06:43','2020-11-03 21:30:31'),(14,'修改权限信息','/privileges/{id}',2,'291c2f3703a762ee80553c00ab3d303a889b1d969b1638b1cc392e6ff161ccbd','2020-11-01 10:08:18','2020-11-02 21:51:46'),(15,'查看所有用户的角色','/adminusers/{id}/roles',0,'93c99f9a033ede52179ebf49c68c46c79c850827d433233bcf356c1572b70447','2020-11-03 17:53:38','2020-11-03 19:48:47'),(16,'查看所有代理','/proxies',0,'65b3099754b9d076a6d690bd85b6e7951dfaf21335521422fa3ab253f08adeeb','2020-11-03 17:55:31','2020-11-03 19:48:47'),(17,'禁止代理关系','/allproxies/{id}',3,'f87cf617d983a0719ea6ef0129f407eb44de91afb02d60a9b83bbe6cade9436d','2020-11-03 17:57:45','2020-11-03 19:48:47'),(18,'取消任意用户角色','/adminuserroles/{id}',3,'130ee544d8ac5c9560d6ad9a095d2cfc2659e3c7825b2197239ca3909f37688a','2020-11-03 19:52:04','2020-11-03 19:56:43'),(19,'管理员设置用户代理关系','/ausers/{id}/busers/{id}:\n',1,'efd21d08fe39b6c6927b0cfb078b0fb774fdd4c5b4662603d1ebb92aad31de71','2020-11-04 13:10:02',NULL);
/*!40000 ALTER TABLE `auth_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_role`
--

LOCK TABLES `auth_role` WRITE;
/*!40000 ALTER TABLE `auth_role` DISABLE KEYS */;
INSERT INTO `auth_role` VALUES (23,'管理员',1,'超级管理员，所有权限都有','2020-11-01 09:48:24','2020-11-01 09:48:24'),(80,'财务',1,NULL,'2020-11-01 09:48:24','2020-11-01 09:48:24'),(81,'客服',1,NULL,'2020-11-01 09:48:24','2020-11-01 09:48:24'),(82,'运营部',1,NULL,'2020-11-01 09:48:24','2020-11-01 09:48:24'),(83,'产品部',1,NULL,'2020-11-01 09:48:24','2020-11-01 09:48:24'),(84,'文案',1,NULL,'2020-11-01 09:48:24','2020-11-01 09:48:24'),(85,'总经办',1,NULL,'2020-11-01 09:48:24','2020-11-01 09:48:24'),(86,'库管',1,NULL,'2020-11-01 09:48:24','2020-11-01 09:48:24'),(87,'辅助管理员',1,'一般的管理员','2020-11-03 15:45:20',NULL);
/*!40000 ALTER TABLE `auth_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_role_privilege`
--

LOCK TABLES `auth_role_privilege` WRITE;
/*!40000 ALTER TABLE `auth_role_privilege` DISABLE KEYS */;
INSERT INTO `auth_role_privilege` VALUES (1,23,2,1,'2020-11-01 10:11:21','bef152f568d0840afb361e9c9d1f991db5ee495ce3806e82090b75a329b2dfde'),(2,23,3,1,'2020-11-01 10:11:53','c117552062e29547a688dfe6e3f3575d67e80ab567d23d504ec32892169ce669'),(3,23,4,1,'2020-11-01 10:12:15','defd118dcc771d1107683a8e4c637f83088b4a76514374445ef95d027e4b65ef'),(4,23,5,1,'2020-11-01 10:12:15','0437187400fbcdbbeb1d17aff8d86cb8a13a1707662fb2cacfca014a33266472'),(5,23,6,1,'2020-11-01 10:12:15','6386c022a2b4261b63e8796046e3c8ce8bec0663032ada5189041104648c3604'),(6,23,7,1,'2020-11-01 10:12:15','d77368d6d7d9c84e887968796d9e55948019ca8c61bdd99a802971ff35dc6596'),(7,23,8,1,'2020-11-01 10:12:15','f252a6e530c2b696135facf2a47635d1242ce2ea745520b5994ec18ea2a1d30b'),(8,23,9,1,'2020-11-01 10:12:15','d091f02cb90217bd13d17cf8472f8a1064397e3921143009b461295e42ad7e72'),(9,23,10,1,'2020-11-01 10:12:15','e1ca5a1c2ac34e7e35325f5f8cf25eac429e5616ac71dbc40e031a7a766047b5'),(10,23,11,1,'2020-11-01 10:12:15','2cb45f7bcd408bbc80e655929c2de9de046dc7483b062b999ca9e5b6d221c985'),(11,23,12,1,'2020-11-01 10:12:15','bd6d477878c3499ccc5078f4a347410a241f9b251d39e1881109e81e83a62efa'),(12,23,13,1,'2020-11-01 10:12:15','2a61159392d46e33fd0cc5a370dcd5766f3da58c0573b103227d24ea742549c6'),(13,23,14,1,'2020-11-01 10:12:15','fc8810ea4f3778f36172a65546a79bc8c9f44a6eb7dc7390dde25da358a32e6b'),(14,87,2,1,'2020-11-01 10:12:15','d5b2f1a848658f401d0261d966a2825483a66c761c3c12142d6d75da069e31a3'),(15,84,14,1,'2020-11-01 10:12:15','302d7231609516b6648025c5610eaaad5eb407f8fa7248d7102f1c5609f0adb4'),(16,85,9,1,'2020-11-01 10:12:15','8d11def65b6d40fd57bca6709a40856ffda72859137b71fdbdbf60d9f335aee1'),(17,85,10,1,'2020-11-01 10:12:15','b5dc3de24caa4c394788c6d130ce6355971161a6f50b8ac5724891b75333c47c'),(18,87,15,1,'2020-11-01 10:12:15','59a8af7788517fbc9313e45515a0843b9c8fe16c85667e8fd0c4c1c165652a66'),(19,87,16,1,'2020-11-01 10:12:15','b86481c27207e44ca640af5c2e1aaf670ce62fe15a25743236ce8d6576f0f5a0'),(20,23,15,1,'2020-11-03 18:27:01','b03b77d4269704ebb137a4d2482713abef01d2b1bc6f369f3594cdaff8bce381'),(21,23,16,1,'2020-11-03 18:27:03','d01849ed97c8875a69fc3353d5fcca7471d72fcf4148774f0e8296e8accdd969'),(22,23,17,1,'2020-11-03 18:27:04','b321e0260221249a692c49016281daaef01043d869e55f30fb573b489215fc6d'),(23,85,11,1,'2020-11-03 18:27:06','8de3be9db9242259f325dd6271565a53d4020cf79793035d2e0ae44b17a45752'),(24,85,12,1,'2020-11-03 18:26:41','9bbe44e3d4bc8f40c59e1f4dcf449fb7b7a622640c4c4c621270165b42095be1'),(25,85,13,1,'2020-11-04 18:27:37','08238cb1a1ee1310c96a7b54147f996b335c3e3db0912b99cb4436c94b3e5265'),(26,86,2,1,'2020-11-03 18:28:01','35577bbb11d6849952ffee467cabddbcab3bb72a6c5546d5fcfd3294125dfae0'),(27,86,3,1,'2020-11-03 18:28:19','a6906c4ee34b3673cedd43f857f3d452d46a06ea96e93939f468bd24373c5afb'),(28,86,4,1,'2020-11-03 18:28:36','74c4bcc5395194d940cd41428a6c2fe86d7ba5d31be3bb405186e7844b92bf10'),(29,86,5,1,'2020-11-03 18:28:50','7ac26f6637e4c9d105097c1b52e1954ffcf89fb0415413dfe8cb2ee01cc8de14'),(30,86,6,1,'2020-11-03 18:29:05','ce503f2a32f8f73ff0a9c49079cde9d7b1fdd4443f9bbdb9f6bc2bf3dd251d41'),(31,86,7,1,'2020-11-03 18:29:19','22c66389b20617573c2ce310a4423a41025cb49bcb80b9b168c9efb14a8351d4'),(32,86,8,1,'2020-11-03 18:29:31','e1825f579fcef822372e03fdaa3344738a04f97819ffd0463c044c7b368a1340'),(33,86,17,1,'2020-11-03 18:29:44','e2a3ebd00fd1a47387871826a70c5a53394e373cd3fca028b36607471498aa5e');
/*!40000 ALTER TABLE `auth_role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'13088admin','123456','16978955874',1,'minge@163.com',1,'随',NULL,'2020-11-01 09:48:24','182.86.203.201',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','677ac2b1fb1fdb0e96b2e167e9d16dd0b1f15f9c34fd31c17ec530147d50f71f',1),(46,'8131600001','123456','15983424556',1,'ees@123.com',1,'个',NULL,'2020-11-01 09:48:24','111.73.169.226',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','f4279afbec4253ea4eb6d2e14f6775c469a1391a0b8a0118e5fc332b879b0c1f',1),(47,'2721900002','123456','15983333556',1,NULL,1,'全文',NULL,'2020-11-01 09:48:24','111.73.172.255',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','15bde1ff0eb30f336562ca2027b69bf2b1a349d92069ee56e044a6507f31786c',1),(48,'8532600003','123456','15448751556',1,NULL,1,'斯蒂芬 ',NULL,'2020-11-01 09:48:24','182.86.207.170',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','e97e89b4e028f8c76868ff1d6ea94da2c709f0294a16800a307db3a091b20a5e',1),(49,'7623000006','123456','13988751556',1,NULL,1,'阿卡前 ',NULL,'2020-11-01 09:48:24','111.73.172.255',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','7d763bb389bdaf3c4645b9169f5bc37b4715c2896d66e306934cd58302b02105',1),(50,'8043300005','123456','15988722556',1,'ss@133.com',1,'速度',NULL,'2020-11-01 09:48:24','111.73.169.94',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','8ea7d56d86872b78200994bf4109ee0605de0d795b0bef7157eedc6fa9f53371',1),(51,'4216700007','123456','22332221131',1,NULL,1,'撕得粉碎 ',NULL,'2020-11-01 09:48:24','59.63.23.162',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','df68fea71e8480964d0e298b9d0c1046197275185265c7ed88c02934f2c62c6e',1),(52,'7728110000','123456','15988451556',1,NULL,1,'我而去r qr',NULL,'2020-11-01 09:48:24','59.46.161.186',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','5747e7c5d36209544567350b1f5de61c2d6a48bcdf05e71aa5a4e6d75a62921e',1),(53,'8884810086','123456','15981751556',1,NULL,1,'大放送的gd  ',NULL,'2020-11-01 09:48:24','120.35.68.104',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','7e469f5b0b1592d394ebbe19a6d7a6818e0fd101f061e2022b20c1b44c9b206c',1),(54,'9259200008','123456','15988751536',1,NULL,1,'斯蒂芬ffwrw ',NULL,'2020-11-01 09:48:24','',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','24288a4a79bc472e7a249cd05c3a97146d8a2d4fe38cd5fb62d797bb66bf0d71',1),(55,'5961900008','123456','15988751956',1,NULL,0,'阿飞我ww ',NULL,'2020-11-01 09:48:24','111.73.169.58',NULL,0,0,'2020-11-01 09:48:24','2020-11-01 09:48:24','3e8088c747d5f46b0f701d54d437753ba332530cd6cf2ddc83a605845eec0cf6',1),(57,'9943200016','123456','15988251556',1,NULL,0,'发热 ',NULL,'2020-11-01 09:48:24','111.73.175.84',NULL,0,3,'2020-11-01 09:48:24','2020-11-01 09:48:24','78ecacd736cb38b5b5b7444d34fa5d3f3dd31fd2c43158f5ce3fbd2ae3a05cbc',1),(58,'5264500009','123456','15988751123',1,NULL,0,'沃尔沃',NULL,'2020-11-01 09:48:24','111.73.133.9',NULL,0,2,'2020-11-01 09:48:24','2020-11-01 09:48:24','ce9f4502351c2db80e17417128ebfdcf853e4406617a4b6ae5315501b6c4629a',1),(59,'537300010','123456','15988751256',1,NULL,0,'蛙人wer',NULL,'2020-11-01 09:48:24','111.73.172.255',NULL,1,1,'2020-11-01 09:48:24','2020-11-01 09:48:24','edff9e93bbd1d6f0f2ee0c109732ac5e2e0caadf514d1da58ce519e1047018e2',1);
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_user_proxy`
--

LOCK TABLES `auth_user_proxy` WRITE;
/*!40000 ALTER TABLE `auth_user_proxy` DISABLE KEYS */;
INSERT INTO `auth_user_proxy` VALUES (1,49,47,'2020-10-03 18:51:42','2021-11-03 18:51:52','2020-11-03 18:52:00','bb1378ee78a41e6a37abd37aa2247af1f2962fc229ca84cf53981fb6b2fe37bc',1),(2,49,46,'2020-05-03 18:52:25','2020-10-03 18:52:31','2020-11-03 18:52:37','006d2a321a041446b8c19f33bda62c49bdefe6bd12705d1be50c45dedb4842bb',1),(3,49,48,'2021-12-03 18:53:01','2022-11-03 18:53:19','2020-11-03 18:53:39','6c0504294505cbd9b280954ea8442b478bdfc4b1184dc49b9cc1055f026a24f8',1),(4,49,50,'2020-11-01 18:53:59','2020-12-03 18:54:07','2020-11-03 18:54:17','fba6d947de10ea75670dacc896e64fa393f44280ab55ff06f7a1f3333aee52b2',0),(5,49,51,'2020-05-03 18:54:29','2020-07-03 18:54:37','2020-11-03 18:54:42','7b6bef43e290a29c964a4d5bad7208309ca4b583ae029579d2ce3b5a70e5c6ec',1);
/*!40000 ALTER TABLE `auth_user_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_user_role`
--

LOCK TABLES `auth_user_role` WRITE;
/*!40000 ALTER TABLE `auth_user_role` DISABLE KEYS */;
INSERT INTO `auth_user_role` VALUES (76,23,1,1,'b1e5a21c5281ee65d835d3c9f8d2e52a69b4c9627b956e556e4c6bc922510533','2020-11-01 09:48:24'),(77,87,46,1,'4d4e9ae6002cc873f9faad2760bf322b993a4cef6b96b8385f607fcbc7097df8','2020-11-01 09:48:24'),(78,85,47,1,'a60e3b0458194239790b35e4235f2756844ad74af82da1376854f3dde08976c3','2020-11-01 09:48:24'),(79,86,48,1,'78cbf2c1ad3b42a5090b9d00fab42cbd46305b985b0391f0fd00a5261df8f419','2020-11-01 09:48:24'),(80,84,49,1,'b91d40341ca8de588f33564c15950f7c88019acdaad7f75e35005072d37f933e','2020-11-01 09:48:24'),(81,86,50,1,'61f051200ef331a3dbf36ca9dff7f7bb988c964f8589acadf8746e5f1a0d991e','2020-11-01 09:48:24'),(82,85,51,1,'172c8c801e5d78ac2cddfff1c15193190aab8d7cd894b51a56fbdcb9f6d392e6','2020-11-01 09:48:24'),(83,84,52,1,'3a1e7e5ab2663a21c5516b99d08bd0f98468e089c28aa407e6ceda6011704a31','2020-11-01 09:48:24'),(84,80,53,1,'5895907108b2a713d9453c95abaa22ce6ae271868cdfe754b9a89088c9460c1b','2020-11-01 09:48:24'),(85,86,54,1,'6b2ae50355ccaf1f8bf8651bd5ec18c8f95047864a6c9663e3981d77d386c626','2020-11-01 09:48:24'),(86,86,55,1,'a5ce35b485724f378023621ef88362ec15530dd189fc4636bcc88617e557860f','2020-11-01 09:48:24'),(87,23,57,1,'c68ebbce03ba0d077403323268611a67fa95d351c20e55e8c05b666f8535736b','2020-11-01 09:48:24'),(88,84,54,1,'0ed4b4c4fc0cb0d70a22f9e4b12da791a10d00cc8fdc59c9013b670f0bcf27eb','2020-11-01 09:48:24'),(89,87,50,1,'cee926e8ee2cfcf5b5aabe78f393dea4e5789d12bb15143e9eb90392a526d574','2020-11-01 09:48:24'),(90,84,51,1,'e5004c1dca8420b77cd7e58d9d9de5261af223ebb0186414187ba5fe3ec7ebd7','2020-11-03 21:33:52');
/*!40000 ALTER TABLE `auth_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-04 20:00:40

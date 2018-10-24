-- MySQL dump 10.13  Distrib 5.6.23, for Win32 (x86)
--
-- Host: localhost    Database: knorr
-- ------------------------------------------------------
-- Server version	5.7.22-log

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
-- Table structure for table `act_evt_log`
--

DROP TABLE IF EXISTS `act_evt_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_evt_log`
--

LOCK TABLES `act_evt_log` WRITE;
/*!40000 ALTER TABLE `act_evt_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_evt_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_bytearray`
--

DROP TABLE IF EXISTS `act_ge_bytearray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_bytearray`
--

LOCK TABLES `act_ge_bytearray` WRITE;
/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
INSERT INTO `act_ge_bytearray` VALUES ('5002',1,'contract.bpmn','5001','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.activiti.org/test\">\n  <process id=\"contract\" name=\"合同流程\" isExecutable=\"true\">\n    <documentation>合同演示流程</documentation>\n    <startEvent id=\"startevent1\" name=\"Start\"></startEvent>\n    <userTask id=\"deptLeaderAudit\" name=\"财务经理审批\" activiti:assignee=\"${deptLeader}\"></userTask>\n    <userTask id=\"managerAudit\" name=\"经理审批\" activiti:assignee=\"${manLeader}\"></userTask>\n    <endEvent id=\"endevent1\" name=\"End\"></endEvent>\n    <exclusiveGateway id=\"exclusivegateway1\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <sequenceFlow id=\"flow1\" sourceRef=\"deptLeaderAudit\" targetRef=\"exclusivegateway1\"></sequenceFlow>\n    <sequenceFlow id=\"flow2\" name=\"同意\" sourceRef=\"exclusivegateway1\" targetRef=\"managerAudit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${deptLeaderPass}]]></conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"exclusivegateway2\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <sequenceFlow id=\"flow3\" sourceRef=\"managerAudit\" targetRef=\"exclusivegateway2\"></sequenceFlow>\n    <sequenceFlow id=\"flow5\" sourceRef=\"startevent1\" targetRef=\"deptLeaderAudit\"></sequenceFlow>\n    <userTask id=\"modifyApply\" name=\"调整申请\" activiti:assignee=\"${applyUserId}\"></userTask>\n    <sequenceFlow id=\"flow6\" name=\"不同意\" sourceRef=\"exclusivegateway1\" targetRef=\"modifyApply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${!deptLeaderPass}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow7\" name=\"不同意\" sourceRef=\"exclusivegateway2\" targetRef=\"modifyApply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${!manLeaderPass}]]></conditionExpression>\n    </sequenceFlow>\n    <parallelGateway id=\"parallelgateway1\" name=\"Parallel Gateway\"></parallelGateway>\n    <sequenceFlow id=\"flow8\" sourceRef=\"modifyApply\" targetRef=\"parallelgateway1\"></sequenceFlow>\n    <sequenceFlow id=\"flow9\" name=\"重新申请\" sourceRef=\"parallelgateway1\" targetRef=\"deptLeaderAudit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${reApply}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow10\" name=\"结束流程\" sourceRef=\"parallelgateway1\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${!reApply}]]></conditionExpression>\n    </sequenceFlow>\n    <userTask id=\"confirm\" name=\"业务员确认\" activiti:assignee=\"${applyUserId}\">\n      <extensionElements>\n        <activiti:taskListener event=\"complete\" delegateExpression=\"${contractProcessorEndListener}\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow12\" sourceRef=\"confirm\" targetRef=\"endevent1\"></sequenceFlow>\n    <sequenceFlow id=\"flow13\" name=\"同意\" sourceRef=\"exclusivegateway2\" targetRef=\"confirm\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${manLeaderPass}]]></conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_contract\">\n    <bpmndi:BPMNPlane bpmnElement=\"contract\" id=\"BPMNPlane_contract\">\n      <bpmndi:BPMNShape bpmnElement=\"startevent1\" id=\"BPMNShape_startevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"100.0\" y=\"180.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"deptLeaderAudit\" id=\"BPMNShape_deptLeaderAudit\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"260.0\" y=\"170.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"managerAudit\" id=\"BPMNShape_managerAudit\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"590.0\" y=\"170.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"endevent1\" id=\"BPMNShape_endevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"930.0\" y=\"423.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway1\" id=\"BPMNShape_exclusivegateway1\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"440.0\" y=\"177.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway2\" id=\"BPMNShape_exclusivegateway2\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"760.0\" y=\"177.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"modifyApply\" id=\"BPMNShape_modifyApply\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"408.0\" y=\"300.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"parallelgateway1\" id=\"BPMNShape_parallelgateway1\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"440.0\" y=\"420.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"confirm\" id=\"BPMNShape_confirm\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"895.0\" y=\"170.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"flow1\" id=\"BPMNEdge_flow1\">\n        <omgdi:waypoint x=\"365.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"440.0\" y=\"197.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow2\" id=\"BPMNEdge_flow2\">\n        <omgdi:waypoint x=\"480.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"590.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"490.0\" y=\"180.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow3\" id=\"BPMNEdge_flow3\">\n        <omgdi:waypoint x=\"695.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"760.0\" y=\"197.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow5\" id=\"BPMNEdge_flow5\">\n        <omgdi:waypoint x=\"135.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"260.0\" y=\"197.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow6\" id=\"BPMNEdge_flow6\">\n        <omgdi:waypoint x=\"460.0\" y=\"217.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"460.0\" y=\"300.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"36.0\" x=\"470.0\" y=\"239.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow7\" id=\"BPMNEdge_flow7\">\n        <omgdi:waypoint x=\"780.0\" y=\"217.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"779.0\" y=\"327.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"513.0\" y=\"327.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"100.0\" x=\"681.0\" y=\"299.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow8\" id=\"BPMNEdge_flow8\">\n        <omgdi:waypoint x=\"460.0\" y=\"355.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"460.0\" y=\"420.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow9\" id=\"BPMNEdge_flow9\">\n        <omgdi:waypoint x=\"440.0\" y=\"440.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"312.0\" y=\"439.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"312.0\" y=\"225.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"48.0\" x=\"331.0\" y=\"411.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow10\" id=\"BPMNEdge_flow10\">\n        <omgdi:waypoint x=\"480.0\" y=\"440.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"867.0\" y=\"439.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"930.0\" y=\"440.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"48.0\" x=\"730.0\" y=\"411.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow12\" id=\"BPMNEdge_flow12\">\n        <omgdi:waypoint x=\"947.0\" y=\"225.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"947.0\" y=\"423.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow13\" id=\"BPMNEdge_flow13\">\n        <omgdi:waypoint x=\"800.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"895.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"100.0\" x=\"819.0\" y=\"180.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('5003',1,'contract.png','5001','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0�\0\0\0��\0\04�IDATx���l��}p�c&�a\r�beHc���D�D��������8`K,�����(h���2\rk<aX3�K\rwK\\b�7��]��S6�]�?d9�Ʊj��S&�z��DI������;�����z��x�{�}��|>ϛ��q$\0\0�){\0\0@��x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�x\0\0�G�\0�x�xh�R����OOO�ٳglll$U������������j��=���T7CBIVu[�r<4w�ȑ���r�m��}�=O�<yvm-͑�{�>|x߾}�c�7���Du�n����tI��P/�	xfff�޽O?��ٵ�Fq<��sys������\n���U7CEIn�$�xx���LLL|�֯�];c�\Zw�y��W_���\\�rAT��f�(ɭ���333��S^5ڏ����5��㲗���U7CEIn�$�x��#G������s���ۿ�o��w�^4��V�%ٓ����5�Jell�g��νbt2N���]�_ZZ*{�`�[u3T�d�JR��������̬�{�6���g�QT�^I��n�����e/l@u�n����UI��𚩩�÷�������,{�|����g�G�d�:w��o���/>p6����Jv����_�����>��3�Wx)��cG\'&&�^��U}+o�]:խ�7A�����UI������\'Y;w�:��Oe��ً粟��^β�o�0�Ʒ���Գk��g��_͖+��?��Gן!8��8u����Ѳ�nH��k��櫷޺g�Q�\\�[uwK�����UI��=V�T8�����g&\'\'�k�����a�cǎ�_xv�ܩ��;���3�/~�܅���������?��_��sY�ҹ�ŵ�\'kY��_���m�T�#��rn8UC�C;�v.�(\n�Ku��~S��*�DK�������G�<���������qǝw�x�����w����a�pZo\r/�F���s��dgϿv�����/�����/?�Ë��a�Bvv�����u�Mj${�o��cx�@�륺Uw熹~ۈ�XJ�W%iՇ�����\n��{��ke�j�{����}bbbbqq���:�����Ŷr>{���G���,;{���UW���idd�����xǇ�=RwߤF���\04���F����mz;����Uw�\\�ml��V��*�a_��w���<��}�76L�u!����T*e��Yo\r/������^x%��Kُ_�:��W\\qś����^��][y��cu�Mj�	c�Z���E�6�ݗ����j�[uwb�����.m%٫�����)����ӳ��]%���ÛoΛ���Jٻ�E�a�6�O_����r���^��yp�}�>�����;�����,;u&{���;�{����&5��6�}�S�>�M��k��X�����V�*�~��ޥ�${U�C���,�w��t����&����r�;�Ŷr��Ok�Z-ygyq-����/������+�����3ُ*ُ+�g�������u�Mj��b`:	��>iפ���p�[u�WV����K[I��$,�p����z��5�<�{�M��ZÞk����~��cKG�/�wl�G���\'�����cO~����:������G�s���c�}��������C@ϣ��O��n���Rݪ��뷍�]�J�W%`�������r��q���SSSe�V����O��7�3-aY�/>�Ѻ;&5B�3�����(�x^oze�\'�zEu��Vʭ�6�wi+�^�d��6Ǐ����a���O�3��rK�;�������q��ͅ�F��O����}cQݪ���뷍�]�J�W%`��M�7W�����<{�c^]S��m���F�#�9�O\ZC�w�u�U�O�<ٴ̟{��]�v}��[{j���yӥIs�T��n4����.m%٫�����`aaajj��!�:���s�*{ӵ�V�3��N=�4����H�3yc���ꙸ�Q���_�Rݹ��¶��Uw�!��6�wi+�^�䰯���˵۷���)��;w����Zo+?6����6!��.\nC@o��&N�m�ܮT��.\Z��mc{����UI�2��Jw��ѧ_W_}�ѣG���D���ݎ!?[�Ccx������_ע@c��!��}�Q��o؛�\n�n����n�]3T����.m%٫��e6sss333}��_����ٲwt;���o�n��me��v�٢+m��6��=�9�1\n{䑦!��;�j����6���n�;l��\0J2R��n�����rK_s���|#oe�����W��e�]v��ắj+�j+A�?<�6���Q�-oyK\'!@�\"՝xu��a�$S�aJtLNN���^�\'N���ʱ�wt۪T*o|����K.y�{�[|�`���mOF�6�x��}���7X���¦w��%���G��mo��\0Q`+V�ۦr�Yu��aS�	w���by��`�=/�ƒS�àO�8Y/�:����wt;�{�[���O~�շ��?=��������R�[6޾x��7+~Z��x�͹�nS�.ln4����]���VQ`� \nlE����?h�n��V��f0%Y�T�Ͷ)�6w��l������T��ˏ��ߵ�i䋔��\r;;�p������������67nzM�m���~��}�-��r\nGl:���X��7��Mu[x��p����/�K��M�]5�p��Tu��!ԏ2l��H����p�Yŵߑ�fm�u�T������wN�@�/{G���/��V�S��V��������3�����>���߾��u�.7ެY�i>�6sh���>�{���=���8~�x�{��\rK��[T5}_�[ȿo��~<��auw��V���n�;lS���im�uXz=��ƒ�T�����W�������j����>��O����k_]���;��?�}��i񚦟�]�f��/��t;ův���\r���=����:�mB@�Q@؜�Vw�G~���fխ~�M�K����\\���n���6�~�gcI�)�a033S�����w��W_]��n[O=�������������l�����o:��?֮�}Zw���u�j�Y�v�W��\\n:�M�ƶT�ã�}h\Z���7�]�&\n�����D��mV��w��$��[�H�Sp��4�ً�߰~�l��%�D���C����s}����	��}������暾�m��ִ�Ϸ>���~�n���]�͗��S׉��h��7���iZ���?�/_n���M���=�@���~խ~��\0J�U�����_jz�����i����icIF*����b�ce_s�޽{�9R��&j�؞�|To_���i�r��s�4޾��5N��5M/��xas���l{�Q�U���E�1S��߅����A���]��V��=<z7,���*��?�?vx����6,Ѿ�럺�t�t�,�o���],�˝���?/�ݸէ�6����-����7h:�nw�qbe/]	\Z���}�(>�uoQ����c�y�m!D�\\��t=<z��I��l�i�˵����c�Jr{�h����5���/�/{ӵ^lOv;j�*޽qSu�4���[�d#�_�^(nvӏ@�KW�6Q�տm�E!`�6wlwx���ī[����m�lz}��5�l���\r\ZK���;�UOJrۖh�T*����~��|���rlee��]L�z��uW�z��;�]��?+�\r���m:�j���6��t�T�U�ҕ�ih�o��( ���\r��Е���o�zx�֝O;���״/�bѵ)��W��$�s������Ǯ�Γ���z���|o_w�՗\Z�ڸ�Fޠ�[]Y��q��>����tej���g�wN�os�vWU�rUw�~˳���UM�E�JlM�z���\\ӫ���%�\'��G���!>o\r�v�ʻC�{���2{��vl�3��:�3�!��Vݭ��R(�^���/�~X]]���{��տ���ɲw+u�m�F�#�3����B���n�݆�<%٫�L�D�aii)�����\r���?�;�B[�Y[ISW��]0խ��S��${U���h?�e�k׮{��!�;\'N�?�C\"/�7���7��?~Ou��\r��AR��*ɄJ�VWW���/t�Һ�N���/}��✲w�׬���ݎ�������Pݪ��w`�d�J2��J������\Z�sy���ۏ��zk~���\\�ʞ>?��V��nGjg�\r����B@YT����%٫�L�D�dee�nرcǇ?�<�7�qU~�m��Ϗ]w]~�}�>���\\�����V�gt;<�o��?~J��Uw���\0(�^�d�%�?�Jeaaafff׮]u�c�_��������ղ�Is������ȅ�5�\Zi��7T�B@�T�����7%٫�L�D����ؓO���\'��F�g�\rU��\'O\n�Sݪ�[귯�d�J2��:���v��w������t||��^��??]	�Sݪ{>����>Q��*I9^s�����O�^����}qff��j�a��U�&���~S��*I�(�fyyy|��^�<t!{��pLM}paa��j��0Pݪ{o�(�^��c~��E�/d�6:�k�?NOO��h�N�[uwK�����II:F��*�ʞ=�r���ȲG��ce���_Z]���Ev���Pݪ�[����dOJ�1\n����41q���B�7Z�����wq�+e/W\0���Pݪ�+��ߔ��K�1\n��=�w���e�=b4���/���-.���*Q`��n��9�;\0Jr�%��&*����̞=���w++_ϲc���_������SS{��e/Q���Qݪ�C�w0��VJ�1\n--..����;��##;v\\6=������,���CIu��F�\0)ɢ�K�1\n$�.Ρ����MS��c��<��NVWW˞�!\n@P�7M��=�\\!M�~����[��[eO�͈uJ\0jo�b�{��B�~����j�w��Ǐ/{:t-�)�Q�i����\n�Y]]������-��ʞ]�uJ\0jo�b�{��Bj�������w�{nn��IѝX��F�)ֺG�+$euu�����wU*���Fb��\Zś�X�i����|�+������������,..�=5��\0�(�4�Z�Hs��|�[�z���>66�cǎ���\\��w�C��%�)�Q�i����\n�9~����r����_��5��:%\05�7M��=�\\!Y��\nE��R�i����\nɊ�V(�v��MS�u�4WHV��B����o�b�{��B�b����x�k�#����Pd� (ś�X�i���Xm�\"kA)�4�Z�Hs�d�j+��v�:u��X�i���Xm���k7��Nn��m������4�Z�Hs�d�j+u�vMo�f#u_*~각�PAi����\nɊ�V(�a�o�D{�/yJ�H�)ֺG�+$+V[����ku���o��#6M��)ֺG�+$+V[���{��q#m��/n�3���\'M��=�\\!Y��\nE�]](o���\r��|<���IS�u�4WHV��BQ\'k�4�7^�$�{>zE��)ֺG�+$+V[�����E�I=+D�������PGi����\nɊ�V(\Z�߹�ze��6G�)ֺG�+$+V[�����J�\n\'M��=�\\!Y��\nE����kM�s\0�N�b�{��B�b����x�k�#����Pd� (ś�X�i���Xm�\"kA)�4�Z�Hs�d�j+Y;J�)ֺG�+$+V[���AP�7M��=�\\!Y��\nE��R�i����\nɊ�V(�v��MS�u�4WHV��B����o�b�{��B�b����x�k�#����Pd� (ś�X�i���Xm�\"kA)�4�Z�Hs�d�j+Y;J�)ֺG�+$+V[���AP�7M��=�\\!Y��\nE��R�i����\nɊ�V(�v��MS�u�4WHV��B����o�b�{��B�b����x�k�#����Pd� (ś�X�i���Xm�\"kA)�4�Z�Hs�d�j+Y;J�)ֺG�+$+V[���AP�7M��=�\\!Y��\nE��R�i����\nɊ�V(�v��MS�u�4WHV��B����o�b�{��B�b����x�k�#����Pd� (ś�X�i���Xm�\"kA)�4�Z�Hs�d�j+Y;J�)ֺG�+$+V[���AP�7M��=�\\!Y��\nE��R�i����\nɊ�V(�v��MS�u�4WHV��B����o�b�{��B�b����x�k�#����Pd� (ś�X�i���Xm�\"kA)�4�Z�Hs�d�j+Y;J�)ֺG�+$+V[���AP�7M��=�\\!Y��\nE��R�i����\nɊ�V���ϗltttbb\"��s�������������tJ�MS�u�4WHV���׾����^{���B�S:��)ֺG�+$+V[�R�\\z�������Ν���eO\r�ƛ�X�i���Xm���?��7��͵���~vvv��I]�x�k�#����Pu�WTC�u�]766V�Tʞ��7M��=�\\!Y��\nU���7/��|�&\'\'�2��x�k�#����P��~���˞�5�7M��=�\\!Y��\n5+++��y�I�H�MS�u�4WHV��B����o�b�{��B�b��aP�T��秧����366��n���=�������%teD�MR�u�4WHV��R�#G���5��v������ɓg��������Ç��ۗ?&y�/{qض�_��~{D\'b�{��B�b���������ݻ��g�>�v�(��.O������R�BQ�\r����6�My��3�c/�V�u�4WHV��R�<�OLL|�֯�];c�\Zw�y��W_���\\�r1D�v�6m��K�O�S��N�B�b�{��B�b�����̬��W����{�~�5����b����M�ho��m���6�6!ֺG�+$+V[)ő#G����ڹ��������7���e/\ZC�U{����ƛm�~�mv���Z�Hs�d�j+�W�T��ƞyvy��+F\'������~olO�S�u_��>_��6{&�j��]����\nɊ�Vonnnfff��˵q��?���U�{%5n�����Ζ�t��.�������i�o��m`��]����\nɊ�Vojj������!�C{�6˞:��`-����3�C���������o%{����r��W�?���O��L鑺���e/�i\Z�/w��=�vk�#������������;]��u*�N_�^<���l�r����7�}����]˞>�=�j�\\ɞ8���_=�����ǩ�/�����t��.j7M�Y!��]M��l�o��D�u�4WHV��2x;v�x��g�Ν����z�|v���/��p������?������w.�^:�����d-[Ͳ�?���*��\"��߹�ze��8���^ЭX�i���Xme�ֳ�K��z�\\��+����`uu�?��~�?}��^�Hk���������oR�qE����ʈ��.�	��=�\\!Y����g��Ws��칗���ֲ��3�W]52򦑑я�ƾ�:�H�}�\Z�+�.s|�W�t�ڛX��.�	��=�\\!Y����g�k����^�~�R��W��N��W\\�7�字����_��|�X�}�\Z�+hC��)ֺG�+$+V[��,�Z���\\�~R��|�s�f�<���]������w��?���j��:��|���=�`�}�\Z�+heeee�Νeς�j���\nɊ�V/|Ν�imT�<ʿ����l�×��ly�?��k��?���G��Ǖ�3Y���}����&5W�������Xٳ��\Zc��B�b������{�������C�-=�t߱��y��o�����W�=��c�����{��G}�������֏]������ȑ#���eς�j���\nɊ�Vo=���8~�7?���׍��G?ZwǤ��\nZ9���YP�X�1�\\!Y�������n��\nZ���<r�Hٳ��\Zc��B�b�������?ot;W�������X�R){\"� Vc�4WHV��2x�9�9��Ḃ�:t�\r7�=��1F�+$+V[���c��ḂF�Jelllee��P�X�1�\\!Y��������4������+{�&Vc�4WHV��2x�9~��v�:���痗���0:����gA�b�p#�����ߓ����������|�;Ey�R�Tfff�xb�p#�����z���ގ�6���|�w��6W�c��~��cx�-����Vw-��s�N�&�O��\Z�r\Z�h\'�Hs�d�j+��?>����磶���W�i�uW��f�l��^�`��---��/�r���޽��g�[\\\\<x����T~��p�\r~p�*�	7�\\!Y����\'�g�7j�ou������[�\r�c��kϞ=m��X~����.,,������\"#�N���\nɊ�Vo�b�}������vM�ʺ/����╍���~����������/�b�;^v�ee�*@	b�p#�����z�}���g��˭.�nYwMݦ�_��{��4��Ց#G����w��]��\\z���%��X\'�Hs�d�j+���z��磶٦��/ަ��6w/n�x��7���<�8p���~���D�����e-(@Yb�p#�����\0r|�/5ޠ1�����7�����U���sss�_G���:�F�+$+V[����T�Gm���g��i�<�����V����t\0�%Vc�4WHV��2x��垏�f�\Z?��}��-�~���6{��e/�p��#�����z�}���gQ���Ǻkj7+޾x��tr�Y����վW�K0\\b5�Hs�d�j+��v��磶����is�6�l������i�j/{�\0�K��i���Xme�����>����&����/��`k��o�j#=ܵ��`��j���\nɊ�Vo=�>at;W\0ub5�Hs�d�j+����`t;W\0ub5�Hs�d�j+�\'���\0=�1F�+$+V[���p�q�����1F�+$+V[���}�����1F�+$+V[���dt;W\0ub5�Hs�d�j+����gt;W\0ub5�Hs�d�j+�7::��+�\\��]�����1F�+$+V[����\'���N]\r�@�X�1�\\!Y����MNN�ّ[.d�1:�[�����`��:�F�+$+V[����~��dk���gff�^:���i���Xme𖗗����C�ǌ����^:���i���Xm�.�!�����_��qzz��E:�N���\nɊ�VJQ�T�����G�G�=j�++�������e/\Z�Љu4WHV��R������������j�!>��gq�+e/�0�u4WHV��R��G��Q����e��ca�K��c�����R�N���\nɊ�V�U�Tfgg�����ܿ[Y�z�3VW�r~�?LOړ_.{�\0�W�n��B�b��a���83��w���#����q����(_��\0��P\'�Hs�d�j+y�v�@b�p#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#����Pd�\0�մ#��ի�2R�ɷ�ʕ�Za�x�+u%Ӿ�:��67�~i��:�)�S� �\\!Y�n+���\Zo����\\?�������|�ˣ�����;w�����---�=5v�s|�S��:�l�5��Z��N� �\\!Y=i+�o���Ϛ[�v��׾�����k�]XX({j0Ԋ���nӪόt���O�X@��B�6�Vڄ��OD5��^n�}71��*�ʥ�^Z|�����ܹsuu�����0Uo��Zm��wL�e���V`���w]|�$��]n<�%~.���?��7���0~������-{R0Ԛ��?���S�����Du�B\0[��ퟸjz}]��d;�{��Y:����_w�uccc�J��A\0��S�\rZ]n��ZmJ�J\\�_�:X!�M�W:9���jW\'ά�I���J�7���K.�$������R�A\'�U:o��\Z��ս�����!l%�wr«�~�9ޓ[U���9��@\0���}�ô�i��g��� 5�ꐅ\0zrv��lW��&��y��7J�Ը���������VO�i\Z�;�Yc�����`�\06}^�<���8�\r/��^	J|��[�O�g������;[�$(�/Q�@���os:l�M�\\�����O����333���R0\Z�bh|:���u_j���x6Y`sg�6O�7=_fm�p�_�t�	���5�\\��[oݳg�(��J;ju��?�o��&��G�+$+V[!�Y���cg���Ey��T�T8055��g&\'\'�k���VVVʞ`;�0::\Z��*�����M�����\'&&n���<��������rٳ�#�!^�*����w��0��\'�!|9���8~�xٳ`c�B�(0*����L�3��ۿs���w��ڸ��/�ݻ��SSSC���x ���eς\r��<@�VVVꞆ����=q�d�����/���7�ܹ�����<�&�C\0333ssseςv:	�<@Y����^�㓓��|]����/��;::z��Ѳw�\"9�C|�˞-5\r�yӯ\rQ�D�J��L�o���_���?�_{V~��F��\0������˞͵z&���[���hzz�֐�}!�ֺw��Q�N����-9��é��i��xQ`0��L|q�q�]��:t��]��!��Y�p�\reς�i���\rs�(0\0���o1��^6Y��Ν;�}_y9b�;Ő�\Z��\r����/�����|�S�~�ٞ���N����M�O�������0�\Z���w��0ǋ�\0��w�j�����$�W�Wo����;v��wr<Dr����)]�o1�y���!o��>ܫ\'�k��+Ǫ[.�����������W���\'��/�l������r��sss����m��ǧ?����������5r<�s�ȑ���x���u�7��Ey�Mx��ǫ����.;|�p�K�������4����Fu�w�.k��x)�zy������d~��_ꥣ���/�t�R���o�6�K.���}o���Y���;��y�������sqY�.�C`y�:r�H��k�C��\n���Խ9�����گ�d�\0�\'�=?355u�`���OU��=��o}�\'?���Y{��Ο��jԾcow�sr<����=�hl�����_�zo\" ����ZX_XX(��=��ګ������žz�嗿�=��7X��O�<ُ_����:r<�Ǝ?�G��a\09>�.��ǿ�R���	�9q�9~ttT��i��y���R{s����O}�S������j/:m��-��]W7^�[���\0�j��|��M�t�w�B<@��z������ɱ������+pfff�M�o���9�;\'NT7>11Q־��\0]�<�w��x��YXX���k|��V��}��y���M7U7>==]�N_$�t��(�U��znii��җ�N��m��OՍ�?B���r<@�:���x!�O��ƪ}����{�ko?����e��F�s��?����>�k׮>%��|��٩���N�ؤ�Q��/�����j�]޿x�M=	���w������x��k�7��B<�\0:t�ڊGGG���O�<Y��`������%��|�/���ݻ��8��[�߮/�:�k׮ڦVVV��/9`�Z�����J���\\���y�~��c��O?�l-ď��...��[r<@/t���B<��屻�;�<�w��������ir�*{�.��z��(/��eaa���|�l��N����u�_*9$!>��z�}��ʵ��4>>^�y����/|�ĉ����7߼w�������45r<@/���B<�0X]]=p�����H3W_}u�/MOO����u�x�k��B<�P����LӼ�(o�G�-{�M��\0�W��B<�p�T*���y�������cccSSS��r˰=_$��E5�?q�@?��\0������1!�~��\0 9\0\0��\0 9\0\0��\0 9\0\0����{�z\\\"\0\0\0\0IEND�B`�',0);
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_property`
--

DROP TABLE IF EXISTS `act_ge_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_property`
--

LOCK TABLES `act_ge_property` WRITE;
/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
INSERT INTO `act_ge_property` VALUES ('cfg.execution-related-entities-count','false',1),('next.dbid','10001',5),('schema.history','create(6.0.0.4)',1),('schema.version','6.0.0.4',1);
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_actinst`
--

DROP TABLE IF EXISTS `act_hi_actinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_actinst`
--

LOCK TABLES `act_hi_actinst` WRITE;
/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
INSERT INTO `act_hi_actinst` VALUES ('5011','contract:1:5004','5005','5010','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-10-24 15:39:14.382','2018-10-24 15:39:14.383',1,NULL,''),('5012','contract:1:5004','5005','5010','deptLeaderAudit','5013',NULL,'财务经理审批','userTask','JaYi','2018-10-24 15:39:14.385','2018-10-24 15:40:13.062',58677,NULL,''),('5016','contract:1:5004','5005','5010','exclusivegateway1',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-10-24 15:40:13.062','2018-10-24 15:40:13.063',1,NULL,''),('5017','contract:1:5004','5005','5010','managerAudit','5018',NULL,'经理审批','userTask','WangJun','2018-10-24 15:40:13.063','2018-10-24 15:41:23.965',70902,NULL,''),('5021','contract:1:5004','5005','5010','exclusivegateway2',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-10-24 15:41:23.965','2018-10-24 15:41:23.969',4,NULL,''),('5022','contract:1:5004','5005','5010','confirm','5023',NULL,'业务员确认','userTask','LiSi','2018-10-24 15:41:23.970','2018-10-24 15:41:49.932',25962,NULL,''),('5025','contract:1:5004','5005','5010','endevent1',NULL,NULL,'End','endEvent',NULL,'2018-10-24 15:41:49.932','2018-10-24 15:41:49.932',0,NULL,''),('7507','contract:1:5004','7501','7506','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-10-24 15:48:56.795','2018-10-24 15:48:56.795',0,NULL,''),('7508','contract:1:5004','7501','7506','deptLeaderAudit','7509',NULL,'财务经理审批','userTask','JaYi','2018-10-24 15:48:56.796',NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_attachment`
--

DROP TABLE IF EXISTS `act_hi_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_attachment`
--

LOCK TABLES `act_hi_attachment` WRITE;
/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_comment`
--

DROP TABLE IF EXISTS `act_hi_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_comment`
--

LOCK TABLES `act_hi_comment` WRITE;
/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_detail`
--

DROP TABLE IF EXISTS `act_hi_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_detail`
--

LOCK TABLES `act_hi_detail` WRITE;
/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_identitylink`
--

DROP TABLE IF EXISTS `act_hi_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_identitylink`
--

LOCK TABLES `act_hi_identitylink` WRITE;
/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
INSERT INTO `act_hi_identitylink` VALUES ('5006',NULL,'starter','LiSi',NULL,'5005'),('5014',NULL,'participant','JaYi',NULL,'5005'),('5019',NULL,'participant','WangJun',NULL,'5005'),('7502',NULL,'starter','LiSi',NULL,'7501'),('7510',NULL,'participant','JaYi',NULL,'7501');
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_procinst`
--

DROP TABLE IF EXISTS `act_hi_procinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_procinst`
--

LOCK TABLES `act_hi_procinst` WRITE;
/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
INSERT INTO `act_hi_procinst` VALUES ('5005','5005','1','contract:1:5004','2018-10-24 15:39:14.378','2018-10-24 15:41:50.077',155699,'LiSi','startevent1','endevent1',NULL,NULL,'',NULL),('7501','7501','2','contract:1:5004','2018-10-24 15:48:56.726',NULL,NULL,'LiSi','startevent1',NULL,NULL,NULL,'',NULL);
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_taskinst`
--

DROP TABLE IF EXISTS `act_hi_taskinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_taskinst`
--

LOCK TABLES `act_hi_taskinst` WRITE;
/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
INSERT INTO `act_hi_taskinst` VALUES ('5013','contract:1:5004','deptLeaderAudit','5005','5010','财务经理审批',NULL,NULL,NULL,'JaYi','2018-10-24 15:39:14.390',NULL,'2018-10-24 15:40:13.059',58669,NULL,50,NULL,NULL,NULL,''),('5018','contract:1:5004','managerAudit','5005','5010','经理审批',NULL,NULL,NULL,'WangJun','2018-10-24 15:40:13.064',NULL,'2018-10-24 15:41:23.962',70898,NULL,50,NULL,NULL,NULL,''),('5023','contract:1:5004','confirm','5005','5010','业务员确认',NULL,NULL,NULL,'LiSi','2018-10-24 15:41:23.970',NULL,'2018-10-24 15:41:49.930',25960,NULL,50,NULL,NULL,NULL,''),('7509','contract:1:5004','deptLeaderAudit','7501','7506','财务经理审批',NULL,NULL,NULL,'JaYi','2018-10-24 15:48:56.796',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_varinst`
--

DROP TABLE IF EXISTS `act_hi_varinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_varinst`
--

LOCK TABLES `act_hi_varinst` WRITE;
/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
INSERT INTO `act_hi_varinst` VALUES ('5007','5005','5005',NULL,'manLeader','string',0,NULL,NULL,NULL,'WangJun',NULL,'2018-10-24 15:39:14.379','2018-10-24 15:39:14.379'),('5008','5005','5005',NULL,'deptLeader','string',0,NULL,NULL,NULL,'JaYi',NULL,'2018-10-24 15:39:14.379','2018-10-24 15:39:14.379'),('5009','5005','5005',NULL,'applyUserId','string',0,NULL,NULL,NULL,'LiSi',NULL,'2018-10-24 15:39:14.379','2018-10-24 15:39:14.379'),('5015','5005','5005',NULL,'deptLeaderPass','boolean',0,NULL,NULL,1,NULL,NULL,'2018-10-24 15:40:13.058','2018-10-24 15:40:13.058'),('5020','5005','5005',NULL,'manLeaderPass','boolean',0,NULL,NULL,1,NULL,NULL,'2018-10-24 15:41:23.959','2018-10-24 15:41:23.959'),('5024','5005','5005',NULL,'confirmName','string',0,NULL,NULL,NULL,'LiSi',NULL,'2018-10-24 15:41:49.903','2018-10-24 15:41:49.903'),('7503','7501','7501',NULL,'manLeader','string',0,NULL,NULL,NULL,'WangJun',NULL,'2018-10-24 15:48:56.795','2018-10-24 15:48:56.795'),('7504','7501','7501',NULL,'deptLeader','string',0,NULL,NULL,NULL,'JaYi',NULL,'2018-10-24 15:48:56.795','2018-10-24 15:48:56.795'),('7505','7501','7501',NULL,'applyUserId','string',0,NULL,NULL,NULL,'LiSi',NULL,'2018-10-24 15:48:56.795','2018-10-24 15:48:56.795');
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_group`
--

DROP TABLE IF EXISTS `act_id_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_group`
--

LOCK TABLES `act_id_group` WRITE;
/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
INSERT INTO `act_id_group` VALUES ('admin',1,'管理员','security-role'),('employee',1,'房产经纪人',NULL),('financeManager',1,'财务经理',NULL),('generalManager',1,'经理',NULL),('hrManager',1,'人事经理',NULL);
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_info`
--

DROP TABLE IF EXISTS `act_id_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_info`
--

LOCK TABLES `act_id_info` WRITE;
/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_membership`
--

DROP TABLE IF EXISTS `act_id_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_membership`
--

LOCK TABLES `act_id_membership` WRITE;
/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
INSERT INTO `act_id_membership` VALUES ('admin','admin'),('CaiGang','employee'),('LiSi','employee'),('WangSan','employee'),('WangSanSan','employee'),('WangWu','employee'),('WuGang','employee'),('WuLu','employee'),('WuTian','employee'),('WuXiaoTian','employee'),('WuXiaoXiao','employee'),('WuYiTian','employee'),('YiGang','employee'),('ZhangSan','employee'),('JaYi','financeManager'),('JiaBai','financeManager'),('JiaEr','financeManager'),('JiaJiu','financeManager'),('JiaQi','financeManager'),('JiaSan','financeManager'),('JiaShi','financeManager'),('JiaSi','financeManager'),('LeEr','financeManager'),('LeSan','financeManager'),('LeSi','financeManager'),('LeWu','financeManager'),('LeYi','financeManager'),('LiJun','generalManager'),('LiMing','generalManager'),('LiMingMing','generalManager'),('LiNan','generalManager'),('LiYa','generalManager'),('LiuNanNan','generalManager'),('LiuXiaoNan','generalManager'),('WangJun','generalManager'),('XuanMing','generalManager'),('YiTian','generalManager'),('ZhangNan','generalManager'),('ZhangNanNan','generalManager'),('ZhangXiaoNan','generalManager'),('CaiYi','hrManager'),('GuLi','hrManager'),('LinGang','hrManager'),('LinJie','hrManager'),('LinLi','hrManager'),('LinLiLi','hrManager'),('LinTian','hrManager'),('LinXiao','hrManager'),('LinXiaoJie','hrManager'),('LinYiJie','hrManager'),('LiuJieJie','hrManager'),('LiuXiaoJie','hrManager'),('YiLai','hrManager');
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_user`
--

DROP TABLE IF EXISTS `act_id_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_user`
--

LOCK TABLES `act_id_user` WRITE;
/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
INSERT INTO `act_id_user` VALUES ('CaiGang',1,NULL,NULL,NULL,'4de3551a25d3cc461db6432ae023123f',NULL),('CaiYi',1,NULL,NULL,NULL,'8dfb7920aa501b8d35641e6243ead6cb',NULL),('GuLi',1,NULL,NULL,NULL,'b642ba2271d25d87c833e4c0dc4d7fa',NULL),('JaYi',1,NULL,NULL,NULL,'88d62ea5c711b13bc970c5c552acfff1',NULL),('JiaBai',1,NULL,NULL,NULL,'742cbcff067d6990ad22096576df05ca',NULL),('JiaEr',1,NULL,NULL,NULL,'cfc390525a66e9a395828660288e5e6e',NULL),('JiaJiu',1,NULL,NULL,NULL,'47125a5f53a662680b5b863507326ffc',NULL),('JiaQi',1,NULL,NULL,NULL,'d971df9441d60af93a87545e6a8f8841',NULL),('JiaSan',1,NULL,NULL,NULL,'fbdde2ba4891210f06f0740fc925ce8b',NULL),('JiaShi',1,NULL,NULL,NULL,'86720af528d24a74fc823bde470678f2',NULL),('JiaSi',1,NULL,NULL,NULL,'f14de7b32801584e98e8d3fd09507d68',NULL),('LeEr',1,NULL,NULL,NULL,'bb3beafc745ebfe96903a7cf4ed21c02',NULL),('LeSan',1,NULL,NULL,NULL,'e6096c2a621b6bf66b317db86505cc66',NULL),('LeSi',1,NULL,NULL,NULL,'b4e7d263d16e28f1b9c91fcd230046cd',NULL),('LeWu',1,NULL,NULL,NULL,'6d9090ec9e0c475a08ab7223f87517b8',NULL),('LeYi',1,NULL,NULL,NULL,'42934859769752fba46df68374abee29',NULL),('LiJun',1,NULL,NULL,NULL,'bc20e54573d2db853852f86802ab83de',NULL),('LiMing',1,NULL,NULL,NULL,'dbe83fd8da75338203d4e8dd0e20be17',NULL),('LiMingMing',1,NULL,NULL,NULL,'d4172513a29889bb78f644549e99f93f',NULL),('LiNan',1,NULL,NULL,NULL,'be33d74fcb297deee4a8f12367baa4de',NULL),('LiSi',1,NULL,NULL,NULL,'f2b29623b71270c404b47c5506ca722c',NULL),('LiYa',1,NULL,NULL,NULL,'c15dca1dd47bb240c99f7cf6481272a5',NULL),('LinGang',1,NULL,NULL,NULL,'59b0cfbf19c713dba020a60f547befc0',NULL),('LinJie',1,NULL,NULL,NULL,'4da9df32f0549fd84e52ca592356f954',NULL),('LinLi',1,NULL,NULL,NULL,'84e9edb45602671fc0899e2c5a23f482',NULL),('LinLiLi',1,NULL,NULL,NULL,'fce832eb92103cf592ad7313f84f4f4b',NULL),('LinTian',1,NULL,NULL,NULL,'97d6d5f5f9d76393980b1ebcd0d82bb8',NULL),('LinXiao',1,NULL,NULL,NULL,'8bd77c05192decfa1a28f0261a6041ba',NULL),('LinXiaoJie',1,NULL,NULL,NULL,'528e9fa60d3359922eb14c4d16611230',NULL),('LinYiJie',1,NULL,NULL,NULL,'8bcec842ce9c9aa7de8d2801937d78f6',NULL),('LiuJieJie',1,NULL,NULL,NULL,'3f87e1ae6fd548d201d1bb2da3f4196f',NULL),('LiuNanNan',1,NULL,NULL,NULL,'a607a2b0ab25be493ecee22fa2a0dcc7',NULL),('LiuXiaoJie',1,NULL,NULL,NULL,'7da88bad8b6b606989e3337e8869aead',NULL),('LiuXiaoNan',1,NULL,NULL,NULL,'c82686063c6b138a04febe6630d19274',NULL),('WangJun',1,NULL,NULL,NULL,'2f3ea981fa5a715a69118b48e576a9f5',NULL),('WangSan',1,NULL,NULL,NULL,'a04b3767af3058ed349daba19d98247f',NULL),('WangSanSan',1,NULL,NULL,NULL,'308ada00e527aace24185ac1216864a4',NULL),('WangWu',1,NULL,NULL,NULL,'56ed1afe5ccf20bc8e455a80ec343bfc',NULL),('WuGang',1,NULL,NULL,NULL,'6af5eb141ad012670b4eb92a956339a0',NULL),('WuLu',1,NULL,NULL,NULL,'390eac067bd9e05c4712d6cc8a405890',NULL),('WuTian',1,NULL,NULL,NULL,'975b5514d989f04215e45ad52cd730f9',NULL),('WuXiaoTian',1,NULL,NULL,NULL,'8ecacfda1995f3ebb7f7c1f36614d425',NULL),('WuXiaoXiao',1,NULL,NULL,NULL,'966757a1c2a6e38c7355f0d8d65d157b',NULL),('WuYiTian',1,NULL,NULL,NULL,'770fffab3e3fe150637ff1c3302e37d6',NULL),('XuanMing',1,NULL,NULL,NULL,'5fd50b5d1baea5f3e2d1f416618a6a70',NULL),('YiGang',1,NULL,NULL,NULL,'be456e160924a64e374766e8893b6eb7',NULL),('YiLai',1,NULL,NULL,NULL,'a7884f29233f00fa2da0d925742afd37',NULL),('YiTian',1,NULL,NULL,NULL,'9f60a994e1b7591bf417a03cfaf7faf4',NULL),('ZhangNan',1,NULL,NULL,NULL,'50541ce48b62a59478859829bdda8bad',NULL),('ZhangNanNan',1,NULL,NULL,NULL,'e375c6d64416244e4f85a7caaca7af13',NULL),('ZhangSan',1,NULL,NULL,NULL,'aab4811cffaec3a78c2359cef8c51af4',NULL),('ZhangXiaoNan',1,NULL,NULL,NULL,'f7618dd9216b3bb35f9be4ef85389c12',NULL),('admin',1,NULL,NULL,NULL,'21232f297a57a5a743894a0e4a801fc3',NULL);
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_procdef_info`
--

DROP TABLE IF EXISTS `act_procdef_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_procdef_info`
--

LOCK TABLES `act_procdef_info` WRITE;
/*!40000 ALTER TABLE `act_procdef_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_procdef_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_deployment`
--

DROP TABLE IF EXISTS `act_re_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_deployment`
--

LOCK TABLES `act_re_deployment` WRITE;
/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
INSERT INTO `act_re_deployment` VALUES ('5001',NULL,NULL,NULL,'','2018-10-24 07:39:00.179',NULL);
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_model`
--

DROP TABLE IF EXISTS `act_re_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_model`
--

LOCK TABLES `act_re_model` WRITE;
/*!40000 ALTER TABLE `act_re_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_procdef`
--

DROP TABLE IF EXISTS `act_re_procdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_procdef`
--

LOCK TABLES `act_re_procdef` WRITE;
/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
INSERT INTO `act_re_procdef` VALUES ('contract:1:5004',1,'http://www.activiti.org/test','合同流程','contract',1,'5001','contract.bpmn','contract.png','合同演示流程',0,1,1,'',NULL);
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_deadletter_job`
--

DROP TABLE IF EXISTS `act_ru_deadletter_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_deadletter_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_deadletter_job`
--

LOCK TABLES `act_ru_deadletter_job` WRITE;
/*!40000 ALTER TABLE `act_ru_deadletter_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_deadletter_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_event_subscr`
--

DROP TABLE IF EXISTS `act_ru_event_subscr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_event_subscr`
--

LOCK TABLES `act_ru_event_subscr` WRITE;
/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_execution`
--

DROP TABLE IF EXISTS `act_ru_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
  `TASK_COUNT_` int(11) DEFAULT NULL,
  `JOB_COUNT_` int(11) DEFAULT NULL,
  `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
  `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_execution`
--

LOCK TABLES `act_ru_execution` WRITE;
/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
INSERT INTO `act_ru_execution` VALUES ('7501',1,'7501','2',NULL,'contract:1:5004',NULL,'7501',NULL,1,0,1,0,0,1,NULL,'',NULL,'2018-10-24 15:48:56.726','LiSi',NULL,0,0,0,0,0,0,0,0,0),('7506',1,'7501',NULL,'7501','contract:1:5004',NULL,'7501','deptLeaderAudit',1,0,0,0,0,1,NULL,'',NULL,'2018-10-24 15:48:56.795',NULL,NULL,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_identitylink`
--

DROP TABLE IF EXISTS `act_ru_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_identitylink`
--

LOCK TABLES `act_ru_identitylink` WRITE;
/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
INSERT INTO `act_ru_identitylink` VALUES ('7502',1,NULL,'starter','LiSi',NULL,'7501',NULL),('7510',1,NULL,'participant','JaYi',NULL,'7501',NULL);
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_job`
--

DROP TABLE IF EXISTS `act_ru_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_job`
--

LOCK TABLES `act_ru_job` WRITE;
/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_suspended_job`
--

DROP TABLE IF EXISTS `act_ru_suspended_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_suspended_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_suspended_job`
--

LOCK TABLES `act_ru_suspended_job` WRITE;
/*!40000 ALTER TABLE `act_ru_suspended_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_suspended_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_task`
--

DROP TABLE IF EXISTS `act_ru_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_task`
--

LOCK TABLES `act_ru_task` WRITE;
/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
INSERT INTO `act_ru_task` VALUES ('7509',1,'7506','7501','contract:1:5004','财务经理审批',NULL,NULL,'deptLeaderAudit',NULL,'JaYi',NULL,50,'2018-10-24 07:48:56.796',NULL,NULL,1,'',NULL,NULL);
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_timer_job`
--

DROP TABLE IF EXISTS `act_ru_timer_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_timer_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TIMER_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_timer_job`
--

LOCK TABLES `act_ru_timer_job` WRITE;
/*!40000 ALTER TABLE `act_ru_timer_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_timer_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_variable`
--

DROP TABLE IF EXISTS `act_ru_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_variable`
--

LOCK TABLES `act_ru_variable` WRITE;
/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
INSERT INTO `act_ru_variable` VALUES ('7503',1,'string','manLeader','7501','7501',NULL,NULL,NULL,NULL,'WangJun',NULL),('7504',1,'string','deptLeader','7501','7501',NULL,NULL,NULL,NULL,'JaYi',NULL),('7505',1,'string','applyUserId','7501','7501',NULL,NULL,NULL,NULL,'LiSi',NULL);
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL,
  `customerName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `customerPosition` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `customerPrice` double NOT NULL,
  `customerProportion` double NOT NULL,
  `customerType` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `own` bit(1) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (10,'小明','东莞',120,125,'出售','\0',0),(11,'小丽','东莞',80,60,'出售','\0',0),(12,'小李','广州',90,100,'出售','\0',0),(13,'小菲','广州',100,90,'出租','\0',0),(14,'小康','广州',100,90,'出租','\0',0),(15,'小南','东莞',100,95,'出租','\0',0),(16,'小七','深圳',80,60,'出租','\0',0);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (17),(17);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `house`
--

DROP TABLE IF EXISTS `house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `house` (
  `id` bigint(20) NOT NULL,
  `houseName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `housePosition` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `housePrice` double NOT NULL,
  `houseProportion` double NOT NULL,
  `houseType` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `own` bit(1) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house`
--

LOCK TABLES `house` WRITE;
/*!40000 ALTER TABLE `house` DISABLE KEYS */;
INSERT INTO `house` VALUES (4,'玉翠秀府','东莞',123,120,'出售','\0',0),(3,'隆平家园','东莞',120,120,'出售','\0',0),(5,'龙房名苑','东莞',135,130,'出售','\0',0),(6,'会展名城','广州',132,130,'出售','\0',0),(7,'东方巴黎','广州',19,130,'出租','\0',0),(8,'月亮湾新区','广州',19,80,'出租','\0',0),(9,'林机小区','深圳',20,88,'出租','\0',0);
/*!40000 ALTER TABLE `house` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_attence`
--

DROP TABLE IF EXISTS `t_attence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_attence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appealreason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `attenceStatus` int(11) DEFAULT NULL,
  `day` datetime DEFAULT NULL,
  `deptLeaderBackReason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `hrBackReason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `processInstanceId` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `processStatus` int(11) DEFAULT NULL,
  `userId` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `workinTime` datetime DEFAULT NULL,
  `workoutTime` datetime DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK57nof4mf1sd3qrr1qi6tcx7pb` (`employee_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_attence`
--

LOCK TABLES `t_attence` WRITE;
/*!40000 ALTER TABLE `t_attence` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_attence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_contract`
--

DROP TABLE IF EXISTS `t_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_contract` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contractNumber` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `contractType` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `customerName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `depreason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `houseName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `manreason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `processInstanceId` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `processStatus` int(11) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `total` double NOT NULL,
  `userId` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKohphh9920fbrb5ynlgyit1oyf` (`employee_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_contract`
--

LOCK TABLES `t_contract` WRITE;
/*!40000 ALTER TABLE `t_contract` DISABLE KEYS */;
INSERT INTO `t_contract` VALUES (1,'Knorr20181024155142S','出售合同','小明',NULL,'2018-10-24 15:51:09','嘉湖花园',NULL,'',0,'2018-01-24 15:51:09',100,'admin',1),(2,'Knorr20181024155236R','出租合同','李明',NULL,'2018-10-24 15:51:49','宝成花园',NULL,'',0,'2018-01-24 15:51:49',12,'admin',1),(3,'Knorr20181024155411S','出售合同','小李',NULL,'2018-10-24 15:53:00','景湖春天',NULL,'',0,'2018-02-24 15:53:00',15,'WangJun',2),(4,'Knorr20181024155510S','出售合同','小红',NULL,'2018-10-24 15:54:20','温莎堡花园',NULL,'',0,'2018-05-24 15:54:20',20,'LiSi',4),(5,'Knorr20181024155646S','出售合同','小明',NULL,'2018-10-24 15:55:15','东江之星',NULL,'',0,'2018-07-24 15:55:15',100,'ZhangSan',9),(6,'Knorr20181024155911R','出租合同','小迪',NULL,'2018-10-24 15:57:00','翡翠华庭',NULL,'',0,'2018-06-24 15:57:00',18,'JiaEr',8),(7,'Knorr20181024163012R','出租合同','小明',NULL,'2018-10-24 16:26:47','碧桂园',NULL,'',0,'2018-04-24 16:26:47',30,'LiJun',10),(8,'Knorr20181024163159R','出租合同','小爱',NULL,'2018-10-24 16:31:27','紫金相府',NULL,'',0,'2018-06-24 16:31:27',20,'WangWu',12),(9,'Knorr20181024163309R','出租合同','小丽',NULL,'2018-10-24 16:32:21','玉翠秀府',NULL,'',0,'2018-10-24 16:32:21',18,'LiYa',14),(10,'Knorr20181024163423R','出租合同','小七',NULL,'2018-10-24 16:33:17','正阳花园',NULL,'',0,'2018-07-24 16:33:17',19,'WuLu',16),(11,'Knorr20181024163518S','出售合同','小天',NULL,'2018-10-24 16:34:28','优胜美地',NULL,'',0,'2018-09-24 16:34:28',120,'LiNan',18),(12,'Knorr20181024163604S','出售合同','小南',NULL,'2018-10-24 16:35:21','龙房名苑',NULL,'',0,'2018-09-24 16:35:21',130,'WuTian',20),(13,'Knorr20181024163654S','出售合同','小明',NULL,'2018-10-24 16:36:07','月亮湾新区',NULL,'',0,'2018-05-24 16:36:07',150,'LiMing',22),(14,'Knorr20181024163742S','出售合同','小小',NULL,'2018-10-24 16:36:57','会展名城',NULL,'',0,'2018-08-24 16:36:57',120,'WangSan',24),(15,'Knorr20181024163826R','出租合同','小丽',NULL,'2018-10-24 16:37:45','禹舜嘉园',NULL,'',0,'2018-01-24 16:37:45',25,'ZhangNan',26),(16,'Knorr20181024163910R','出租合同','小康',NULL,'2018-10-24 16:38:31','志华名苑',NULL,'',0,'2018-03-24 16:38:31',19,'WuYiTian',28),(17,'Knorr20181024163956S','出售合同','张晓',NULL,'2018-10-24 16:39:13','北鸿河畔公寓',NULL,'',0,'2018-05-24 16:39:13',150,'ZhangXiaoNan',30),(18,'Knorr20181024164056R','出租合同','张强',NULL,'2018-10-24 16:39:59','馨美家园',NULL,'',0,'2018-06-24 16:39:59',15,'WuXiaoTian',32),(19,'Knorr20181024164208R','出租合同','刘晓',NULL,'2018-10-24 16:41:06','百年新城',NULL,'',0,'2018-07-24 16:41:06',14,'LiuXiaoNan',34),(20,'Knorr20181024164258R','出租合同','武田',NULL,'2018-10-24 16:42:12','玉田风情苑',NULL,'',0,'2018-10-24 16:42:12',13,'WuXiaoXiao',36),(21,'Knorr20181024164344S','出售合同','李艾',NULL,'2018-10-24 16:43:01','紫金相府',NULL,'',0,'2018-08-24 16:43:01',120,'LiMingMing',38),(22,'Knorr20181024164429R','出租合同','小宇',NULL,'2018-10-24 16:43:47','玉翠秀府',NULL,'',0,'2018-10-24 16:43:47',18,'WangSanSan',40),(23,'Knorr20181024164517R','出租合同','小鱼鱼',NULL,'2018-10-24 16:44:34','正阳花园',NULL,'',0,'2018-10-24 16:44:34',19,'LiuNanNan',42),(24,'Knorr20181024164559R','出租合同','吴宇',NULL,'2018-10-24 16:45:22','会展名城',NULL,'',0,'2018-09-24 16:45:22',19,'WuGang',44),(25,'Knorr20181024164644S','出售合同','小希',NULL,'2018-10-24 16:46:02','绿海田园别墅',NULL,'',0,'2018-10-24 16:46:02',120,'ZhangNanNan',46),(26,'Knorr20181024164727S','出售合同','小溪',NULL,'2018-10-24 16:46:47','东方巴黎',NULL,'',0,'2018-10-24 16:46:47',120,'CaiGang',48),(27,'Knorr20181024164944S','出售合同','小何',NULL,'2018-10-24 16:49:06','隆平家园',NULL,'',0,'2018-10-24 16:49:06',180,'YiGang',52);
/*!40000 ALTER TABLE `t_contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_email`
--

DROP TABLE IF EXISTS `t_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_email` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emailAttachment` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `emailContent` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `emailFrom` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `emailStatus` int(11) DEFAULT NULL,
  `emailSubject` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `emailTo` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `inboxStatus` int(11) DEFAULT NULL,
  `readStatus` int(11) DEFAULT NULL,
  `replyStatus` int(11) DEFAULT NULL,
  `sendTime` datetime DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKr3av21qysrqr7d509i4ag3pux` (`employee_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_email`
--

LOCK TABLES `t_email` WRITE;
/*!40000 ALTER TABLE `t_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_employee`
--

DROP TABLE IF EXISTS `t_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `employeeName` varchar(255) COLLATE utf8_bin NOT NULL,
  `employeeNumber` varchar(255) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `picture` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `post` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `quotation` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `store_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_kltvbp6nenn0krqlwvdx9s0jv` (`employeeNumber`),
  KEY `FKd2ci4wnee96xcn5ngpq87plqh` (`store_id`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_employee`
--

LOCK TABLES `t_employee` WRITE;
/*!40000 ALTER TABLE `t_employee` DISABLE KEYS */;
INSERT INTO `t_employee` VALUES (1,NULL,'admin','admin','21232f297a57a5a743894a0e4a801fc3','','admin',NULL,1),(2,NULL,'WangJun','WangJun','2f3ea981fa5a715a69118b48e576a9f5','','经理',NULL,1),(3,NULL,'GuLi','GuLi','b642ba2271d25d87c833e4c0dc4d7fa','','人事经理',NULL,1),(4,NULL,'LiSi','LiSi','f2b29623b71270c404b47c5506ca722c','','房产经纪人',NULL,1),(5,NULL,'JaYi','JaYi','88d62ea5c711b13bc970c5c552acfff1','','财务经理',NULL,1),(6,NULL,'XuanMing','XuanMing','5fd50b5d1baea5f3e2d1f416618a6a70','','经理',NULL,2),(7,NULL,'LinGang','LinGang','59b0cfbf19c713dba020a60f547befc0','','人事经理',NULL,2),(8,NULL,'JiaEr','JiaEr','cfc390525a66e9a395828660288e5e6e','','财务经理',NULL,2),(9,NULL,'ZhangSan','ZhangSan','aab4811cffaec3a78c2359cef8c51af4','','房产经纪人',NULL,2),(10,NULL,'LiJun','LiJun','bc20e54573d2db853852f86802ab83de','','经理',NULL,3),(11,NULL,'LinXiao','LinXiao','8bd77c05192decfa1a28f0261a6041ba','','人事经理',NULL,3),(12,NULL,'WangWu','WangWu','56ed1afe5ccf20bc8e455a80ec343bfc','','房产经纪人',NULL,3),(13,NULL,'JiaSan','JiaSan','fbdde2ba4891210f06f0740fc925ce8b','','财务经理',NULL,3),(14,NULL,'LiYa','LiYa','c15dca1dd47bb240c99f7cf6481272a5','','经理',NULL,4),(15,NULL,'LinTian','LinTian','97d6d5f5f9d76393980b1ebcd0d82bb8','','人事经理',NULL,4),(16,NULL,'WuLu','WuLu','390eac067bd9e05c4712d6cc8a405890','','房产经纪人',NULL,4),(17,NULL,'JiaSi','JiaSi','f14de7b32801584e98e8d3fd09507d68','','财务经理',NULL,4),(18,NULL,'LiNan','LiNan','be33d74fcb297deee4a8f12367baa4de','','经理',NULL,5),(19,NULL,'LinJie','LinJie','4da9df32f0549fd84e52ca592356f954','','人事经理',NULL,5),(20,NULL,'WuTian','WuTian','975b5514d989f04215e45ad52cd730f9','','房产经纪人',NULL,5),(21,NULL,'JiaQi','JiaQi','d971df9441d60af93a87545e6a8f8841','','财务经理',NULL,5),(22,NULL,'LiMing','LiMing','dbe83fd8da75338203d4e8dd0e20be17','','经理',NULL,6),(23,NULL,'LinLi','LinLi','84e9edb45602671fc0899e2c5a23f482','','人事经理',NULL,6),(24,NULL,'WangSan','WangSan','a04b3767af3058ed349daba19d98247f','','房产经纪人',NULL,6),(25,NULL,'JiaBai','JiaBai','742cbcff067d6990ad22096576df05ca','','财务经理',NULL,6),(26,NULL,'ZhangNan','ZhangNan','50541ce48b62a59478859829bdda8bad','','经理',NULL,7),(27,NULL,'LinYiJie','LinYiJie','8bcec842ce9c9aa7de8d2801937d78f6','','人事经理',NULL,7),(28,NULL,'WuYiTian','WuYiTian','770fffab3e3fe150637ff1c3302e37d6','','房产经纪人',NULL,7),(29,NULL,'JiaJiu','JiaJiu','47125a5f53a662680b5b863507326ffc','','财务经理',NULL,7),(30,NULL,'ZhangXiaoNan','ZhangXiaoNan','f7618dd9216b3bb35f9be4ef85389c12','','经理',NULL,8),(31,NULL,'LinXiaoJie','LinXiaoJie','528e9fa60d3359922eb14c4d16611230','','人事经理',NULL,8),(32,NULL,'WuXiaoTian','WuXiaoTian','8ecacfda1995f3ebb7f7c1f36614d425','','房产经纪人',NULL,8),(33,NULL,'JiaShi','JiaShi','86720af528d24a74fc823bde470678f2','','财务经理',NULL,8),(34,NULL,'LiuXiaoNan','LiuXiaoNan','c82686063c6b138a04febe6630d19274','','经理',NULL,9),(35,NULL,'LiuXiaoJie','LiuXiaoJie','7da88bad8b6b606989e3337e8869aead','','人事经理',NULL,9),(36,NULL,'WuXiaoXiao','WuXiaoXiao','966757a1c2a6e38c7355f0d8d65d157b','','房产经纪人',NULL,9),(37,NULL,'LeYi','LeYi','42934859769752fba46df68374abee29','','财务经理',NULL,9),(38,NULL,'LiMingMing','LiMingMing','d4172513a29889bb78f644549e99f93f','','经理',NULL,10),(39,NULL,'LinLiLi','LinLiLi','fce832eb92103cf592ad7313f84f4f4b','','人事经理',NULL,10),(40,NULL,'WangSanSan','WangSanSan','308ada00e527aace24185ac1216864a4','','房产经纪人',NULL,10),(41,NULL,'LeEr','LeEr','bb3beafc745ebfe96903a7cf4ed21c02','','财务经理',NULL,10),(42,NULL,'LiuNanNan','LiuNanNan','a607a2b0ab25be493ecee22fa2a0dcc7','','经理',NULL,11),(43,NULL,'LiuJieJie','LiuJieJie','3f87e1ae6fd548d201d1bb2da3f4196f','','人事经理',NULL,11),(44,NULL,'WuGang','WuGang','6af5eb141ad012670b4eb92a956339a0','','房产经纪人',NULL,11),(45,NULL,'LeSan','LeSan','e6096c2a621b6bf66b317db86505cc66','','财务经理',NULL,11),(46,NULL,'ZhangNanNan','ZhangNanNan','e375c6d64416244e4f85a7caaca7af13','','经理',NULL,12),(47,NULL,'CaiYi','CaiYi','8dfb7920aa501b8d35641e6243ead6cb','','人事经理',NULL,12),(48,NULL,'CaiGang','CaiGang','4de3551a25d3cc461db6432ae023123f','','房产经纪人',NULL,12),(49,NULL,'LeSi','LeSi','b4e7d263d16e28f1b9c91fcd230046cd','','财务经理',NULL,12),(50,NULL,'YiTian','YiTian','9f60a994e1b7591bf417a03cfaf7faf4','','经理',NULL,13),(51,NULL,'YiLai','YiLai','a7884f29233f00fa2da0d925742afd37','','人事经理',NULL,13),(52,NULL,'YiGang','YiGang','be456e160924a64e374766e8893b6eb7','','房产经纪人',NULL,13),(53,NULL,'LeWu','LeWu','6d9090ec9e0c475a08ab7223f87517b8','','财务经理',NULL,13);
/*!40000 ALTER TABLE `t_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_event`
--

DROP TABLE IF EXISTS `t_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `allDay` bit(1) DEFAULT NULL,
  `calendarId` bigint(20) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_event`
--

LOCK TABLES `t_event` WRITE;
/*!40000 ALTER TABLE `t_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_leave`
--

DROP TABLE IF EXISTS `t_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_leave` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `applyTime` datetime DEFAULT NULL,
  `depReason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `hrReason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `leaveType` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `processInstanceId` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `processStatus` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `realityEndTime` datetime DEFAULT NULL,
  `realityStartTime` datetime DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `userId` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_leave`
--

LOCK TABLES `t_leave` WRITE;
/*!40000 ALTER TABLE `t_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_log`
--

DROP TABLE IF EXISTS `t_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `exception` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `method` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `operateDate` datetime DEFAULT NULL,
  `params` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `remoteAddr` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `requestUri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKi0ft3ajtm8f9xct4def03w2eb` (`employee_id`)
) ENGINE=MyISAM AUTO_INCREMENT=526 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_log`
--

LOCK TABLES `t_log` WRITE;
/*!40000 ALTER TABLE `t_log` DISABLE KEYS */;
INSERT INTO `t_log` VALUES (1,NULL,'GET','2018-10-24 15:07:24','_dc=1540364844181&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',39,'findAllStore','info',NULL),(2,NULL,'GET','2018-10-24 15:07:24','_dc=1540364844178&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',39,'findAllStore','info',NULL),(3,NULL,'POST','2018-10-24 15:07:39','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',63,'登录系统','info',4),(4,NULL,'GET','2018-10-24 15:07:39','_dc=1540364859211','0:0:0:0:0:0:0:1','/attence/isAttence',51,'考勤操作','info',4),(5,NULL,'GET','2018-10-24 15:07:42','_dc=1540364862247&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',23,'查看合同信息','info',4),(6,NULL,'GET','2018-10-24 15:07:49','_dc=1540364868635&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',4),(7,NULL,'POST','2018-10-24 15:07:49','_dc=1540364868555','0:0:0:0:0:0:0:1','/contract',31,'保存合同信息','info',4),(8,NULL,'GET','2018-10-24 15:07:50','_dc=1540364869881&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',29,'查看合同信息','info',4),(9,NULL,'GET','2018-10-24 15:07:57','_dc=1540364876605&page=1&start=0&limit=15&sort=id&dir=desc','0:0:0:0:0:0:0:1','/process-definition',37,'流程定义列表','info',4),(10,NULL,'POST','2018-10-24 15:08:06','','0:0:0:0:0:0:0:1','/process-definition',3003,'上传并部署流程资源','info',4),(11,NULL,'GET','2018-10-24 15:08:10','_dc=1540364889738&page=1&start=0&limit=15&sort=id&dir=desc','0:0:0:0:0:0:0:1','/process-definition',24,'流程定义列表','info',4),(12,NULL,'POST','2018-10-24 15:08:14','id=1','0:0:0:0:0:0:0:1','/contract/start',820,'启动合同审批流程','info',4),(13,NULL,'POST','2018-10-24 15:08:14','id=1','0:0:0:0:0:0:0:1','/contract/start',471,'启动合同审批流程','info',4),(14,NULL,'GET','2018-10-24 15:08:16','_dc=1540364895769&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',12,'查看合同信息','info',4),(15,NULL,'POST','2018-10-24 15:08:20','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(16,NULL,'GET','2018-10-24 15:08:21','_dc=1540364901372&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(17,NULL,'GET','2018-10-24 15:08:21','_dc=1540364901374&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(18,NULL,'POST','2018-10-24 15:08:39','userName=JaYi&password=','0:0:0:0:0:0:0:1','/login',65,'登录系统','info',5),(19,NULL,'GET','2018-10-24 15:08:39','_dc=1540364919155','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',5),(20,NULL,'GET','2018-10-24 15:08:44','_dc=1540364923983&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',57,'查询待处理合同审批任务','info',5),(21,NULL,'POST','2018-10-24 15:08:54','keys=deptLeaderPass,deptLeaderBackReason&values=true,&types=B,S','0:0:0:0:0:0:0:1','/contract/complete/2525',242,'完成合同审批任务','info',5),(22,NULL,'GET','2018-10-24 15:08:55','_dc=1540364935091&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',25,'查询待处理合同审批任务','info',5),(23,NULL,'POST','2018-10-24 15:08:57','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(24,NULL,'GET','2018-10-24 15:08:59','_dc=1540364938817&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(25,NULL,'GET','2018-10-24 15:08:59','_dc=1540364938821&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(26,NULL,'POST','2018-10-24 15:09:15','userName=WangJun&password=','0:0:0:0:0:0:0:1','/login',10,'登录系统','info',2),(27,NULL,'GET','2018-10-24 15:09:15','_dc=1540364955159','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',2),(28,NULL,'GET','2018-10-24 15:09:18','_dc=1540364958114&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',15,'查询待处理合同审批任务','info',2),(29,NULL,'POST','2018-10-24 15:09:31','keys=manLeaderPass,managerBackReason&values=true,&types=B,S','0:0:0:0:0:0:0:1','/contract/complete/2530',50,'完成合同审批任务','info',2),(30,NULL,'POST','2018-10-24 15:23:23','','0:0:0:0:0:0:0:1','/logout',6,'退出登录','info',NULL),(31,NULL,'GET','2018-10-24 15:23:25','_dc=1540365804840&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',29,'findAllStore','info',NULL),(32,NULL,'GET','2018-10-24 15:23:25','_dc=1540365804843&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',30,'findAllStore','info',NULL),(33,NULL,'POST','2018-10-24 15:23:30','userName=admin&password=','0:0:0:0:0:0:0:1','/login',48,'登录系统','info',1),(34,NULL,'GET','2018-10-24 15:23:30','_dc=1540365809654','0:0:0:0:0:0:0:1','/attence/isAttence',42,'考勤操作','info',1),(35,NULL,'GET','2018-10-24 15:23:33','','0:0:0:0:0:0:0:1','/group/current',1,'权限限制','info',1),(36,NULL,'GET','2018-10-24 15:23:33','','0:0:0:0:0:0:0:1','/user/current',7,'权限限制','info',1),(37,NULL,'GET','2018-10-24 15:23:34','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(38,NULL,'GET','2018-10-24 15:23:34','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(39,NULL,'GET','2018-10-24 15:23:35','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(40,NULL,'GET','2018-10-24 15:23:35','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(41,NULL,'GET','2018-10-24 15:23:37','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(42,NULL,'GET','2018-10-24 15:23:37','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(43,NULL,'GET','2018-10-24 15:23:38','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(44,NULL,'GET','2018-10-24 15:23:38','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(45,NULL,'GET','2018-10-24 15:23:48','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(46,NULL,'GET','2018-10-24 15:23:48','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(47,NULL,'GET','2018-10-24 15:23:53','_dc=1540365832489&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',21,'查看合同信息','info',1),(48,NULL,'GET','2018-10-24 15:23:55','_dc=1540365834751&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',31,'查询待处理合同审批任务','info',1),(49,NULL,'GET','2018-10-24 15:23:57','_dc=1540365837361&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/notice',10,'查看公告','info',1),(50,NULL,'GET','2018-10-24 15:23:59','_dc=1540365838693&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',15,'查询销售员月销售额','info',1),(51,NULL,'GET','2018-10-24 15:23:59','_dc=1540365838697&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',15,'数据分析','info',1),(52,NULL,'GET','2018-10-24 15:23:59','_dc=1540365838703&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',1),(53,NULL,'GET','2018-10-24 15:23:59','_dc=1540365838700&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',46,'业绩排行','info',1),(54,NULL,'GET','2018-10-24 15:24:01','_dc=1540365841224&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/addressList',55,'查看通讯录','info',1),(55,NULL,'GET','2018-10-24 15:24:02','_dc=1540365842106&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/calendar/findCalendars',3,'查看行程','info',1),(56,NULL,'GET','2018-10-24 15:24:02','_dc=1540365842173&calendar=1&startDate=2018-07-30T00:00:00.000Z&endDate=2019-01-04T00:00:00.000Z','0:0:0:0:0:0:0:1','/calendar/finds',6,'查看行程','info',1),(57,NULL,'GET','2018-10-24 15:24:02','_dc=1540365842180&calendar=3&startDate=2018-07-30T00:00:00.000Z&endDate=2019-01-04T00:00:00.000Z','0:0:0:0:0:0:0:1','/calendar/finds',6,'查看行程','info',1),(58,NULL,'GET','2018-10-24 15:24:02','_dc=1540365842177&calendar=2&startDate=2018-07-30T00:00:00.000Z&endDate=2019-01-04T00:00:00.000Z','0:0:0:0:0:0:0:1','/calendar/finds',7,'查看行程','info',1),(59,NULL,'GET','2018-10-24 15:24:04','_dc=1540365843626&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/attence',8,'查看个人的考勤记录','info',1),(60,NULL,'GET','2018-10-24 15:24:04','_dc=1540365843631&page=1&start=0&limit=15&group={\"property\":\"leaveType\",\"direction\":\"ASC\"}&sort=id&dir=DESC','0:0:0:0:0:0:0:1','/leave',13,'查看个人请假信息','info',1),(61,NULL,'GET','2018-10-24 15:24:08','_dc=1540365847949&page=1&start=0&limit=25&group={\"property\":\"storeName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/attence/getAllAttence',9,'查看所有的考勤记录','info',1),(62,NULL,'GET','2018-10-24 15:24:10','_dc=1540365850443&page=1&start=0&limit=25&sort=id&dir=desc','0:0:0:0:0:0:0:1','/leave/tasks',16,'查询待处理请假任务','info',1),(63,NULL,'GET','2018-10-24 15:24:10','_dc=1540365850447&page=1&start=0&limit=25&sort=id&dir=desc','0:0:0:0:0:0:0:1','/attence/tasks',28,'查询待处理流程任务','info',1),(64,NULL,'GET','2018-10-24 15:24:17','_dc=1540365857061&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email',35,'查询草稿箱','info',1),(65,NULL,'GET','2018-10-24 15:24:17','_dc=1540365857069&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findSend',31,'查询已发送','info',1),(66,NULL,'GET','2018-10-24 15:24:17','_dc=1540365857066&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findInbox',37,'查询收件箱','info',1),(67,NULL,'GET','2018-10-24 15:24:18','_dc=1540365857991&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findInbox',3,'查询收件箱','info',1),(68,NULL,'GET','2018-10-24 15:24:18','_dc=1540365857987&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email',5,'查询草稿箱','info',1),(69,NULL,'GET','2018-10-24 15:24:18','_dc=1540365857995&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findSend',2,'查询已发送','info',1),(70,NULL,'GET','2018-10-24 15:24:19','_dc=1540365859016&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email',3,'查询草稿箱','info',1),(71,NULL,'GET','2018-10-24 15:24:19','_dc=1540365859024&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findSend',1,'查询已发送','info',1),(72,NULL,'GET','2018-10-24 15:24:19','_dc=1540365859021&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findInbox',1,'查询收件箱','info',1),(73,NULL,'POST','2018-10-24 15:25:52','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(74,NULL,'GET','2018-10-24 15:25:54','_dc=1540365954272&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(75,NULL,'GET','2018-10-24 15:25:54','_dc=1540365954267&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(76,NULL,'POST','2018-10-24 15:26:21','userName=admin&password=','0:0:0:0:0:0:0:1','/login',25,'登录系统','info',1),(77,NULL,'GET','2018-10-24 15:26:21','_dc=1540365981158','0:0:0:0:0:0:0:1','/attence/isAttence',3,'考勤操作','info',1),(78,NULL,'GET','2018-10-24 15:27:20','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(79,NULL,'GET','2018-10-24 15:27:20','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(80,NULL,'GET','2018-10-24 15:28:12','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(81,NULL,'GET','2018-10-24 15:28:12','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(82,NULL,'GET','2018-10-24 15:28:21','_dc=1540366101118&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',17,'查看合同信息','info',1),(83,NULL,'GET','2018-10-24 15:29:12','_dc=1540366152230&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',1),(84,NULL,'GET','2018-10-24 15:29:12','_dc=1540366152233&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',1),(85,NULL,'POST','2018-10-24 15:29:17','userName=admin&password=','0:0:0:0:0:0:0:1','/login',17,'登录系统','info',1),(86,NULL,'GET','2018-10-24 15:29:17','_dc=1540366157136','0:0:0:0:0:0:0:1','/attence/isAttence',17,'考勤操作','info',1),(87,NULL,'GET','2018-10-24 15:29:21','_dc=1540366161230&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',12,'查看合同信息','info',1),(88,NULL,'GET','2018-10-24 15:29:23','_dc=1540366162769&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',5,'查看合同信息','info',1),(89,NULL,'GET','2018-10-24 15:29:23','_dc=1540366162970&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',5,'查看合同信息','info',1),(90,NULL,'GET','2018-10-24 15:29:23','_dc=1540366163112&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',1),(91,NULL,'GET','2018-10-24 15:29:23','_dc=1540366163281&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',1),(92,NULL,'GET','2018-10-24 15:29:23','_dc=1540366163458&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',5,'查看合同信息','info',1),(93,NULL,'GET','2018-10-24 15:29:24','_dc=1540366163615&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',1),(94,NULL,'GET','2018-10-24 15:29:24','_dc=1540366163790&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',1),(95,NULL,'GET','2018-10-24 15:29:24','_dc=1540366163958&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',1),(96,NULL,'GET','2018-10-24 15:29:24','_dc=1540366164117&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',1),(97,NULL,'GET','2018-10-24 15:29:24','_dc=1540366164304&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',7,'查看合同信息','info',1),(98,NULL,'GET','2018-10-24 15:29:24','_dc=1540366164440&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',1),(99,NULL,'GET','2018-10-24 15:29:25','_dc=1540366164642&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',1),(100,NULL,'GET','2018-10-24 15:29:25','_dc=1540366164760&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',1),(101,NULL,'GET','2018-10-24 15:29:25','_dc=1540366164924&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',1),(102,NULL,'GET','2018-10-24 15:29:26','_dc=1540366165565&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',1),(103,NULL,'GET','2018-10-24 15:29:26','_dc=1540366165922&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',1),(104,NULL,'GET','2018-10-24 15:29:35','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(105,NULL,'GET','2018-10-24 15:29:35','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(106,NULL,'GET','2018-10-24 15:29:36','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(107,NULL,'GET','2018-10-24 15:29:36','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(108,NULL,'GET','2018-10-24 15:29:38','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(109,NULL,'GET','2018-10-24 15:29:38','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(110,NULL,'GET','2018-10-24 15:30:14','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(111,NULL,'GET','2018-10-24 15:30:14','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(112,NULL,'GET','2018-10-24 15:30:16','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(113,NULL,'GET','2018-10-24 15:30:16','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(114,NULL,'GET','2018-10-24 15:30:31','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(115,NULL,'GET','2018-10-24 15:30:31','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(116,NULL,'GET','2018-10-24 15:30:44','_dc=1540366243839&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',20,'查询待处理合同审批任务','info',1),(117,NULL,'GET','2018-10-24 15:32:10','_dc=1540366330405&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/notice',4,'查看公告','info',1),(118,NULL,'GET','2018-10-24 15:32:15','_dc=1540366334765&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',5,'业绩排行','info',1),(119,NULL,'GET','2018-10-24 15:32:15','_dc=1540366334774&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',1),(120,NULL,'GET','2018-10-24 15:32:15','_dc=1540366334764&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',4,'查询销售员月销售额','info',1),(121,NULL,'GET','2018-10-24 15:32:15','_dc=1540366334765&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',4,'数据分析','info',1),(122,NULL,'POST','2018-10-24 15:37:28','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(123,NULL,'GET','2018-10-24 15:37:30','_dc=1540366650113&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(124,NULL,'GET','2018-10-24 15:37:30','_dc=1540366650110&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(125,NULL,'POST','2018-10-24 15:38:28','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',12,'登录系统','info',4),(126,NULL,'GET','2018-10-24 15:38:29','_dc=1540366708545','0:0:0:0:0:0:0:1','/attence/isAttence',1,'考勤操作','info',4),(127,NULL,'GET','2018-10-24 15:38:49','_dc=1540366728735&page=1&start=0&limit=15&sort=id&dir=desc','0:0:0:0:0:0:0:1','/process-definition',38,'流程定义列表','info',4),(128,NULL,'DELETE','2018-10-24 15:38:52','','0:0:0:0:0:0:0:1','/process-definition',839,'删除流程定义','info',4),(129,NULL,'GET','2018-10-24 15:38:53','_dc=1540366733452&page=1&start=0&limit=15&sort=id&dir=desc','0:0:0:0:0:0:0:1','/process-definition',3,'流程定义列表','info',4),(130,NULL,'POST','2018-10-24 15:39:00','','0:0:0:0:0:0:0:1','/process-definition',273,'上传并部署流程资源','info',4),(131,NULL,'GET','2018-10-24 15:39:01','_dc=1540366741195&page=1&start=0&limit=15&sort=id&dir=desc','0:0:0:0:0:0:0:1','/process-definition',4,'流程定义列表','info',4),(132,NULL,'GET','2018-10-24 15:39:05','_dc=1540366744521&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',6,'查看合同信息','info',4),(133,NULL,'POST','2018-10-24 15:39:10','_dc=1540366750241','0:0:0:0:0:0:0:1','/contract',12,'保存合同信息','info',4),(134,NULL,'GET','2018-10-24 15:39:10','_dc=1540366750313&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',27,'查看合同信息','info',4),(135,NULL,'POST','2018-10-24 15:39:14','id=1','0:0:0:0:0:0:0:1','/contract/start',162,'启动合同审批流程','info',4),(136,NULL,'GET','2018-10-24 15:39:16','_dc=1540366755765&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',4),(137,NULL,'POST','2018-10-24 15:39:20','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(138,NULL,'GET','2018-10-24 15:39:21','_dc=1540366761250&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(139,NULL,'GET','2018-10-24 15:39:21','_dc=1540366761253&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',3,'findAllStore','info',NULL),(140,NULL,'POST','2018-10-24 15:39:37','userName=JaYi&password=','0:0:0:0:0:0:0:1','/login',100,'登录系统','info',5),(141,NULL,'GET','2018-10-24 15:39:37','_dc=1540366776903','0:0:0:0:0:0:0:1','/attence/isAttence',1,'考勤操作','info',5),(142,NULL,'GET','2018-10-24 15:39:40','_dc=1540366779621&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',27,'查询待处理合同审批任务','info',5),(143,NULL,'POST','2018-10-24 15:40:13','keys=deptLeaderPass,deptLeaderBackReason&values=true,&types=B,S','0:0:0:0:0:0:0:1','/contract/complete/5013',239,'完成合同审批任务','info',5),(144,NULL,'GET','2018-10-24 15:40:14','_dc=1540366814195&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',5,'查询待处理合同审批任务','info',5),(145,NULL,'POST','2018-10-24 15:40:16','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(146,NULL,'GET','2018-10-24 15:40:18','_dc=1540366817850&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(147,NULL,'GET','2018-10-24 15:40:18','_dc=1540366817847&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(148,NULL,'POST','2018-10-24 15:40:33','userName=WangJun&password=','0:0:0:0:0:0:0:1','/login',17,'登录系统','info',2),(149,NULL,'GET','2018-10-24 15:40:33','_dc=1540366833131','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',2),(150,NULL,'GET','2018-10-24 15:40:39','_dc=1540366838835&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',14,'查询待处理合同审批任务','info',2),(151,NULL,'POST','2018-10-24 15:40:46','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(152,NULL,'GET','2018-10-24 15:40:48','_dc=1540366847971&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(153,NULL,'GET','2018-10-24 15:40:48','_dc=1540366847969&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(154,NULL,'POST','2018-10-24 15:40:57','userName=XuanMing&password=','0:0:0:0:0:0:0:1','/login',11,'登录系统','info',6),(155,NULL,'GET','2018-10-24 15:40:57','_dc=1540366856657','0:0:0:0:0:0:0:1','/attence/isAttence',1,'考勤操作','info',6),(156,NULL,'GET','2018-10-24 15:40:59','_dc=1540366858732&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',7,'查询待处理合同审批任务','info',6),(157,NULL,'POST','2018-10-24 15:41:01','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(158,NULL,'GET','2018-10-24 15:41:03','_dc=1540366862633&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(159,NULL,'GET','2018-10-24 15:41:03','_dc=1540366862630&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(160,NULL,'POST','2018-10-24 15:41:10','userName=WangJun&password=','0:0:0:0:0:0:0:1','/login',11,'登录系统','info',2),(161,NULL,'GET','2018-10-24 15:41:10','_dc=1540366870212','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',2),(162,NULL,'GET','2018-10-24 15:41:20','_dc=1540366880292&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',27,'查询待处理合同审批任务','info',2),(163,NULL,'POST','2018-10-24 15:41:24','keys=manLeaderPass,managerBackReason&values=true,&types=B,S','0:0:0:0:0:0:0:1','/contract/complete/5018',164,'完成合同审批任务','info',2),(164,NULL,'GET','2018-10-24 15:41:25','_dc=1540366885190&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',9,'查询待处理合同审批任务','info',2),(165,NULL,'POST','2018-10-24 15:41:29','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(166,NULL,'GET','2018-10-24 15:41:30','_dc=1540366890325&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(167,NULL,'GET','2018-10-24 15:41:30','_dc=1540366890322&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(168,NULL,'POST','2018-10-24 15:41:39','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',12,'登录系统','info',4),(169,NULL,'GET','2018-10-24 15:41:39','_dc=1540366898926','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',4),(170,NULL,'GET','2018-10-24 15:41:41','_dc=1540366901201&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',31,'查询待处理合同审批任务','info',4),(171,NULL,'POST','2018-10-24 15:41:50','keys=confirmName&values=LiSi&types=S','0:0:0:0:0:0:0:1','/contract/complete/5023',290,'完成合同审批任务','info',4),(172,NULL,'GET','2018-10-24 15:41:51','_dc=1540366911269&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',4,'查询待处理合同审批任务','info',4),(173,NULL,'GET','2018-10-24 15:41:55','_dc=1540366914769&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',7,'查看合同信息','info',4),(174,NULL,'POST','2018-10-24 15:43:09','_dc=1540366988518','0:0:0:0:0:0:0:1','/contract',18,'保存合同信息','info',4),(175,NULL,'GET','2018-10-24 15:43:09','_dc=1540366988617&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',25,'查看合同信息','info',4),(176,NULL,'POST','2018-10-24 15:43:47','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(177,NULL,'GET','2018-10-24 15:43:49','_dc=1540367028861&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(178,NULL,'GET','2018-10-24 15:43:49','_dc=1540367028855&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',5,'findAllStore','info',NULL),(179,NULL,'POST','2018-10-24 15:43:57','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',9,'登录系统','info',4),(180,NULL,'GET','2018-10-24 15:43:57','_dc=1540367037102','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',4),(181,NULL,'GET','2018-10-24 15:43:59','_dc=1540367039419&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',4),(182,NULL,'POST','2018-10-24 15:48:15','','0:0:0:0:0:0:0:1','/logout',10,'退出登录','info',NULL),(183,NULL,'GET','2018-10-24 15:48:17','_dc=1540367296642&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',60,'findAllStore','info',NULL),(184,NULL,'GET','2018-10-24 15:48:17','_dc=1540367296639&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',60,'findAllStore','info',NULL),(185,NULL,'POST','2018-10-24 15:48:27','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',67,'登录系统','info',4),(186,NULL,'GET','2018-10-24 15:48:27','_dc=1540367307426','0:0:0:0:0:0:0:1','/attence/isAttence',151,'考勤操作','info',4),(187,NULL,'GET','2018-10-24 15:48:30','_dc=1540367309797&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',66,'查看合同信息','info',4),(188,NULL,'POST','2018-10-24 15:48:47','_dc=1540367327289','0:0:0:0:0:0:0:1','/contract',22,'保存合同信息','info',4),(189,NULL,'GET','2018-10-24 15:48:47','_dc=1540367327378&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',7,'查看合同信息','info',4),(190,NULL,'POST','2018-10-24 15:48:57','id=2','0:0:0:0:0:0:0:1','/contract/start',1030,'启动合同审批流程','info',4),(191,NULL,'GET','2018-10-24 15:48:59','_dc=1540367338827&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',7,'查看合同信息','info',4),(192,NULL,'POST','2018-10-24 15:49:17','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(193,NULL,'GET','2018-10-24 15:49:18','_dc=1540367358459&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(194,NULL,'GET','2018-10-24 15:49:18','_dc=1540367358456&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(195,NULL,'POST','2018-10-24 15:49:27','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',11,'登录系统','info',4),(196,NULL,'GET','2018-10-24 15:49:27','_dc=1540367367212','0:0:0:0:0:0:0:1','/attence/isAttence',44,'考勤操作','info',4),(197,NULL,'GET','2018-10-24 15:49:31','_dc=1540367371483&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',198,'查看合同信息','info',4),(198,NULL,'POST','2018-10-24 15:50:02','_dc=1540367401645','0:0:0:0:0:0:0:1','/contract',6,'保存合同信息','info',4),(199,NULL,'GET','2018-10-24 15:50:02','_dc=1540367401725&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',4),(200,NULL,'GET','2018-10-24 15:50:04','_dc=1540367403613&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',13,'查看合同信息','info',4),(201,NULL,'GET','2018-10-24 15:50:04','_dc=1540367404349&start=0&limit=20&page=1&contractNumber=&customerName=&contractType=&houseName=&timeStart=&timeEnd=&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',24,'查看合同信息','info',4),(202,NULL,'POST','2018-10-24 15:51:08','','0:0:0:0:0:0:0:1','/logout',8,'退出登录','info',NULL),(203,NULL,'GET','2018-10-24 15:51:10','_dc=1540367469809&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',28,'findAllStore','info',NULL),(204,NULL,'GET','2018-10-24 15:51:10','_dc=1540367469805&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',38,'findAllStore','info',NULL),(205,NULL,'POST','2018-10-24 15:51:21','userName=admin&password=','0:0:0:0:0:0:0:1','/login',154,'登录系统','info',1),(206,NULL,'GET','2018-10-24 15:51:21','_dc=1540367481277','0:0:0:0:0:0:0:1','/attence/isAttence',119,'考勤操作','info',1),(207,NULL,'GET','2018-10-24 15:51:25','_dc=1540367484828&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',33,'查看合同信息','info',1),(208,NULL,'POST','2018-10-24 15:51:43','_dc=1540367502681','0:0:0:0:0:0:0:1','/contract',13,'保存合同信息','info',1),(209,NULL,'GET','2018-10-24 15:51:43','_dc=1540367502772&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',16,'查看合同信息','info',1),(210,NULL,'POST','2018-10-24 15:51:48','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(211,NULL,'GET','2018-10-24 15:51:50','_dc=1540367509813&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(212,NULL,'GET','2018-10-24 15:51:50','_dc=1540367509816&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(213,NULL,'POST','2018-10-24 15:51:55','userName=admin&password=','0:0:0:0:0:0:0:1','/login',11,'登录系统','info',1),(214,NULL,'GET','2018-10-24 15:51:55','_dc=1540367514605','0:0:0:0:0:0:0:1','/attence/isAttence',3,'考勤操作','info',1),(215,NULL,'GET','2018-10-24 15:51:58','_dc=1540367518100&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',1),(216,NULL,'POST','2018-10-24 15:52:37','_dc=1540367556606','0:0:0:0:0:0:0:1','/contract',10,'保存合同信息','info',1),(217,NULL,'GET','2018-10-24 15:52:37','_dc=1540367556708&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',1),(218,NULL,'POST','2018-10-24 15:52:59','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(219,NULL,'GET','2018-10-24 15:53:01','_dc=1540367580696&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(220,NULL,'GET','2018-10-24 15:53:01','_dc=1540367580699&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(221,NULL,'POST','2018-10-24 15:53:28','userName=WangJun&password=','0:0:0:0:0:0:0:1','/login',7,'登录系统','info',2),(222,NULL,'GET','2018-10-24 15:53:28','_dc=1540367607770','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',2),(223,NULL,'GET','2018-10-24 15:53:31','_dc=1540367610518&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',2),(224,NULL,'POST','2018-10-24 15:54:11','_dc=1540367651286','0:0:0:0:0:0:0:1','/contract',13,'保存合同信息','info',2),(225,NULL,'GET','2018-10-24 15:54:11','_dc=1540367651362&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',16,'查看合同信息','info',2),(226,NULL,'POST','2018-10-24 15:54:19','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(227,NULL,'GET','2018-10-24 15:54:20','_dc=1540367660428&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(228,NULL,'GET','2018-10-24 15:54:20','_dc=1540367660431&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(229,NULL,'POST','2018-10-24 15:54:35','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',18,'登录系统','info',4),(230,NULL,'GET','2018-10-24 15:54:35','_dc=1540367675323','0:0:0:0:0:0:0:1','/attence/isAttence',1,'考勤操作','info',4),(231,NULL,'GET','2018-10-24 15:54:40','_dc=1540367680032&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',12,'查看合同信息','info',4),(232,NULL,'POST','2018-10-24 15:55:10','_dc=1540367710018','0:0:0:0:0:0:0:1','/contract',6,'保存合同信息','info',4),(233,NULL,'GET','2018-10-24 15:55:10','_dc=1540367710095&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',4),(234,NULL,'POST','2018-10-24 15:55:14','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(235,NULL,'GET','2018-10-24 15:55:15','_dc=1540367715244&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(236,NULL,'GET','2018-10-24 15:55:15','_dc=1540367715241&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(237,NULL,'POST','2018-10-24 15:55:45','userName=ZhangSan&password=','0:0:0:0:0:0:0:1','/login',44,'登录系统','info',9),(238,NULL,'GET','2018-10-24 15:55:45','_dc=1540367745157','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',9),(239,NULL,'GET','2018-10-24 15:55:55','_dc=1540367754857&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',9),(240,NULL,'POST','2018-10-24 15:56:47','_dc=1540367806893','0:0:0:0:0:0:0:1','/contract',16,'保存合同信息','info',9),(241,NULL,'GET','2018-10-24 15:56:47','_dc=1540367806974&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',15,'查看合同信息','info',9),(242,NULL,'POST','2018-10-24 15:56:59','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(243,NULL,'GET','2018-10-24 15:57:00','_dc=1540367820216&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(244,NULL,'GET','2018-10-24 15:57:00','_dc=1540367820212&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(245,NULL,'POST','2018-10-24 15:57:10','userName=JiaEr&password=','0:0:0:0:0:0:0:1','/login',12,'登录系统','info',8),(246,NULL,'GET','2018-10-24 15:57:10','_dc=1540367829616','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',8),(247,NULL,'GET','2018-10-24 15:57:12','_dc=1540367832062&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',7,'查看合同信息','info',8),(248,NULL,'POST','2018-10-24 15:59:11','_dc=1540367951172','0:0:0:0:0:0:0:1','/contract',11,'保存合同信息','info',8),(249,NULL,'GET','2018-10-24 15:59:11','_dc=1540367951259&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',14,'查看合同信息','info',8),(250,NULL,'POST','2018-10-24 15:59:14','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(251,NULL,'GET','2018-10-24 15:59:15','_dc=1540367955402&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(252,NULL,'GET','2018-10-24 15:59:15','_dc=1540367955405&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(253,NULL,'POST','2018-10-24 16:05:40','userName=WangJun&password=','0:0:0:0:0:0:0:1','/login',15,'登录系统','info',2),(254,NULL,'GET','2018-10-24 16:05:41','_dc=1540368340552','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',2),(255,NULL,'GET','2018-10-24 16:05:43','','0:0:0:0:0:0:0:1','/group/current',2,'权限限制','info',2),(256,NULL,'GET','2018-10-24 16:05:43','','0:0:0:0:0:0:0:1','/user/current',14,'权限限制','info',2),(257,NULL,'GET','2018-10-24 16:08:52','_dc=1540368532215&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/notice',13,'查看公告','info',2),(258,NULL,'POST','2018-10-24 16:08:59','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(259,NULL,'GET','2018-10-24 16:09:01','_dc=1540368540620&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(260,NULL,'GET','2018-10-24 16:09:01','_dc=1540368540617&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(261,NULL,'POST','2018-10-24 16:09:04','userName=admin&password=','0:0:0:0:0:0:0:1','/login',15,'登录系统','info',1),(262,NULL,'GET','2018-10-24 16:09:04','_dc=1540368544376','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',1),(263,NULL,'GET','2018-10-24 16:09:08','_dc=1540368548103&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email',92,'查询草稿箱','info',1),(264,NULL,'GET','2018-10-24 16:09:08','_dc=1540368548104&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findSend',101,'查询已发送','info',1),(265,NULL,'GET','2018-10-24 16:09:08','_dc=1540368548103&page=1&start=0&limit=20&group={\"property\":\"sendDay\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/email/findInbox',89,'查询收件箱','info',1),(266,NULL,'POST','2018-10-24 16:10:27','','0:0:0:0:0:0:0:1','/logout',1,'退出登录','info',NULL),(267,NULL,'GET','2018-10-24 16:10:28','_dc=1540368628391&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(268,NULL,'GET','2018-10-24 16:10:28','_dc=1540368628394&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(269,NULL,'POST','2018-10-24 16:21:34','userName=admin&password=','0:0:0:0:0:0:0:1','/login',274,'登录系统','info',1),(270,NULL,'GET','2018-10-24 16:21:35','_dc=1540369294764','0:0:0:0:0:0:0:1','/attence/isAttence',10,'考勤操作','info',1),(271,NULL,'GET','2018-10-24 16:21:37','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(272,NULL,'GET','2018-10-24 16:21:37','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(273,NULL,'GET','2018-10-24 16:21:38','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(274,NULL,'GET','2018-10-24 16:21:38','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(275,NULL,'GET','2018-10-24 16:21:39','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(276,NULL,'GET','2018-10-24 16:21:39','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(277,NULL,'GET','2018-10-24 16:21:41','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(278,NULL,'GET','2018-10-24 16:21:41','','0:0:0:0:0:0:0:1','/group/current',4,'权限限制','info',1),(279,NULL,'GET','2018-10-24 16:21:41','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(280,NULL,'GET','2018-10-24 16:21:41','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(281,NULL,'GET','2018-10-24 16:21:42','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(282,NULL,'GET','2018-10-24 16:21:42','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(283,NULL,'GET','2018-10-24 16:21:43','_dc=1540369303465&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',34,'查看合同信息','info',1),(284,NULL,'GET','2018-10-24 16:21:46','_dc=1540369305791&page=1&start=0&limit=25&group={\"property\":\"taskName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/contract/tasks',61,'查询待处理合同审批任务','info',1),(285,NULL,'GET','2018-10-24 16:21:53','_dc=1540369312519&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/notice',5,'查看公告','info',1),(286,NULL,'GET','2018-10-24 16:21:58','_dc=1540369317948&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',50,'查询销售员月销售额','info',1),(287,NULL,'GET','2018-10-24 16:21:58','_dc=1540369318007&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',1),(288,NULL,'GET','2018-10-24 16:21:58','_dc=1540369317949&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',72,'数据分析','info',1),(289,NULL,'GET','2018-10-24 16:21:58','_dc=1540369317950&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',125,'业绩排行','info',1),(290,NULL,'GET','2018-10-24 16:22:01','_dc=1540369320486&page=1&start=0&limit=25&group={\"property\":\"storeName\",\"direction\":\"ASC\"}&sort=id&dir=desc','0:0:0:0:0:0:0:1','/attence/getAllAttence',18,'查看所有的考勤记录','info',1),(291,NULL,'GET','2018-10-24 16:22:03','_dc=1540369323396&page=1&start=0&limit=25&sort=id&dir=desc','0:0:0:0:0:0:0:1','/attence/tasks',15,'查询待处理流程任务','info',1),(292,NULL,'GET','2018-10-24 16:22:03','_dc=1540369323394&page=1&start=0&limit=25&sort=id&dir=desc','0:0:0:0:0:0:0:1','/leave/tasks',20,'查询待处理请假任务','info',1),(293,NULL,'POST','2018-10-24 16:24:45','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(294,NULL,'GET','2018-10-24 16:24:47','_dc=1540369487057&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(295,NULL,'GET','2018-10-24 16:24:47','_dc=1540369487055&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(296,NULL,'POST','2018-10-24 16:25:00','userName=LiSi&password=','0:0:0:0:0:0:0:1','/login',9,'登录系统','info',4),(297,NULL,'GET','2018-10-24 16:25:00','_dc=1540369499812','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',4),(298,NULL,'GET','2018-10-24 16:25:12','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',4),(299,NULL,'GET','2018-10-24 16:25:12','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',4),(300,NULL,'POST','2018-10-24 16:26:45','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(301,NULL,'GET','2018-10-24 16:26:47','_dc=1540369607473&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(302,NULL,'GET','2018-10-24 16:26:47','_dc=1540369607468&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(303,NULL,'POST','2018-10-24 16:27:05','userName=LiJun&password=','0:0:0:0:0:0:0:1','/login',19,'登录系统','info',10),(304,NULL,'GET','2018-10-24 16:27:05','_dc=1540369624742','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',10),(305,NULL,'GET','2018-10-24 16:27:08','_dc=1540369628402&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',10),(306,NULL,'POST','2018-10-24 16:30:13','_dc=1540369812696','0:0:0:0:0:0:0:1','/contract',15,'保存合同信息','info',10),(307,NULL,'GET','2018-10-24 16:30:13','_dc=1540369812788&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',23,'查看合同信息','info',10),(308,NULL,'POST','2018-10-24 16:31:25','','0:0:0:0:0:0:0:1','/logout',1,'退出登录','info',NULL),(309,NULL,'GET','2018-10-24 16:31:27','_dc=1540369887036&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(310,NULL,'GET','2018-10-24 16:31:27','_dc=1540369887032&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(311,NULL,'POST','2018-10-24 16:31:35','userName=WangWu&password=','0:0:0:0:0:0:0:1','/login',7,'登录系统','info',12),(312,NULL,'GET','2018-10-24 16:31:35','_dc=1540369895100','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',12),(313,NULL,'GET','2018-10-24 16:31:38','_dc=1540369897877&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',12),(314,NULL,'POST','2018-10-24 16:31:59','_dc=1540369919444','0:0:0:0:0:0:0:1','/contract',5,'保存合同信息','info',12),(315,NULL,'GET','2018-10-24 16:32:00','_dc=1540369919521&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',12,'查看合同信息','info',12),(316,NULL,'POST','2018-10-24 16:32:20','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(317,NULL,'GET','2018-10-24 16:32:22','_dc=1540369941725&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(318,NULL,'GET','2018-10-24 16:32:22','_dc=1540369941727&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(319,NULL,'POST','2018-10-24 16:32:41','userName=LiYa&password=','0:0:0:0:0:0:0:1','/login',14,'登录系统','info',14),(320,NULL,'GET','2018-10-24 16:32:41','_dc=1540369961071','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',14),(321,NULL,'GET','2018-10-24 16:32:44','_dc=1540369964295&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',14),(322,NULL,'POST','2018-10-24 16:33:09','_dc=1540369989413','0:0:0:0:0:0:0:1','/contract',12,'保存合同信息','info',14),(323,NULL,'GET','2018-10-24 16:33:10','_dc=1540369989500&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',16,'查看合同信息','info',14),(324,NULL,'POST','2018-10-24 16:33:16','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(325,NULL,'GET','2018-10-24 16:33:17','_dc=1540369997108&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(326,NULL,'GET','2018-10-24 16:33:17','_dc=1540369997111&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(327,NULL,'POST','2018-10-24 16:33:35','userName=WuLu&password=','0:0:0:0:0:0:0:1','/login',11,'登录系统','info',16),(328,NULL,'GET','2018-10-24 16:33:35','_dc=1540370015162','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',16),(329,NULL,'GET','2018-10-24 16:33:44','_dc=1540370023872&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',12,'查看合同信息','info',16),(330,NULL,'POST','2018-10-24 16:34:23','_dc=1540370063021','0:0:0:0:0:0:0:1','/contract',7,'保存合同信息','info',16),(331,NULL,'GET','2018-10-24 16:34:23','_dc=1540370063112&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',16),(332,NULL,'POST','2018-10-24 16:34:27','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(333,NULL,'GET','2018-10-24 16:34:28','_dc=1540370068088&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(334,NULL,'GET','2018-10-24 16:34:28','_dc=1540370068091&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(335,NULL,'POST','2018-10-24 16:34:54','userName=LiNan&password=','0:0:0:0:0:0:0:1','/login',15,'登录系统','info',18),(336,NULL,'GET','2018-10-24 16:34:54','_dc=1540370093587','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',18),(337,NULL,'GET','2018-10-24 16:34:58','_dc=1540370097509&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',7,'查看合同信息','info',18),(338,NULL,'POST','2018-10-24 16:35:18','_dc=1540370118132','0:0:0:0:0:0:0:1','/contract',14,'保存合同信息','info',18),(339,NULL,'GET','2018-10-24 16:35:18','_dc=1540370118220&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',16,'查看合同信息','info',18),(340,NULL,'POST','2018-10-24 16:35:20','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(341,NULL,'GET','2018-10-24 16:35:22','_dc=1540370121937&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(342,NULL,'GET','2018-10-24 16:35:22','_dc=1540370121934&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(343,NULL,'POST','2018-10-24 16:35:34','userName=WuTian&password=','0:0:0:0:0:0:0:1','/login',15,'登录系统','info',20),(344,NULL,'GET','2018-10-24 16:35:34','_dc=1540370133757','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',20),(345,NULL,'GET','2018-10-24 16:35:37','_dc=1540370137450&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',20),(346,NULL,'POST','2018-10-24 16:36:04','_dc=1540370164312','0:0:0:0:0:0:0:1','/contract',6,'保存合同信息','info',20),(347,NULL,'GET','2018-10-24 16:36:04','_dc=1540370164390&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',13,'查看合同信息','info',20),(348,NULL,'POST','2018-10-24 16:36:06','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(349,NULL,'GET','2018-10-24 16:36:08','_dc=1540370167757&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(350,NULL,'GET','2018-10-24 16:36:08','_dc=1540370167753&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(351,NULL,'POST','2018-10-24 16:36:24','userName=LIMing&password=','0:0:0:0:0:0:0:1','/login',2,'登录系统','info',NULL),(352,NULL,'POST','2018-10-24 16:36:34','userName=LiMing&password=','0:0:0:0:0:0:0:1','/login',10,'登录系统','info',22),(353,NULL,'GET','2018-10-24 16:36:34','_dc=1540370193878','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',22),(354,NULL,'GET','2018-10-24 16:36:37','_dc=1540370196752&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',22),(355,NULL,'POST','2018-10-24 16:36:54','_dc=1540370214188','0:0:0:0:0:0:0:1','/contract',6,'保存合同信息','info',22),(356,NULL,'GET','2018-10-24 16:36:54','_dc=1540370214274&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',22),(357,NULL,'POST','2018-10-24 16:36:56','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(358,NULL,'GET','2018-10-24 16:36:57','_dc=1540370217393&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(359,NULL,'GET','2018-10-24 16:36:57','_dc=1540370217390&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(360,NULL,'POST','2018-10-24 16:37:11','userName=WangSan&password=','0:0:0:0:0:0:0:1','/login',11,'登录系统','info',24),(361,NULL,'GET','2018-10-24 16:37:12','_dc=1540370231527','0:0:0:0:0:0:0:1','/attence/isAttence',1,'考勤操作','info',24),(362,NULL,'GET','2018-10-24 16:37:14','_dc=1540370233856&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',5,'查看合同信息','info',24),(363,NULL,'POST','2018-10-24 16:37:42','_dc=1540370262150','0:0:0:0:0:0:0:1','/contract',9,'保存合同信息','info',24),(364,NULL,'GET','2018-10-24 16:37:42','_dc=1540370262236&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',5,'查看合同信息','info',24),(365,NULL,'POST','2018-10-24 16:37:44','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(366,NULL,'GET','2018-10-24 16:37:46','_dc=1540370265864&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',5,'findAllStore','info',NULL),(367,NULL,'GET','2018-10-24 16:37:46','_dc=1540370265867&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',5,'findAllStore','info',NULL),(368,NULL,'POST','2018-10-24 16:38:02','userName=ZhangNan&password=','0:0:0:0:0:0:0:1','/login',7,'登录系统','info',26),(369,NULL,'GET','2018-10-24 16:38:02','_dc=1540370281923','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',26),(370,NULL,'GET','2018-10-24 16:38:08','_dc=1540370287762&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',26),(371,NULL,'POST','2018-10-24 16:38:27','_dc=1540370306669','0:0:0:0:0:0:0:1','/contract',10,'保存合同信息','info',26),(372,NULL,'GET','2018-10-24 16:38:27','_dc=1540370306763&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',26),(373,NULL,'POST','2018-10-24 16:38:30','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(374,NULL,'GET','2018-10-24 16:38:31','_dc=1540370311323&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(375,NULL,'GET','2018-10-24 16:38:31','_dc=1540370311326&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(376,NULL,'POST','2018-10-24 16:38:52','userName=WuYiTian&password=','0:0:0:0:0:0:0:1','/login',8,'登录系统','info',28),(377,NULL,'GET','2018-10-24 16:38:52','_dc=1540370332252','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',28),(378,NULL,'GET','2018-10-24 16:38:54','_dc=1540370334218&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',6,'查看合同信息','info',28),(379,NULL,'POST','2018-10-24 16:39:11','_dc=1540370350507','0:0:0:0:0:0:0:1','/contract',10,'保存合同信息','info',28),(380,NULL,'GET','2018-10-24 16:39:11','_dc=1540370350601&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',28),(381,NULL,'POST','2018-10-24 16:39:12','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(382,NULL,'GET','2018-10-24 16:39:14','_dc=1540370353544&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(383,NULL,'GET','2018-10-24 16:39:14','_dc=1540370353548&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(384,NULL,'POST','2018-10-24 16:39:36','userName=ZhangXiaoNan&password=','0:0:0:0:0:0:0:1','/login',7,'登录系统','info',30),(385,NULL,'GET','2018-10-24 16:39:36','_dc=1540370376006','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',30),(386,NULL,'GET','2018-10-24 16:39:38','_dc=1540370378484&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',30),(387,NULL,'POST','2018-10-24 16:39:57','_dc=1540370396623','0:0:0:0:0:0:0:1','/contract',12,'保存合同信息','info',30),(388,NULL,'GET','2018-10-24 16:39:57','_dc=1540370396699&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',19,'查看合同信息','info',30),(389,NULL,'POST','2018-10-24 16:39:58','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(390,NULL,'GET','2018-10-24 16:40:00','_dc=1540370399834&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(391,NULL,'GET','2018-10-24 16:40:00','_dc=1540370399831&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(392,NULL,'POST','2018-10-24 16:40:17','userName=WuXiaoTian&password=','0:0:0:0:0:0:0:1','/login',14,'登录系统','info',32),(393,NULL,'GET','2018-10-24 16:40:17','_dc=1540370416965','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',32),(394,NULL,'GET','2018-10-24 16:40:19','_dc=1540370419088&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',32),(395,NULL,'POST','2018-10-24 16:40:57','_dc=1540370456507','0:0:0:0:0:0:0:1','/contract',9,'保存合同信息','info',32),(396,NULL,'GET','2018-10-24 16:40:57','_dc=1540370456606&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',7,'查看合同信息','info',32),(397,NULL,'POST','2018-10-24 16:41:05','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(398,NULL,'GET','2018-10-24 16:41:07','_dc=1540370466948&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(399,NULL,'GET','2018-10-24 16:41:07','_dc=1540370466945&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(400,NULL,'POST','2018-10-24 16:41:47','userName=LiuXiaoNan&password=','0:0:0:0:0:0:0:1','/login',14,'登录系统','info',34),(401,NULL,'GET','2018-10-24 16:41:47','_dc=1540370507125','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',34),(402,NULL,'GET','2018-10-24 16:41:50','_dc=1540370509756&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',34),(403,NULL,'POST','2018-10-24 16:42:09','_dc=1540370528719','0:0:0:0:0:0:0:1','/contract',7,'保存合同信息','info',34),(404,NULL,'GET','2018-10-24 16:42:09','_dc=1540370528801&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',34),(405,NULL,'POST','2018-10-24 16:42:11','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(406,NULL,'GET','2018-10-24 16:42:13','_dc=1540370532500&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(407,NULL,'GET','2018-10-24 16:42:13','_dc=1540370532503&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(408,NULL,'POST','2018-10-24 16:42:26','userName=WuXiaoXiao&password=','0:0:0:0:0:0:0:1','/login',12,'登录系统','info',36),(409,NULL,'GET','2018-10-24 16:42:26','_dc=1540370545864','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',36),(410,NULL,'GET','2018-10-24 16:42:34','_dc=1540370554060&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',36),(411,NULL,'POST','2018-10-24 16:42:59','_dc=1540370578850','0:0:0:0:0:0:0:1','/contract',21,'保存合同信息','info',36),(412,NULL,'GET','2018-10-24 16:42:59','_dc=1540370578945&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',16,'查看合同信息','info',36),(413,NULL,'POST','2018-10-24 16:43:00','','0:0:0:0:0:0:0:1','/logout',1,'退出登录','info',NULL),(414,NULL,'GET','2018-10-24 16:43:02','_dc=1540370581926&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(415,NULL,'GET','2018-10-24 16:43:02','_dc=1540370581922&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',3,'findAllStore','info',NULL),(416,NULL,'POST','2018-10-24 16:43:21','userName=LiMingMing&password=','0:0:0:0:0:0:0:1','/login',13,'登录系统','info',38),(417,NULL,'GET','2018-10-24 16:43:21','_dc=1540370600896','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',38),(418,NULL,'GET','2018-10-24 16:43:25','_dc=1540370604495&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',38),(419,NULL,'POST','2018-10-24 16:43:44','_dc=1540370624146','0:0:0:0:0:0:0:1','/contract',7,'保存合同信息','info',38),(420,NULL,'GET','2018-10-24 16:43:44','_dc=1540370624241&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',38),(421,NULL,'POST','2018-10-24 16:43:46','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(422,NULL,'GET','2018-10-24 16:43:48','_dc=1540370627633&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(423,NULL,'GET','2018-10-24 16:43:48','_dc=1540370627636&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(424,NULL,'POST','2018-10-24 16:44:09','userName=WangSanSan&password=','0:0:0:0:0:0:0:1','/login',12,'登录系统','info',40),(425,NULL,'GET','2018-10-24 16:44:09','_dc=1540370648730','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',40),(426,NULL,'GET','2018-10-24 16:44:13','_dc=1540370652859&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',6,'查看合同信息','info',40),(427,NULL,'POST','2018-10-24 16:44:30','_dc=1540370669488','0:0:0:0:0:0:0:1','/contract',9,'保存合同信息','info',40),(428,NULL,'GET','2018-10-24 16:44:30','_dc=1540370669572&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',11,'查看合同信息','info',40),(429,NULL,'POST','2018-10-24 16:44:33','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(430,NULL,'GET','2018-10-24 16:44:34','_dc=1540370674450&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(431,NULL,'GET','2018-10-24 16:44:34','_dc=1540370674447&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(432,NULL,'POST','2018-10-24 16:44:55','userName=LiuNanNan&password=','0:0:0:0:0:0:0:1','/login',13,'登录系统','info',42),(433,NULL,'GET','2018-10-24 16:44:55','_dc=1540370694880','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',42),(434,NULL,'GET','2018-10-24 16:45:02','_dc=1540370701722&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',42),(435,NULL,'POST','2018-10-24 16:45:18','_dc=1540370717920','0:0:0:0:0:0:0:1','/contract',8,'保存合同信息','info',42),(436,NULL,'GET','2018-10-24 16:45:18','_dc=1540370718012&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',42),(437,NULL,'POST','2018-10-24 16:45:21','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(438,NULL,'GET','2018-10-24 16:45:23','_dc=1540370722854&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(439,NULL,'GET','2018-10-24 16:45:23','_dc=1540370722857&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(440,NULL,'POST','2018-10-24 16:45:39','userName=WuGang&password=','0:0:0:0:0:0:0:1','/login',8,'登录系统','info',44),(441,NULL,'GET','2018-10-24 16:45:39','_dc=1540370738855','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',44),(442,NULL,'GET','2018-10-24 16:45:41','_dc=1540370741326&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',8,'查看合同信息','info',44),(443,NULL,'POST','2018-10-24 16:45:59','_dc=1540370759177','0:0:0:0:0:0:0:1','/contract',10,'保存合同信息','info',44),(444,NULL,'GET','2018-10-24 16:45:59','_dc=1540370759282&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',11,'查看合同信息','info',44),(445,NULL,'POST','2018-10-24 16:46:00','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(446,NULL,'GET','2018-10-24 16:46:02','_dc=1540370762081&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(447,NULL,'GET','2018-10-24 16:46:02','_dc=1540370762078&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',1,'findAllStore','info',NULL),(448,NULL,'POST','2018-10-24 16:46:17','userName=ZhangNanNan&password=','0:0:0:0:0:0:0:1','/login',13,'登录系统','info',46),(449,NULL,'GET','2018-10-24 16:46:17','_dc=1540370777359','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',46),(450,NULL,'GET','2018-10-24 16:46:19','_dc=1540370779295&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',46),(451,NULL,'POST','2018-10-24 16:46:45','_dc=1540370804600','0:0:0:0:0:0:0:1','/contract',10,'保存合同信息','info',46),(452,NULL,'GET','2018-10-24 16:46:45','_dc=1540370804697&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',46),(453,NULL,'POST','2018-10-24 16:46:46','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(454,NULL,'GET','2018-10-24 16:46:47','_dc=1540370807451&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(455,NULL,'GET','2018-10-24 16:46:47','_dc=1540370807454&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',3,'findAllStore','info',NULL),(456,NULL,'POST','2018-10-24 16:47:06','userName=CaiGang&password=','0:0:0:0:0:0:0:1','/login',8,'登录系统','info',48),(457,NULL,'GET','2018-10-24 16:47:06','_dc=1540370825955','0:0:0:0:0:0:0:1','/attence/isAttence',1,'考勤操作','info',48),(458,NULL,'GET','2018-10-24 16:47:08','_dc=1540370827891&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',9,'查看合同信息','info',48),(459,NULL,'POST','2018-10-24 16:47:27','_dc=1540370847295','0:0:0:0:0:0:0:1','/contract',10,'保存合同信息','info',48),(460,NULL,'GET','2018-10-24 16:47:27','_dc=1540370847387&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',10,'查看合同信息','info',48),(461,NULL,'POST','2018-10-24 16:47:29','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(462,NULL,'GET','2018-10-24 16:47:31','_dc=1540370850590&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(463,NULL,'GET','2018-10-24 16:47:31','_dc=1540370850592&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(464,NULL,'POST','2018-10-24 16:47:43','userName=YiTian&password=','0:0:0:0:0:0:0:1','/login',8,'登录系统','info',50),(465,NULL,'GET','2018-10-24 16:47:43','_dc=1540370862635','0:0:0:0:0:0:0:1','/attence/isAttence',1,'考勤操作','info',50),(466,NULL,'GET','2018-10-24 16:47:45','_dc=1540370864533&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',11,'查看合同信息','info',50),(467,NULL,'POST','2018-10-24 16:49:05','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(468,NULL,'GET','2018-10-24 16:49:07','_dc=1540370946716&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(469,NULL,'GET','2018-10-24 16:49:07','_dc=1540370946713&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(470,NULL,'POST','2018-10-24 16:49:19','userName=YiGang&password=','0:0:0:0:0:0:0:1','/login',7,'登录系统','info',52),(471,NULL,'GET','2018-10-24 16:49:19','_dc=1540370959058','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',52),(472,NULL,'GET','2018-10-24 16:49:21','_dc=1540370961203&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',11,'查看合同信息','info',52),(473,NULL,'POST','2018-10-24 16:49:44','_dc=1540370984038','0:0:0:0:0:0:0:1','/contract',20,'保存合同信息','info',52),(474,NULL,'GET','2018-10-24 16:49:44','_dc=1540370984131&page=1&start=0&limit=20&group={\"property\":\"day\",\"direction\":\"ASC\"}&sort=id&dir=ASC','0:0:0:0:0:0:0:1','/contract',16,'查看合同信息','info',52),(475,NULL,'POST','2018-10-24 16:49:47','','0:0:0:0:0:0:0:1','/logout',1,'退出登录','info',NULL),(476,NULL,'GET','2018-10-24 16:49:49','_dc=1540370988524&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(477,NULL,'GET','2018-10-24 16:49:49','_dc=1540370988528&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',19,'findAllStore','info',NULL),(478,NULL,'POST','2018-10-24 16:53:39','userName=admin&password=','0:0:0:0:0:0:0:1','/login',48,'登录系统','info',NULL),(479,NULL,'POST','2018-10-24 16:53:43','userName=admin&password=','0:0:0:0:0:0:0:1','/login',31,'登录系统','info',1),(480,NULL,'GET','2018-10-24 16:53:43','_dc=1540371223332','0:0:0:0:0:0:0:1','/attence/isAttence',3,'考勤操作','info',1),(481,NULL,'GET','2018-10-24 16:53:46','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(482,NULL,'GET','2018-10-24 16:53:46','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(483,NULL,'GET','2018-10-24 17:01:23','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(484,NULL,'GET','2018-10-24 17:01:23','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(485,NULL,'GET','2018-10-24 17:03:08','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(486,NULL,'GET','2018-10-24 17:03:08','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(487,NULL,'GET','2018-10-24 17:04:03','','0:0:0:0:0:0:0:1','/user/current',0,'权限限制','info',1),(488,NULL,'GET','2018-10-24 17:04:03','','0:0:0:0:0:0:0:1','/group/current',0,'权限限制','info',1),(489,NULL,'GET','2018-10-24 17:05:35','_dc=1540371935351&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',21,'业绩排行','info',1),(490,NULL,'GET','2018-10-24 17:05:35','_dc=1540371935348&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',21,'数据分析','info',1),(491,NULL,'GET','2018-10-24 17:05:35','_dc=1540371935354&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',53,'findAllStore','info',1),(492,NULL,'GET','2018-10-24 17:05:35','_dc=1540371935345&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',93,'查询销售员月销售额','info',1),(493,NULL,'POST','2018-10-24 17:05:38','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(494,NULL,'GET','2018-10-24 17:05:40','_dc=1540371940174&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(495,NULL,'GET','2018-10-24 17:05:40','_dc=1540371940170&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(496,NULL,'POST','2018-10-24 17:05:44','userName=admin&password=','0:0:0:0:0:0:0:1','/login',32,'登录系统','info',1),(497,NULL,'GET','2018-10-24 17:05:44','_dc=1540371944429','0:0:0:0:0:0:0:1','/attence/isAttence',2,'考勤操作','info',1),(498,NULL,'GET','2018-10-24 17:05:48','_dc=1540371948187&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',10,'数据分析','info',1),(499,NULL,'GET','2018-10-24 17:05:48','_dc=1540371948184&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',10,'查询销售员月销售额','info',1),(500,NULL,'GET','2018-10-24 17:05:48','_dc=1540371948189&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',1),(501,NULL,'GET','2018-10-24 17:05:48','_dc=1540371948188&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',6,'业绩排行','info',1),(502,NULL,'GET','2018-10-24 17:05:55','_dc=1540371954649&month=一月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',4,'查询销售员月销售额','info',1),(503,NULL,'GET','2018-10-24 17:05:55','_dc=1540371954666&month=一月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',4,'数据分析','info',1),(504,NULL,'GET','2018-10-24 17:05:55','_dc=1540371954679&month=一月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',4,'业绩排行','info',1),(505,NULL,'GET','2018-10-24 17:06:05','_dc=1540371964760&month=二月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',3,'查询销售员月销售额','info',1),(506,NULL,'GET','2018-10-24 17:06:05','_dc=1540371964776&month=二月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',3,'数据分析','info',1),(507,NULL,'GET','2018-10-24 17:06:05','_dc=1540371964787&month=二月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',3,'业绩排行','info',1),(508,NULL,'GET','2018-10-24 17:06:07','_dc=1540371966501&month=三月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',5,'查询销售员月销售额','info',1),(509,NULL,'GET','2018-10-24 17:06:07','_dc=1540371966517&month=三月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',5,'数据分析','info',1),(510,NULL,'GET','2018-10-24 17:06:07','_dc=1540371966538&month=三月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',4,'业绩排行','info',1),(511,NULL,'GET','2018-10-24 17:06:08','_dc=1540371968165&month=四月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',5,'查询销售员月销售额','info',1),(512,NULL,'GET','2018-10-24 17:06:08','_dc=1540371968180&month=四月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',5,'数据分析','info',1),(513,NULL,'GET','2018-10-24 17:06:08','_dc=1540371968204&month=四月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',2,'业绩排行','info',1),(514,NULL,'GET','2018-10-24 17:06:10','_dc=1540371969910&month=九月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',6,'查询销售员月销售额','info',1),(515,NULL,'GET','2018-10-24 17:06:10','_dc=1540371969927&month=九月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',3,'数据分析','info',1),(516,NULL,'GET','2018-10-24 17:06:10','_dc=1540371969953&month=九月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',4,'业绩排行','info',1),(517,NULL,'GET','2018-10-24 17:06:12','_dc=1540371972152&month=十一月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',5,'查询销售员月销售额','info',1),(518,NULL,'GET','2018-10-24 17:06:12','_dc=1540371972169&month=十一月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',6,'数据分析','info',1),(519,NULL,'GET','2018-10-24 17:06:12','_dc=1540371972193&month=十一月&area=家乐房产中介东莞市分店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',3,'业绩排行','info',1),(520,NULL,'GET','2018-10-24 17:06:42','_dc=1540372001653&month=十一月&area=家乐房产中介广东总店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement',5,'查询销售员月销售额','info',1),(521,NULL,'GET','2018-10-24 17:06:42','_dc=1540372001671&month=十一月&area=家乐房产中介广东总店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/analyse',3,'数据分析','info',1),(522,NULL,'GET','2018-10-24 17:06:42','_dc=1540372001686&month=十一月&area=家乐房产中介广东总店&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/achievement/sort',5,'业绩排行','info',1),(523,NULL,'POST','2018-10-24 17:06:47','','0:0:0:0:0:0:0:1','/logout',0,'退出登录','info',NULL),(524,NULL,'GET','2018-10-24 17:06:49','_dc=1540372009150&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL),(525,NULL,'GET','2018-10-24 17:06:49','_dc=1540372009147&page=1&start=0&limit=25','0:0:0:0:0:0:0:1','/store/findAllStore',2,'findAllStore','info',NULL);
/*!40000 ALTER TABLE `t_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_notice`
--

DROP TABLE IF EXISTS `t_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_notice`
--

LOCK TABLES `t_notice` WRITE;
/*!40000 ALTER TABLE `t_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_store`
--

DROP TABLE IF EXISTS `t_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `storeArea` varchar(255) COLLATE utf8_bin NOT NULL,
  `storeName` varchar(255) COLLATE utf8_bin NOT NULL,
  `storeNumber` varchar(255) COLLATE utf8_bin NOT NULL,
  `fatherStore_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_63906f5qdcomyyion7obl39xv` (`storeName`),
  UNIQUE KEY `UK_l5qphaerxi6h66himo16k1yun` (`storeNumber`),
  KEY `FKs7uwcjl96bio2f438m5hkbslx` (`fatherStore_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_store`
--

LOCK TABLES `t_store` WRITE;
/*!40000 ALTER TABLE `t_store` DISABLE KEYS */;
INSERT INTO `t_store` VALUES (1,'广东省','家乐房产中介广东总店','GD001',NULL),(2,'广东省东莞市','家乐房产中介东莞市分店','DG001',1),(3,'广东省东莞市','家乐房产中介东莞市莞城分店','DG0011',2),(4,'广东省东莞市','家乐房产中介东莞市东城分店','DG0012',2),(5,'广东省东莞市','家乐房产中介东莞市南城分店','DG0013',2),(6,'广东省广州市','家乐房产中介广州市分店','GZ001',1),(7,'广东省广州市','家乐房产中介广州市天河区分店','GZ0011',6),(8,'广东省广州市','家乐房产中介广州市荔湾区分店','GZ0012',6),(9,'广东省广州市','家乐房产中介广州市越秀区分店','GZ0013',6),(10,'广东省深圳市','家乐房产中介深圳市分店','SZ001',1),(11,'广东省深圳市','家乐房产中介深圳市南山区分店','SZ0011',10),(12,'广东省深圳市','家乐房产中介深圳市宝安区分店','SZ0012',10),(13,'广东省深圳市','家乐房产中介深圳市福田区分店','SZ0013',10);
/*!40000 ALTER TABLE `t_store` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-24 17:09:22

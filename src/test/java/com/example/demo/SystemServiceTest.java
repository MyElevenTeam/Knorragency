package com.example.demo;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.demo.common.utils.MD5;
import com.example.demo.employee.domain.Employee;
import com.example.demo.store.domain.Store;
import com.example.demo.store.service.IStoreService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SystemServiceTest {
	
	@Autowired
	private IStoreService storeService;
	
	@Autowired
	private IdentityService identityService;
	
	@Test
	public void InitDB() {
		
		Group admin =identityService.newGroup("admin"); 
		admin.setType("security-role");
		admin.setName("管理员");
		identityService.saveGroup(admin);
		
		Group generalManager =identityService.newGroup("generalManager"); 
		generalManager.setName("总经理");
		identityService.saveGroup(generalManager);
		
		Group hrManager =identityService.newGroup("hrManager"); 
		hrManager.setName("人事经理");
		identityService.saveGroup(hrManager);
		
		Group areaManager =identityService.newGroup("areaManager"); 
		areaManager.setName("分区经理");
		identityService.saveGroup(areaManager);
		
		Group areahrManager =identityService.newGroup("areahrManager"); 
		areahrManager.setName("分区人事经理");
		identityService.saveGroup(areahrManager);
		
		Group storeManager =identityService.newGroup("storeManager"); 
		storeManager.setName("店长");
		identityService.saveGroup(storeManager);
		
		Group hr =identityService.newGroup("hr"); 
		hr.setName("人事专员");
		identityService.saveGroup(hr);
		
		Group employee =identityService.newGroup("employee"); 
		employee.setName("房产经纪人");
		identityService.saveGroup(employee);
		
		
		
		Store fatherStore=new Store();
    	fatherStore.setStoreArea("广东省");
    	fatherStore.setStoreName("家乐房产中介广东总店");
    	fatherStore.setStoreNumber("GD001");
    	
    	//广东总店员工
    	//管理员admin
    	Employee e1=new Employee();
    	e1.setEmployeeName("admin");
    	e1.setEmployeeNumber("admin");
    	e1.setPassword(MD5.getMD5("admin"));
    	e1.setLocalStore(fatherStore);
    	e1.setPost("admin");
		
		User user1 = identityService.newUser("admin");
		user1.setPassword(MD5.getMD5("admin"));
		identityService.saveUser(user1);
		identityService.createMembership("admin", "admin");
		
		//总经理王军
		Employee e2=new Employee();
		e2.setEmployeeName("WangJun");
		e2.setEmployeeNumber("WangJun");
		e2.setPassword(MD5.getMD5("WangJun"));
		e2.setLocalStore(fatherStore);
		e2.setPost("总经理");
		
		User user2 = identityService.newUser("WangJun");
		user2.setPassword(MD5.getMD5("WangJun"));
		identityService.saveUser(user2);
		identityService.createMembership("WangJun", "generalManager");
		
		//人事经理
		Employee e3=new Employee();
		e3.setEmployeeName("GuLi");
		e3.setEmployeeNumber("GuLi");
		e3.setPassword(MD5.getMD5("GuLi"));
		e3.setLocalStore(fatherStore);
		e3.setPost("人事经理");
		
		User user3 = identityService.newUser("GuLi");
		user3.setPassword(MD5.getMD5("GuLi"));
		identityService.saveUser(user3);
		identityService.createMembership("GuLi", "hrManager");
		
		//房产经纪人
		Employee e4=new Employee();
		e4.setEmployeeName("LiSi");
		e4.setEmployeeNumber("LiSi");
		e4.setPassword(MD5.getMD5("LiSi"));
		e4.setLocalStore(fatherStore);
		e4.setPost("房产经纪人");
		
		User user4 = identityService.newUser("LiSi");
		user4.setPassword(MD5.getMD5("LiSi"));
		identityService.saveUser(user4);
		identityService.createMembership("LiSi", "employee");
		
    	fatherStore.getEmployeeList().add(e1);
    	fatherStore.getEmployeeList().add(e2);
    	fatherStore.getEmployeeList().add(e3);
    	fatherStore.getEmployeeList().add(e4);
    	
    	e1.setLocalStore(fatherStore);
    	e2.setLocalStore(fatherStore);
    	e3.setLocalStore(fatherStore);
    	e4.setLocalStore(fatherStore);
		
    	
    	
    	Store DGStore=new Store();
    	DGStore.setStoreArea("广东省东莞市");
    	DGStore.setStoreName("家乐房产中介东莞市分店");
    	DGStore.setStoreNumber("DG001");
    	
    	//分区经理
		Employee e5=new Employee();
		e5.setEmployeeName("XuanMing");
		e5.setEmployeeNumber("XuanMing");
		e5.setPassword(MD5.getMD5("XuanMing"));
		e5.setLocalStore(DGStore);
		e5.setPost("分区经理");
		
		User user5 = identityService.newUser("XuanMing");
		user5.setPassword(MD5.getMD5("XuanMing"));
		identityService.saveUser(user5);
		identityService.createMembership("XuanMing", "areaManager");
		
		//分区人事经理
		Employee e6=new Employee();
		e6.setEmployeeName("LinGang");
		e6.setEmployeeNumber("LinGang");
		e6.setPassword(MD5.getMD5("LinGang"));
		e6.setLocalStore(DGStore);
		e6.setPost("分区人事经理");
		
		User user6 = identityService.newUser("LinGang");
		user6.setPassword(MD5.getMD5("LinGang"));
		identityService.saveUser(user6);
		identityService.createMembership("LinGang", "areahrManager");
		
		//房产经纪人
		Employee e7=new Employee();
		e7.setEmployeeName("ZhangSan");
		e7.setEmployeeNumber("ZhangSan");
		e7.setPassword(MD5.getMD5("ZhangSan"));
		e7.setLocalStore(DGStore);
		e7.setPost("房产经纪人");
		
		User user7 = identityService.newUser("ZhangSan");
		user7.setPassword(MD5.getMD5("ZhangSan"));
		identityService.saveUser(user7);
		identityService.createMembership("ZhangSan", "employee");
		
		DGStore.getEmployeeList().add(e5);
		DGStore.getEmployeeList().add(e6);
		DGStore.getEmployeeList().add(e7);
    	
    	e5.setLocalStore(DGStore);
    	e6.setLocalStore(DGStore);
    	e7.setLocalStore(DGStore);

    	
    	Store DGStore1=new Store();
    	DGStore1.setStoreArea("广东省东莞市");
    	DGStore1.setStoreName("家乐房产中介东莞市莞城分店");
    	DGStore1.setStoreNumber("DG0011");
    	
    	//店长
		Employee e8=new Employee();
		e8.setEmployeeName("LiJun");
		e8.setEmployeeNumber("LiJun");
		e8.setPassword(MD5.getMD5("LiJun"));
		e8.setLocalStore(DGStore1);
		e8.setPost("店长");
		
		User user8 = identityService.newUser("LiJun");
		user8.setPassword(MD5.getMD5("LiJun"));
		identityService.saveUser(user8);
		identityService.createMembership("LiJun", "storeManager");
		
		//人事专员
		Employee e9=new Employee();
		e9.setEmployeeName("LinXiao");
		e9.setEmployeeNumber("LinXiao");
		e9.setPassword(MD5.getMD5("LinXiao"));
		e9.setLocalStore(DGStore1);
		e9.setPost("人事专员");
		
		User user9 = identityService.newUser("LinXiao");
		user9.setPassword(MD5.getMD5("LinXiao"));
		identityService.saveUser(user9);
		identityService.createMembership("LinXiao", "hr");
		
		//房产经纪人
		Employee e10=new Employee();
		e10.setEmployeeName("WangWu");
		e10.setEmployeeNumber("WangWu");
		e10.setPassword(MD5.getMD5("WangWu"));
		e10.setLocalStore(DGStore1);
		e10.setPost("房产经纪人");
		
		User user10 = identityService.newUser("WangWu");
		user10.setPassword(MD5.getMD5("WangWu"));
		identityService.saveUser(user10);
		identityService.createMembership("WangWu", "employee");
		
		DGStore1.getEmployeeList().add(e8);
		DGStore1.getEmployeeList().add(e9);
		DGStore1.getEmployeeList().add(e10);
    	
    	e8.setLocalStore(DGStore1);
    	e9.setLocalStore(DGStore1);
    	e10.setLocalStore(DGStore1);
    	
    	
    	Store DGStore2=new Store();
    	DGStore2.setStoreArea("广东省东莞市");
    	DGStore2.setStoreName("家乐房产中介东莞市东城分店");
    	DGStore2.setStoreNumber("DG0012");
    	
    	//店长
		Employee e11=new Employee();
		e11.setEmployeeName("LiYa");
		e11.setEmployeeNumber("LiYa");
		e11.setPassword(MD5.getMD5("LiYa"));
		e11.setLocalStore(DGStore2);
		e11.setPost("店长");
		
		User user11 = identityService.newUser("LiYa");
		user11.setPassword(MD5.getMD5("LiYa"));
		identityService.saveUser(user11);
		identityService.createMembership("LiYa", "storeManager");
		
		//人事专员
		Employee e12=new Employee();
		e12.setEmployeeName("LinTian");
		e12.setEmployeeNumber("LinTian");
		e12.setPassword(MD5.getMD5("LinTian"));
		e12.setLocalStore(DGStore2);
		e12.setPost("人事专员");
		
		User user12 = identityService.newUser("LinTian");
		user12.setPassword(MD5.getMD5("LinTian"));
		identityService.saveUser(user12);
		identityService.createMembership("LinTian", "hr");
		
		//房产经纪人
		Employee e13=new Employee();
		e13.setEmployeeName("WuLu");
		e13.setEmployeeNumber("WuLu");
		e13.setPassword(MD5.getMD5("WuLu"));
		e13.setLocalStore(DGStore2);
		e13.setPost("房产经纪人");
		
		User user13 = identityService.newUser("WuLu");
		user13.setPassword(MD5.getMD5("WuLu"));
		identityService.saveUser(user13);
		identityService.createMembership("WuLu", "employee");
		
		DGStore2.getEmployeeList().add(e11);
		DGStore2.getEmployeeList().add(e12);
		DGStore2.getEmployeeList().add(e13);
    	
		e11.setLocalStore(DGStore2);
    	e12.setLocalStore(DGStore2);
    	e13.setLocalStore(DGStore2);
    	
    	
    	Store DGStore3=new Store();
    	DGStore3.setStoreArea("广东省东莞市");
    	DGStore3.setStoreName("家乐房产中介东莞市南城分店");
    	DGStore3.setStoreNumber("DG0013");
    	
    	//店长
		Employee e14=new Employee();
		e14.setEmployeeName("LiNan");
		e14.setEmployeeNumber("LiNan");
		e14.setPassword(MD5.getMD5("LiNan"));
		e14.setLocalStore(DGStore3);
		e14.setPost("店长");
		
		User user14 = identityService.newUser("LiNan");
		user14.setPassword(MD5.getMD5("LiNan"));
		identityService.saveUser(user14);
		identityService.createMembership("LiNan", "storeManager");
		
		//人事专员
		Employee e15=new Employee();
		e15.setEmployeeName("LinJie");
		e15.setEmployeeNumber("LinJie");
		e15.setPassword(MD5.getMD5("LinJie"));
		e15.setLocalStore(DGStore3);
		e15.setPost("人事专员");
		
		User user15 = identityService.newUser("LinJie");
		user15.setPassword(MD5.getMD5("LinJie"));
		identityService.saveUser(user15);
		identityService.createMembership("LinJie", "hr");
		
		//房产经纪人
		Employee e16=new Employee();
		e16.setEmployeeName("WuTian");
		e16.setEmployeeNumber("WuTian");
		e16.setPassword(MD5.getMD5("WuTian"));
		e16.setLocalStore(DGStore3);
		e16.setPost("房产经纪人");
		
		User user16 = identityService.newUser("WuTian");
		user16.setPassword(MD5.getMD5("WuTian"));
		identityService.saveUser(user16);
		identityService.createMembership("WuTian", "employee");
		
		DGStore3.getEmployeeList().add(e14);
		DGStore3.getEmployeeList().add(e15);
		DGStore3.getEmployeeList().add(e16);
    	
		e14.setLocalStore(DGStore3);
    	e15.setLocalStore(DGStore3);
    	e16.setLocalStore(DGStore3);
    	
    	
    	Store GZStore=new Store();
    	GZStore.setStoreArea("广东省广州市");
    	GZStore.setStoreName("家乐房产中介广州市分店");
    	GZStore.setStoreNumber("GZ001");
    	
    	//分区经理
		Employee e17=new Employee();
		e17.setEmployeeName("LiMing");
		e17.setEmployeeNumber("LiMing");
		e17.setPassword(MD5.getMD5("LiMing"));
		e17.setLocalStore(GZStore);
		e17.setPost("分区经理");
		
		User user17 = identityService.newUser("LiMing");
		user17.setPassword(MD5.getMD5("LiMing"));
		identityService.saveUser(user17);
		identityService.createMembership("LiMing", "areaManager");
		
		//分区人事经理
		Employee e18=new Employee();
		e18.setEmployeeName("LinLi");
		e18.setEmployeeNumber("LinLi");
		e18.setPassword(MD5.getMD5("LinLi"));
		e18.setLocalStore(GZStore);
		e18.setPost("分区人事经理");
		
		User user18 = identityService.newUser("LinLi");
		user18.setPassword(MD5.getMD5("LinLi"));
		identityService.saveUser(user18);
		identityService.createMembership("LinLi", "areahrManager");
		
		//房产经纪人
		Employee e19=new Employee();
		e19.setEmployeeName("WangSan");
		e19.setEmployeeNumber("WangSan");
		e19.setPassword(MD5.getMD5("WangSan"));
		e19.setLocalStore(GZStore);
		e19.setPost("房产经纪人");
		
		User user19 = identityService.newUser("WangSan");
		user19.setPassword(MD5.getMD5("WangSan"));
		identityService.saveUser(user19);
		identityService.createMembership("WangSan", "employee");
		
		GZStore.getEmployeeList().add(e17);
		GZStore.getEmployeeList().add(e18);
		GZStore.getEmployeeList().add(e19);
    	
    	e17.setLocalStore(GZStore);
    	e18.setLocalStore(GZStore);
    	e19.setLocalStore(GZStore);
    	
    	Store GZStore1=new Store();
    	GZStore1.setStoreArea("广东省广州市");
    	GZStore1.setStoreName("家乐房产中介广州市天河区分店");
    	GZStore1.setStoreNumber("GZ0011");
    	
    	//店长
		Employee e20=new Employee();
		e20.setEmployeeName("ZhangNan");
		e20.setEmployeeNumber("ZhangNan");
		e20.setPassword(MD5.getMD5("ZhangNan"));
		e20.setLocalStore(GZStore1);
		e20.setPost("店长");
		
		User user20 = identityService.newUser("ZhangNan");
		user20.setPassword(MD5.getMD5("ZhangNan"));
		identityService.saveUser(user20);
		identityService.createMembership("ZhangNan", "storeManager");
		
		//人事专员
		Employee e21=new Employee();
		e21.setEmployeeName("LinYiJie");
		e21.setEmployeeNumber("LinYiJie");
		e21.setPassword(MD5.getMD5("LinYiJie"));
		e21.setLocalStore(GZStore1);
		e21.setPost("人事专员");
		
		User user21 = identityService.newUser("LinYiJie");
		user21.setPassword(MD5.getMD5("LinYiJie"));
		identityService.saveUser(user21);
		identityService.createMembership("LinYiJie", "hr");
		
		//房产经纪人
		Employee e22=new Employee();
		e22.setEmployeeName("WuYiTian");
		e22.setEmployeeNumber("WuYiTian");
		e22.setPassword(MD5.getMD5("WuYiTian"));
		e22.setLocalStore(GZStore1);
		e22.setPost("房产经纪人");
		
		User user22 = identityService.newUser("WuYiTian");
		user22.setPassword(MD5.getMD5("WuYiTian"));
		identityService.saveUser(user22);
		identityService.createMembership("WuYiTian", "employee");
		
		GZStore1.getEmployeeList().add(e20);
		GZStore1.getEmployeeList().add(e21);
		GZStore1.getEmployeeList().add(e22);
    	
		e20.setLocalStore(GZStore1);
    	e21.setLocalStore(GZStore1);
    	e22.setLocalStore(GZStore1);
    	
    	
    	Store GZStore2=new Store();
    	GZStore2.setStoreArea("广东省广州市");
    	GZStore2.setStoreName("家乐房产中介广州市荔湾区分店");
    	GZStore2.setStoreNumber("GZ0012");
    	
    	//店长
		Employee e23=new Employee();
		e23.setEmployeeName("ZhangXiaoNan");
		e23.setEmployeeNumber("ZhangXiaoNan");
		e23.setPassword(MD5.getMD5("ZhangXiaoNan"));
		e23.setLocalStore(GZStore2);
		e23.setPost("店长");
		
		User user23 = identityService.newUser("ZhangXiaoNan");
		user23.setPassword(MD5.getMD5("ZhangXiaoNan"));
		identityService.saveUser(user23);
		identityService.createMembership("ZhangXiaoNan", "storeManager");
		
		//人事专员
		Employee e24=new Employee();
		e24.setEmployeeName("LinXiaoJie");
		e24.setEmployeeNumber("LinXiaoJie");
		e24.setPassword(MD5.getMD5("LinXiaoJie"));
		e24.setLocalStore(GZStore2);
		e24.setPost("人事专员");
		
		User user24 = identityService.newUser("LinXiaoJie");
		user24.setPassword(MD5.getMD5("LinXiaoJie"));
		identityService.saveUser(user24);
		identityService.createMembership("LinXiaoJie", "hr");
		
		//房产经纪人
		Employee e25=new Employee();
		e25.setEmployeeName("WuXiaoTian");
		e25.setEmployeeNumber("WuXiaoTian");
		e25.setPassword(MD5.getMD5("WuXiaoTian"));
		e25.setLocalStore(GZStore2);
		e25.setPost("房产经纪人");
		
		User user25 = identityService.newUser("WuXiaoTian");
		user25.setPassword(MD5.getMD5("WuXiaoTian"));
		identityService.saveUser(user25);
		identityService.createMembership("WuXiaoTian", "employee");
		
		GZStore2.getEmployeeList().add(e23);
		GZStore2.getEmployeeList().add(e24);
		GZStore2.getEmployeeList().add(e25);
    	
		e23.setLocalStore(GZStore2);
    	e24.setLocalStore(GZStore2);
    	e25.setLocalStore(GZStore2);
    	
    	
    	Store GZStore3=new Store();
    	GZStore3.setStoreArea("广东省广州市");
    	GZStore3.setStoreName("家乐房产中介广州市越秀区分店");
    	GZStore3.setStoreNumber("GZ0013");
    	
    	
    	//店长
		Employee e26=new Employee();
		e26.setEmployeeName("LiuXiaoNan");
		e26.setEmployeeNumber("LiuXiaoNan");
		e26.setPassword(MD5.getMD5("LiuXiaoNan"));
		e26.setLocalStore(GZStore3);
		e26.setPost("店长");
		
		User user26 = identityService.newUser("LiuXiaoNan");
		user26.setPassword(MD5.getMD5("LiuXiaoNan"));
		identityService.saveUser(user26);
		identityService.createMembership("LiuXiaoNan", "storeManager");
		
		//人事专员
		Employee e27=new Employee();
		e27.setEmployeeName("LiuXiaoJie");
		e27.setEmployeeNumber("LiuXiaoJie");
		e27.setPassword(MD5.getMD5("LiuXiaoJie"));
		e27.setLocalStore(GZStore3);
		e27.setPost("人事专员");
		
		User user27 = identityService.newUser("LiuXiaoJie");
		user27.setPassword(MD5.getMD5("LiuXiaoJie"));
		identityService.saveUser(user27);
		identityService.createMembership("LiuXiaoJie", "hr");
		
		//房产经纪人
		Employee e28=new Employee();
		e28.setEmployeeName("WuXiaoXiao");
		e28.setEmployeeNumber("WuXiaoXiao");
		e28.setPassword(MD5.getMD5("WuXiaoXiao"));
		e28.setLocalStore(GZStore3);
		e28.setPost("房产经纪人");
		
		User user28 = identityService.newUser("WuXiaoXiao");
		user28.setPassword(MD5.getMD5("WuXiaoXiao"));
		identityService.saveUser(user28);
		identityService.createMembership("WuXiaoXiao", "employee");
		
		GZStore3.getEmployeeList().add(e26);
		GZStore3.getEmployeeList().add(e27);
		GZStore3.getEmployeeList().add(e28);
    	
		e26.setLocalStore(GZStore3);
    	e27.setLocalStore(GZStore3);
    	e28.setLocalStore(GZStore3);
    	
    	Store SZStore=new Store();
    	SZStore.setStoreArea("广东省深圳市");
    	SZStore.setStoreName("家乐房产中介深圳市分店");
    	SZStore.setStoreNumber("SZ001");
    	
    	//分区经理
		Employee e29=new Employee();
		e29.setEmployeeName("LiMingMing");
		e29.setEmployeeNumber("LiMingMing");
		e29.setPassword(MD5.getMD5("LiMingMing"));
		e29.setLocalStore(SZStore);
		e29.setPost("分区经理");
		
		User user29 = identityService.newUser("LiMingMing");
		user29.setPassword(MD5.getMD5("LiMingMing"));
		identityService.saveUser(user29);
		identityService.createMembership("LiMingMing", "areaManager");
		
		//分区人事经理
		Employee e30=new Employee();
		e30.setEmployeeName("LinLiLi");
		e30.setEmployeeNumber("LinLiLi");
		e30.setPassword(MD5.getMD5("LinLiLi"));
		e30.setLocalStore(SZStore);
		e30.setPost("分区人事经理");
		
		User user30 = identityService.newUser("LinLiLi");
		user30.setPassword(MD5.getMD5("LinLiLi"));
		identityService.saveUser(user30);
		identityService.createMembership("LinLiLi", "areahrManager");
		
		//房产经纪人
		Employee e31=new Employee();
		e31.setEmployeeName("WangSanSan");
		e31.setEmployeeNumber("WangSanSan");
		e31.setPassword(MD5.getMD5("WangSanSan"));
		e31.setLocalStore(SZStore);
		e31.setPost("房产经纪人");
		
		User user31 = identityService.newUser("WangSanSan");
		user31.setPassword(MD5.getMD5("WangSanSan"));
		identityService.saveUser(user31);
		identityService.createMembership("WangSanSan", "employee");
		
		SZStore.getEmployeeList().add(e29);
		SZStore.getEmployeeList().add(e30);
		SZStore.getEmployeeList().add(e31);
    	
    	e29.setLocalStore(SZStore);
    	e30.setLocalStore(SZStore);
    	e31.setLocalStore(SZStore);
    	
    	Store SZStore1=new Store();
    	SZStore1.setStoreArea("广东省深圳市");
    	SZStore1.setStoreName("家乐房产中介深圳市南山区分店");
    	SZStore1.setStoreNumber("SZ0011");
    	
    	//店长
		Employee e32=new Employee();
		e32.setEmployeeName("LiuNanNan");
		e32.setEmployeeNumber("LiuNanNan");
		e32.setPassword(MD5.getMD5("LiuNanNan"));
		e32.setLocalStore(SZStore1);
		e32.setPost("店长");
		
		User user32 = identityService.newUser("LiuNanNan");
		user32.setPassword(MD5.getMD5("LiuNanNan"));
		identityService.saveUser(user32);
		identityService.createMembership("LiuNanNan", "storeManager");
		
		//人事专员
		Employee e33=new Employee();
		e33.setEmployeeName("LiuJieJie");
		e33.setEmployeeNumber("LiuJieJie");
		e33.setPassword(MD5.getMD5("LiuJieJie"));
		e33.setLocalStore(SZStore1);
		e33.setPost("人事专员");
		
		User user33 = identityService.newUser("LiuJieJie");
		user33.setPassword(MD5.getMD5("LiuJieJie"));
		identityService.saveUser(user33);
		identityService.createMembership("LiuJieJie", "hr");
		
		//房产经纪人
		Employee e34=new Employee();
		e34.setEmployeeName("WuGang");
		e34.setEmployeeNumber("WuGang");
		e34.setPassword(MD5.getMD5("WuGang"));
		e34.setLocalStore(SZStore1);
		e34.setPost("房产经纪人");
		
		User user34 = identityService.newUser("WuGang");
		user34.setPassword(MD5.getMD5("WuGang"));
		identityService.saveUser(user34);
		identityService.createMembership("WuGang", "employee");
		
		SZStore1.getEmployeeList().add(e32);
		SZStore1.getEmployeeList().add(e33);
		SZStore1.getEmployeeList().add(e34);
    	
		e32.setLocalStore(SZStore1);
    	e33.setLocalStore(SZStore1);
    	e34.setLocalStore(SZStore1);
    	
    	Store SZStore2=new Store();
    	SZStore2.setStoreArea("广东省深圳市");
    	SZStore2.setStoreName("家乐房产中介深圳市宝安区分店");
    	SZStore2.setStoreNumber("SZ0012");
    	
    	//店长
		Employee e35=new Employee();
		e35.setEmployeeName("ZhangNanNan");
		e35.setEmployeeNumber("ZhangNanNan");
		e35.setPassword(MD5.getMD5("ZhangNanNan"));
		e35.setLocalStore(SZStore2);
		e35.setPost("店长");
		
		User user36 = identityService.newUser("ZhangNanNan");
		user36.setPassword(MD5.getMD5("ZhangNanNan"));
		identityService.saveUser(user36);
		identityService.createMembership("ZhangNanNan", "storeManager");
		
		//人事专员
		Employee e37=new Employee();
		e37.setEmployeeName("CaiYi");
		e37.setEmployeeNumber("CaiYi");
		e37.setPassword(MD5.getMD5("CaiYi"));
		e37.setLocalStore(SZStore2);
		e37.setPost("人事专员");
		
		User user37 = identityService.newUser("CaiYi");
		user37.setPassword(MD5.getMD5("CaiYi"));
		identityService.saveUser(user37);
		identityService.createMembership("CaiYi", "hr");
		
		//房产经纪人
		Employee e38=new Employee();
		e38.setEmployeeName("CaiGang");
		e38.setEmployeeNumber("CaiGang");
		e38.setPassword(MD5.getMD5("CaiGang"));
		e38.setLocalStore(SZStore2);
		e38.setPost("房产经纪人");
		
		User user38 = identityService.newUser("CaiGang");
		user38.setPassword(MD5.getMD5("CaiGang"));
		identityService.saveUser(user38);
		identityService.createMembership("CaiGang", "employee");
		
		SZStore2.getEmployeeList().add(e35);
		SZStore2.getEmployeeList().add(e37);
		SZStore2.getEmployeeList().add(e38);
    	
		e35.setLocalStore(SZStore2);
    	e37.setLocalStore(SZStore2);
    	e38.setLocalStore(SZStore2);
    	
    	Store SZStore3=new Store();
    	SZStore3.setStoreArea("广东省深圳市");
    	SZStore3.setStoreName("家乐房产中介深圳市福田区分店");
    	SZStore3.setStoreNumber("SZ0013");
    	
    	//店长
		Employee e39=new Employee();
		e39.setEmployeeName("YiTian");
		e39.setEmployeeNumber("YiTian");
		e39.setPassword(MD5.getMD5("YiTian"));
		e39.setLocalStore(SZStore3);
		e39.setPost("店长");
		
		User user39 = identityService.newUser("YiTian");
		user39.setPassword(MD5.getMD5("YiTian"));
		identityService.saveUser(user39);
		identityService.createMembership("YiTian", "storeManager");
		
		//人事专员
		Employee e40=new Employee();
		e40.setEmployeeName("YiLai");
		e40.setEmployeeNumber("YiLai");
		e40.setPassword(MD5.getMD5("YiLai"));
		e40.setLocalStore(SZStore3);
		e40.setPost("人事专员");
		
		User user41 = identityService.newUser("YiLai");
		user41.setPassword(MD5.getMD5("YiLai"));
		identityService.saveUser(user41);
		identityService.createMembership("YiLai", "hr");
		
		//房产经纪人
		Employee e42=new Employee();
		e42.setEmployeeName("YiGang");
		e42.setEmployeeNumber("YiGang");
		e42.setPassword(MD5.getMD5("YiGang"));
		e42.setLocalStore(SZStore3);
		e42.setPost("房产经纪人");
		
		User user42 = identityService.newUser("YiGang");
		user42.setPassword(MD5.getMD5("YiGang"));
		identityService.saveUser(user42);
		identityService.createMembership("YiGang", "employee");
		
		SZStore3.getEmployeeList().add(e39);
		SZStore3.getEmployeeList().add(e40);
		SZStore3.getEmployeeList().add(e42);
    	
		e39.setLocalStore(SZStore3);
    	e40.setLocalStore(SZStore3);
    	e42.setLocalStore(SZStore3);
    	
    	fatherStore.getStoreList().add(DGStore);
    	fatherStore.getStoreList().add(GZStore);
    	fatherStore.getStoreList().add(SZStore);
    	
    	DGStore.setFatherStore(fatherStore);
    	GZStore.setFatherStore(fatherStore);
    	SZStore.setFatherStore(fatherStore);
    	
    	DGStore.getStoreList().add(DGStore1);
    	DGStore.getStoreList().add(DGStore2);
    	DGStore.getStoreList().add(DGStore3);
    	
    	DGStore1.setFatherStore(DGStore);
    	DGStore2.setFatherStore(DGStore);
    	DGStore3.setFatherStore(DGStore);
    	
    	GZStore.getStoreList().add(GZStore1);
    	GZStore.getStoreList().add(GZStore2);
    	GZStore.getStoreList().add(GZStore3);
    	
    	GZStore1.setFatherStore(GZStore);
    	GZStore2.setFatherStore(GZStore);
    	GZStore3.setFatherStore(GZStore);
    	
    	SZStore.getStoreList().add(SZStore1);
    	SZStore.getStoreList().add(SZStore2);
    	SZStore.getStoreList().add(SZStore3);
    	
    	SZStore1.setFatherStore(SZStore);
    	SZStore2.setFatherStore(SZStore);
    	SZStore3.setFatherStore(SZStore);
    	
    	storeService.save(fatherStore);	
	}
}

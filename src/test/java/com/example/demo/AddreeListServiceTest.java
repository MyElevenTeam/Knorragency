package com.example.demo;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.demo.addressList.entity.Employee;
import com.example.demo.addressList.repository.AddressListRepository;
import com.example.demo.addressList.service.IAddressListService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AddreeListServiceTest {
	@Autowired
    private	IAddressListService addressListService;
	@Test
	public void insertDate() {
		for(int i=0;i<10;i++) {
			Employee tmp=new Employee();
			tmp.setEmployeeName("小明"+i);
			addressListService.save(tmp);
		}

	}

}

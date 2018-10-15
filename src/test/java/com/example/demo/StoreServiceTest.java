package com.example.demo;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.demo.store.service.IStoreService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class StoreServiceTest {
	@Autowired
	IStoreService storeService;
	@Test
	public void findAllStoreName() {
		List<String> tmps=storeService.findAllStoreName();
		System.out.println(tmps);
	}

}

package kr.co.mission.service;

import kr.co.mission.domain.WifiVO;
import kr.co.mission.dto.WifiDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.io.IOException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/root-context.xml")
class WifiServiceImpTest {

    @Autowired(required = false)
    private WifiService wifiService;

    @Test
    void registerDB() throws IOException {

        wifiService.registerDB();
    }

    @Test
    void testMethod() {

        wifiService.testMethod();
    }

    @Test
    void findWifi() {

        List<WifiDTO> wifi = wifiService.findWifi("127.0292881 37.2518649");

        wifi.forEach(wifiDTO -> log.info(wifiDTO));

    }
}
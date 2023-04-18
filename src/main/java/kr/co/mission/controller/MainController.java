package kr.co.mission.controller;

import kr.co.mission.dto.HistoryDTO;
import kr.co.mission.dto.WifiDTO;
import kr.co.mission.service.WifiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
public class MainController {

    private final WifiService wifiService;

    @GetMapping("/wifi-info")
    @ResponseBody
    public ResponseEntity callWifiInfo() throws IOException {

//        wifiService.registerDB();

        return ResponseEntity.status(HttpStatus.OK).body(wifiService.getTotalNumber());
    }

    @GetMapping("/list")
    public void list(@Param("latitude") String latitude, @Param("longitude") String longitude,
                     Model model){

        wifiService.insertHistory(latitude + " " + longitude);

        List<WifiDTO> wifiDTOS = wifiService.findWifi(latitude + " " + longitude);

        model.addAttribute("wifiList", wifiDTOS);
    }

    @GetMapping("/detail")
    public void detail(@Param("wifi_id") int wifi_id, Model model){
        log.info(wifi_id);
        model.addAttribute("wifi", wifiService.selectOne(wifi_id));
    }

    @GetMapping("/history")
    public void history(Model model){
        List<HistoryDTO> historyDTOS = wifiService.selectAllHistory();
        log.info(historyDTOS);
        model.addAttribute("historyList", historyDTOS);
    }

    @GetMapping("/")
    public String main() {
        return "index";
    }


    @GetMapping("/spinner")
    public void spinner() {

    }
}

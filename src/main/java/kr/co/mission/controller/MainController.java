package kr.co.mission.controller;

import kr.co.mission.dto.BookmarkGroupDTO;
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
import java.util.Map;

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
                     Model model) {

        wifiService.insertHistory(latitude + " " + longitude);

        model.addAttribute("wifiList", wifiService.findWifi(latitude + " " + longitude));
    }

    @GetMapping("/detail")
    public void detail(@Param("wifi_id") int wifi_id, Model model) {
        model.addAttribute("wifi", wifiService.selectOne(wifi_id));
        model.addAttribute("bookmarkList", wifiService.selectAllBookmarkGroup());
    }

    @GetMapping("/history")
    public void history(Model model) {
        model.addAttribute("historyList", wifiService.selectAllHistory());
    }

    @GetMapping("/")
    public String main() {
        return "list";
    }


    @GetMapping("/spinner")
    public void spinner() {

    }

    @PostMapping("/bookmark/insert")
    public ResponseEntity insertBookmark(@RequestParam Map<String, Integer> map) {
        wifiService.insertBookmark(map);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @GetMapping("/bookmark")
    public void bookmark(Model model, @Param("gr_id") int gr_id) {

        model.addAttribute("bookmarkList", wifiService.selectAllBookmarkGroup());
        model.addAttribute("wifiList", wifiService.selectAllByBookmark(gr_id));
    }

    @GetMapping("/bookmark/delete")
    public String deleteBookmark(@RequestParam Map<String, Integer> map){

        wifiService.removeBookmark(map);

        return "redirect:/bookmark?gr_id=" + map.get("gr_id");
    }

    @PutMapping("/bookmark-group")
    @ResponseBody
    public ResponseEntity updateBookmark(@RequestBody BookmarkGroupDTO bookmarkGroupDTO) {
        wifiService.updateBookmarkGroup(bookmarkGroupDTO);

        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping("/bookmark-group")
    @ResponseBody
    public ResponseEntity insertBookmark(@RequestParam String gr_name) {

        wifiService.insertBookmarkGroup(gr_name);

        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @DeleteMapping("/bookmark-group")
    @ResponseBody
    public ResponseEntity deleteBookmark(@RequestParam String gr_id) {

        wifiService.removeBookmarkGroup(Integer.parseInt(gr_id));

        return ResponseEntity.status(HttpStatus.OK).build();
    }
}

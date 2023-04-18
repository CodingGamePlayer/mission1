package kr.co.mission.mapper;

import kr.co.mission.domain.BookmarkGroupVO;
import kr.co.mission.domain.HistoryVO;
import kr.co.mission.domain.WifiVO;
import kr.co.mission.dto.BookmarkGroupDTO;
import kr.co.mission.dto.HistoryDTO;
import kr.co.mission.dto.WifiDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/root-context.xml")
class WifiMapperTest {

    @Autowired(required = false)
    private WifiMapper wifiMapper;

    @Test
    void insert() {

//        WifiDTO wifiDTO = WifiDTO.builder()
//                .wifi_id(2)
//                .X_SWIFI_MGR_NO("1")
//                .X_SWIFI_WRDOFC("1")
//                .X_SWIFI_MAIN_NM("1")
//                .X_SWIFI_ADRES1("1")
//                .X_SWIFI_ADRES2("1")
//                .X_SWIFI_INSTL_FLOOR("1")
//                .X_SWIFI_INSTL_TY("1")
//                .X_SWIFI_INSTL_MBY("1")
//                .X_SWIFI_SVC_SE("1")
//                .X_SWIFI_CMCWR("1")
//                .X_SWIFI_CNSTC_YEAR("1")
//                .X_SWIFI_INOUT_DOOR("1")
//                .X_SWIFI_REMARS3("1")
//                .LAT("1")
//                .LNT("1")
//                .WORK_DTTM("1")
//                .build();

//        wifiMapper.insert(wifiDTO);
    }

    @Test
    void selectAll() {

        List<WifiVO> wifiDTOS = wifiMapper.selectAll();

        log.info(wifiDTOS.size());
    }

    @Test
    void selectOne() {

        WifiVO wifiVO = wifiMapper.selectOne(10575);

        log.info(wifiVO);
    }

    @Test
    void testInsert() {

        HistoryDTO historyDTO = HistoryDTO.builder()
                .h_y("123")
                .h_x("123")
                .h_date(String.valueOf(LocalDate.now()))
                .build();

        int i = wifiMapper.insertHistory(historyDTO);

        System.out.println(i);
    }

    @Test
    void selectAllHistory() {

        List<HistoryVO> historyVOS = wifiMapper.selectAllHistory();

        historyVOS.forEach(vo -> log.info(vo));
    }

    @Test
    void insertBookmarkGroup() {
        wifiMapper.insertBookmarkGroup("4번 그룹");
    }

    @Test
    void removeBookmarkGroup() {
        wifiMapper.removeBookmarkGroup(1);
    }

    @Test
    void updateBookmarkGroup() {
        BookmarkGroupDTO bookmarkGroupDTO = BookmarkGroupDTO.builder()
                .gr_id(2)
                .gr_name("2번 그룹")
                .build();
        wifiMapper.updateBookmarkGroup(bookmarkGroupDTO);
    }

    @Test
    void selectAllBookmarkGroup() {
        List<BookmarkGroupVO> bookmarkGroupVOS = wifiMapper.selectAllBookmarkGroup();
        log.info(bookmarkGroupVOS);
    }

    @Test
    void selectAllByBookmark() {
        List<WifiVO> bookmarkGroupVOS = wifiMapper.selectAllByBookmark(2);
        log.info(bookmarkGroupVOS);
    }

    @Test
    void insertBookmark() {
        Map<String, Integer> map = new HashMap<>();
        map.put("gr_id", 2);
        map.put("wifi_id", 7449);


    }

    @Test
    void removeBookmark() {
        Map<String, Integer> map = new HashMap<>();
        map.put("gr_id", 2);
        map.put("wifi_id", 7449);

        wifiMapper.removeBookmark(map);
    }
}
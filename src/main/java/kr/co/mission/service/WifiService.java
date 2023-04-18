package kr.co.mission.service;

import kr.co.mission.dto.BookmarkGroupDTO;
import kr.co.mission.dto.HistoryDTO;
import kr.co.mission.dto.WifiDTO;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface WifiService {

    String getTotalNumber() throws IOException;
    void registerDB() throws IOException;
    JSONObject makeAPIUrl(int start, int end) throws IOException;
    JSONObject requestAPI(String url) throws IOException;
    void testMethod();
    List<WifiDTO> findWifi(String data);
    WifiDTO selectOne(int wifi_id);
    void insertHistory(String data);
    List<HistoryDTO> selectAllHistory();
    void insertBookmarkGroup(String gr_name);
    void removeBookmarkGroup(int gr_id);
    void updateBookmarkGroup(BookmarkGroupDTO bookmarkGroupDTO);
    List<BookmarkGroupDTO> selectAllBookmarkGroup();
    List<WifiDTO> selectAllByBookmark(int gr_id);
    void insertBookmark(Map<String, Integer> map);
    void removeBookmark(Map<String, Integer> map);
}

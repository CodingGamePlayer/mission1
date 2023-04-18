package kr.co.mission.mapper;

import kr.co.mission.domain.BookmarkGroupVO;
import kr.co.mission.domain.HistoryVO;
import kr.co.mission.domain.WifiVO;
import kr.co.mission.dto.BookmarkGroupDTO;
import kr.co.mission.dto.HistoryDTO;
import kr.co.mission.dto.WifiDTO;

import java.util.List;
import java.util.Map;

public interface WifiMapper {

    void insert(WifiDTO wifiDTO);

    List<WifiVO> selectAll();

    WifiVO selectOne(int wifi_id);

    int insertHistory(HistoryDTO historyDTO);

    List<HistoryVO> selectAllHistory();

    void deleteHistory(int h_id);

    void insertBookmarkGroup(String gr_name);

    void removeBookmarkGroup(int gr_id);

    void updateBookmarkGroup(BookmarkGroupDTO bookmarkGroupDTO);

    List<BookmarkGroupVO> selectAllBookmarkGroup();

    List<WifiVO> selectAllByBookmark(int gr_id);

    void insertBookmark(Map<String, Integer> map);

    void removeBookmark(Map<String, Integer> map);
}

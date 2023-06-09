package kr.co.mission.service;

import com.google.gson.Gson;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;
import kr.co.mission.domain.BookmarkGroupVO;
import kr.co.mission.domain.HistoryVO;
import kr.co.mission.domain.WifiVO;
import kr.co.mission.dto.BookmarkGroupDTO;
import kr.co.mission.dto.HistoryDTO;
import kr.co.mission.dto.WifiDTO;
import kr.co.mission.dto.WifiJSON;
import kr.co.mission.mapper.WifiMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.json.JSONArray;
import org.json.JSONObject;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.stream.Collectors;

@Log4j2
@Component
@RequiredArgsConstructor
public class WifiServiceImp implements WifiService {

    private final WifiMapper wifiMapper;

    private final ModelMapper modelMapper;

    public void testMethod() {
        System.out.println("test");
    }

    @Override
    public String getTotalNumber() throws IOException {
        return makeAPIUrl(1, 1).getJSONObject("TbPublicWifiInfo").get("list_total_count").toString();
    }

    @Override
    public void registerDB() throws IOException {
        int totalNumber = Integer.parseInt(getTotalNumber());
        Gson gson = new Gson();

        for (int i = 0; i < totalNumber / 1000; i++) {
            JSONObject jsonObject = makeAPIUrl(1 + (1000 * i), (1000 * i) + 1000);

            JSONArray jsonArray = jsonObject.getJSONObject("TbPublicWifiInfo").getJSONArray("row");

            for (int j = 1; j < jsonArray.length(); j++) {
                JSONObject rowObject = jsonArray.getJSONObject(j);
                WifiJSON wifiJSON = gson.fromJson(rowObject.toString(), WifiJSON.class);
                wifiMapper.insert(wifiJSON);
            }

        }
    }

    @Override
    public List<WifiDTO> findWifi(String data) {
        double lnt = Double.parseDouble(data.split(" ")[1]);
        double lat = Double.parseDouble(data.split(" ")[0]);
        List<WifiDTO> list = new ArrayList<>();

        PriorityQueue<WifiDTO> pq = new PriorityQueue<>(((o1, o2) -> (int) (o1.getDistance() - o2.getDistance())));

        List<WifiDTO> collect = wifiMapper.selectAll()
                .stream()
                .map(vo -> modelMapper.map(vo, WifiDTO.class))
                .collect(Collectors.toList());

        for (int i = 0; i < collect.size(); i++) {
            WifiDTO wifiDTO = collect.get(i);
            wifiDTO.setDistance(distance(lat, lnt, Double.parseDouble(wifiDTO.getLat()), Double.parseDouble(wifiDTO.getLnt())));
            pq.offer(wifiDTO);
        }


        for (int i = 0; i < 20; i++) {
            list.add(pq.poll());
        }


        return list;
    }

    public double distance(double lat1, double lon1, double lat2, double lon2) {
        double R = 6372.8; // 지구 반지름

        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                        Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.asin(Math.sqrt(a));
        double distance = R * c;
        return Math.round(distance * 100.0) / 100.0;
    }
    @Override
    public JSONObject makeAPIUrl(int start, int end) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
        urlBuilder.append("/" + URLEncoder.encode("515a524e6f6f74773834526e586d58", "UTF-8"));
        urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8"));
        urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo", "UTF-8"));
        urlBuilder.append("/" + URLEncoder.encode(String.valueOf(start), "UTF-8"));
        urlBuilder.append("/" + URLEncoder.encode(String.valueOf(end), "UTF-8"));

        return requestAPI(urlBuilder.toString());
    }


    @Override
    public JSONObject requestAPI(String url) throws IOException {
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(url)
                .build();

        Response response = client.newCall(request).execute();
        String jsonData = response.body().string();
        return new JSONObject(jsonData);
    }

    @Override
    public WifiDTO selectOne(int wifi_id) {

        return modelMapper.map(wifiMapper.selectOne(wifi_id), WifiDTO.class);
    }

    @Override
    public void insertHistory(String data) {

        HistoryDTO historyDTO = HistoryDTO.builder()
                .h_x(data.split(" ")[1])
                .h_y(data.split(" ")[0])
                .h_date(String.valueOf(LocalDateTime.now()).replace("T", " "))
                .build();

        wifiMapper.insertHistory(historyDTO);
    }

    @Override
    public void deleteHistory(int h_id) {
        wifiMapper.deleteHistory(h_id);
    }

    @Override
    public List<HistoryDTO> selectAllHistory() {
        return wifiMapper.selectAllHistory().stream()
                .map(vo -> modelMapper.map(vo, HistoryDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public void insertBookmarkGroup(String gr_name) {
        wifiMapper.insertBookmarkGroup(gr_name);
    }

    @Override
    public void removeBookmarkGroup(int gr_id) {
        wifiMapper.removeBookmarkGroup(gr_id);
    }

    @Override
    public void updateBookmarkGroup(BookmarkGroupDTO bookmarkGroupDTO) {
        wifiMapper.updateBookmarkGroup(bookmarkGroupDTO);
    }

    @Override
    public List<BookmarkGroupDTO> selectAllBookmarkGroup() {
        return wifiMapper.selectAllBookmarkGroup().stream()
                .map(vo -> modelMapper.map(vo, BookmarkGroupDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<WifiDTO> selectAllByBookmark(int gr_id) {
        return wifiMapper.selectAllByBookmark(gr_id).stream()
                .map(vo -> modelMapper.map(vo, WifiDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public void insertBookmark(Map<String, Integer> map) {
        wifiMapper.insertBookmark(map);
    }

    @Override
    public void removeBookmark(Map<String, Integer> map) {
        wifiMapper.removeBookmark(map);
    }
}

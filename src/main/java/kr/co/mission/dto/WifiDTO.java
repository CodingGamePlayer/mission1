package kr.co.mission.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WifiDTO {
    private int wifi_id;
    private int bm_id;
    private double distance;
    private String no; // 관리번호
    private String wrdofc;
    private String nm;
    private String adres1;
    private String adres2;
    private String floor;
    private String ty;
    private String mby;
    private String se;
    private String cmcwr;
    private String year;
    private String door;
    private String remars3;
    private String lat;
    private String lnt;
    private String dttm;
}


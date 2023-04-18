package kr.co.mission.domain;

import lombok.*;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class HistoryVO {

    private int h_id;
    private String h_x;
    private String h_y;
    private String h_date;
}

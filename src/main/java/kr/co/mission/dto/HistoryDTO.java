package kr.co.mission.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class HistoryDTO {

    private int h_id;
    private String h_x;
    private String h_y;
    private String h_date;
}

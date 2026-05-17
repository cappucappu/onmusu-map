package com.example.my_app.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

/**
 * 温泉むすめエンティティ
 * テーブル名：onmusu_marker
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Onmusu {

    /** UUID（主キー） */
    private String uuid;
    /** 緯度 */
    private double latitude;
    /** 経度 */
    private double longitude;
    /** 温泉名 */
    private String hotSprings;
    /** 温泉むずめの名前の読み */
    private String nameYomi;
    /** 温泉むすめの名前 */
    private String name;
    /** イメージカラー */
    private String imageColor;
    /** 誕生日 */
    private Date birthday;
    /** 地域ID */
    private int regionId;
    /** 国コード */
    private String countryCode;
    /** 地域名 **/
    private String regionName;
    /** 国名 **/
    private String countryName;
    /** 表示順（国） **/
    private int displayOrder;
    /** 声優名 */
    private String cvName;
    /** イラストレーター名 */
    private String illustratorName;
    /** 公式のキャラページURL */
    private String officialUrl;

}

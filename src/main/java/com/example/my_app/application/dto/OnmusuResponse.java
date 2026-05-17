package com.example.my_app.application.dto;

import java.sql.Date;


public record OnmusuResponse(

    /** 緯度 */
    double latitude,
    /** 経度 */
    double longitude,
    /** 温泉名 */
    String hotSprings,
    /** 温泉むずめの名前の読み */
    String nameYomi,
    /** 温泉むすめの名前 */
    String name,
    /** イメージカラー */
    String imageColor,
    /** 誕生日 */
    Date birthday,
    /** 地域名 **/
    String regionName,
    /** 国名 **/
    String countryName,
    /** 声優名 */
    String cvName,
    /** イラストレーター名 */
    String illustratorName,
    /** 公式のキャラページURL */
    String officialUrl

){}

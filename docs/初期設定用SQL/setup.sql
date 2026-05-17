

-- 国マスター ---------------------------------------------------------------------
-- テーブル定義
CREATE TABLE countries (
    country_code CHAR(2) PRIMARY KEY, -- 国コード
    country_name VARCHAR(255) NOT NULL, -- 国名
    display_order INTEGER -- 並び順
);

COMMENT ON TABLE countries IS '国マスター';
COMMENT ON COLUMN countries.country_code IS '国コード';
COMMENT ON COLUMN countries.country_name IS '国名';
COMMENT ON COLUMN countries.display_order IS '並び順';

-- データの挿入
INSERT INTO countries (country_code, country_name, display_order) VALUES
    ('EX','例外',0),
    ('JP','日本',1),
    ('TW','台湾',2);


-- 地域マスター ---------------------------------------------------------------------
-- テーブル定義
CREATE TABLE regions (
    region_id INTEGER, -- ID
    country_code CHAR(2), -- 国コード
    region_name VARCHAR(255), -- 地域名
    
    -- 複合主キー
    PRIMARY KEY (region_id, country_code),
    
    -- 外部キー制約
    CONSTRAINT fk_country FOREIGN KEY (country_code) REFERENCES countries(country_code)
);

COMMENT ON TABLE regions IS '地域マスター';
COMMENT ON COLUMN regions.region_id IS '国ごとの地域ID';
COMMENT ON COLUMN regions.country_code IS '国コード（外部キー）';
COMMENT ON COLUMN regions.region_name IS '地域名';

-- データの挿入
INSERT INTO regions(region_id, country_code, region_name) VALUES
    (0,'EX',''),
    (1,'JP','北海道'),
    (2,'JP','青森県'),
    (3,'JP','岩手県'),
    (4,'JP','宮城県'),
    (5,'JP','秋田県'),
    (6,'JP','山形県'),
    (7,'JP','福島県'),
    (8,'JP','茨城県'),
    (9,'JP','栃木県'),
    (10,'JP','群馬県'),
    (11,'JP','埼玉県'),
    (12,'JP','千葉県'),
    (13,'JP','東京都'),
    (14,'JP','神奈川県'),
    (15,'JP','新潟県'),
    (16,'JP','富山県'),
    (17,'JP','石川県'),
    (18,'JP','福井県'),
    (19,'JP','山梨県'),
    (20,'JP','長野県'),
    (21,'JP','岐阜県'),
    (22,'JP','静岡県'),
    (23,'JP','愛知県'),
    (24,'JP','三重県'),
    (25,'JP','滋賀県'),
    (26,'JP','京都府'),
    (27,'JP','大阪府'),
    (28,'JP','兵庫県'),
    (29,'JP','奈良県'),
    (30,'JP','和歌山県'),
    (31,'JP','鳥取県'),
    (32,'JP','島根県'),
    (33,'JP','岡山県'),
    (34,'JP','広島県'),
    (35,'JP','山口県'),
    (36,'JP','徳島県'),
    (37,'JP','香川県'),
    (38,'JP','愛媛県'),
    (39,'JP','高知県'),
    (40,'JP','福岡県'),
    (41,'JP','佐賀県'),
    (42,'JP','長崎県'),
    (43,'JP','熊本県'),
    (44,'JP','大分県'),
    (45,'JP','宮崎県'),
    (46,'JP','鹿児島県'),
    (47,'JP','沖縄県'),
    (1,'TW','台湾');


-- 温泉娘用のマーカー ---------------------------------------------------------------------
CREATE TABLE onmusu_markers (
    uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    latitude  NUMERIC(9, 6) CHECK (latitude BETWEEN -90 AND 90), -- 緯度
    longitude NUMERIC(9, 6) CHECK (longitude BETWEEN -180 AND 180), -- 経度
    hot_springs VARCHAR(255), -- 温泉名（マーカーのタイトル）
    name_yomi VARCHAR(255), -- 読み
    name VARCHAR(255), -- 名前
    image_color VARCHAR(7), -- イメージカラー
    birthday DATE, -- 誕生日
    region_id INTEGER, -- 温泉がある地域（外部キー想定）
    country_code CHAR(2), -- 国コード（JP等）
    cv_name VARCHAR(100), -- 声優名
    illustrator_name VARCHAR(100), -- イラストレーター名
    official_url TEXT, -- 公式サイトのURL

    -- 外部キー制約
    CONSTRAINT fk_region FOREIGN KEY (region_id, country_code) REFERENCES regions(region_id, country_code)
);

-- コメントの追加
COMMENT ON TABLE onmusu_markers IS '温泉むすめ マーカー情報';
COMMENT ON COLUMN onmusu_markers.uuid IS 'UUID';
COMMENT ON COLUMN onmusu_markers.latitude IS '緯度';
COMMENT ON COLUMN onmusu_markers.longitude IS '経度';
COMMENT ON COLUMN onmusu_markers.hot_springs IS '温泉名 マーカーのタイトルになる';
COMMENT ON COLUMN onmusu_markers.name_yomi IS '読み';
COMMENT ON COLUMN onmusu_markers.name IS '名前';
COMMENT ON COLUMN onmusu_markers.image_color IS 'イメージカラー';
COMMENT ON COLUMN onmusu_markers.birthday IS '誕生日';
COMMENT ON COLUMN onmusu_markers.region_id IS '温泉がある地域';
COMMENT ON COLUMN onmusu_markers.country_code IS '国コード';
COMMENT ON COLUMN onmusu_markers.cv_name IS '声優名';
COMMENT ON COLUMN onmusu_markers.illustrator_name IS 'イラストレータ名';
COMMENT ON COLUMN onmusu_markers.official_url IS '公式サイトのURL';

INSERT INTO onmusu_markers(latitude, longitude, hot_springs, name_yomi, name, image_color, birthday, region_id, country_code, cv_name, illustrator_name, official_url) VALUES
(42.4925, 141.1444, '登別温泉', 'NOBORIBETSU AYASE', '登別綾瀬', '#68d2f8', '2000/7/24', 1, 'JP', '日岡なつみ', 'アマガイタロー', 'https://onsen-musume.jp/character/noboribetsu_ayase'),
(41.7786, 140.7853, '湯の川温泉', 'YUNOKAWA SEIRA', '湯の川聖羅', '#40e0d0', '2000/7/27', 1, 'JP', '野口瑠璃子', 'こうましろ', 'https://onsen-musume.jp/character/yunokawa_seira'),
(42.9652, 141.1614, '定山渓温泉', 'JOZANKEI IZUMI', '定山渓泉美', '#3cb371', '2000/11/4', 1, 'JP', '小野早稀', '凍咲しいな', 'https://onsen-musume.jp/character/jozankei_izumi'),
(43.4331, 144.0903, '阿寒湖温泉', 'AKANKO PIRIKA', '阿寒湖ぴりか', '#ff9182', '2000/2/14', 1, 'JP', '上間江望', 'plan', 'https://onsen-musume.jp/character/akanko_pirika'),
(42.5511, 140.8175, '洞爺湖温泉', 'TOYAKO NONNO', '洞爺湖のんの', '#dcd0e6', '2000/3/14', 1, 'JP', '五十嵐裕美', 'サイトー', 'https://onsen-musume.jp/character/toyako_nonno'),
(43.7253, 142.9472, '層雲峡温泉', 'YUKI CANYON SOUNKYO', '雪･キャニオン･層雲峡', '#bf793f', '2000/9/9', 1, 'JP', '東山奈央', 'sakiyamama', 'https://onsen-musume.jp/character/yuki_canyon_sounkyo'),
(45.0744, 141.7317, '豊富温泉', 'MIYU TOYOTOMI', '豊富水由', '#dd854a', '2000/5/17', 1, 'JP', '花井美春', '千種みのり', 'https://onsen-musume.jp/character/miyu_toyotomi'),
(40.6475, 140.8497, '酸ヶ湯温泉', 'SUKAYU SAYUKI', '酸ヶ湯紗雪', '#46be64', '2000/2/7', 2, 'JP', 'のぐちゆり', 'やすも', 'https://onsen-musume.jp/character/sukayu_sayuki'),
(40.8925, 140.8617, '浅虫温泉', 'ASAMUSHI YUUNA', '浅虫夕凪', '#aacf53', '2000/11/9', 2, 'JP', '真野あゆみ', 'しゅがお', 'https://onsen-musume.jp/character/asamushi_yuuna'),
(39.4489, 141.0569, '花巻温泉', 'HANAMAKI SUIKA', '花巻吹歌', '#c0eb75', '2000/3/23', 3, 'JP', '飯田里穂', 'リン☆ユウ', 'https://onsen-musume.jp/character/hanamaki_suika'),
(39.4147, 141.0069, '山の神温泉', 'YAMANOKAMI SATSUKI', '山の神皐月', '#fac370', '2000/5/23', 3, 'JP', '仲谷明香', '紅茶畑', 'https://onsen-musume.jp/character/yamanokami_satsuki'),
(38.2253, 140.7125, '秋保温泉', 'AKIU NANAKO', '秋保那菜子', '#9bdc78', '2000/5/5', 4, 'JP', '高橋花林', 'Tiv', 'https://onsen-musume.jp/character/akiu_nanako'),
(38.7442, 140.7169, '鳴子温泉', 'NARUKO KAZUKI', '鳴子夏月', '#b3f985', '2000/8/26', 4, 'JP', '飯田友子', 'やどかり', 'https://onsen-musume.jp/character/naruko_kazuki'),
(38.3183, 140.6308, '作並温泉', 'SAKUNAMI NICHIKA', '作並日果', '#cc5d3a', '2000/4/8', 4, 'JP', '赤尾ひかる', 'ダンミル', 'https://onsen-musume.jp/character/sakunami_nichika'),
(38.3719, 141.0664, '松島温泉', 'MATSUSHIMA NAZUKI', '松島名月', '#7ecfb3', '2000/8/15', 4, 'JP', '永野愛理', 'maruma', 'https://onsen-musume.jp/character/matsushima_nazuki'),
(39.8017, 140.8031, '乳頭温泉', 'NYUTO NODOKA', '乳頭 和', '#fcc2f5', '2000/5/23', 5, 'JP', '三上枝織', 'あずーる', 'https://onsen-musume.jp/character/nyuto_nodoka'),
(39.9408, 140.7228, '玉川温泉', 'TAMAGAWA YURIA', '玉川百合亜', '#c7a5cc', '2000/11/24', 5, 'JP', '美波わかな', 'フカヒレ', 'https://onsen-musume.jp/character/tamagawa_yuria'),
(38.5703, 140.5311, '銀山温泉', 'GINZAN KOYUKI', '銀山心雪', '#ffe800', '2000/11/30', 6, 'JP', '長縄まりあ', 'なつめえり', 'https://onsen-musume.jp/character/ginzan_koyuki'),
(38.6142, 139.6019, 'あつみ温泉', 'ATSUMI SHIZURU', 'あつみ詩鶴', '#91a6ba', '2000/10/1', 6, 'JP', '中恵光城', 'やすゆき', 'https://onsen-musume.jp/character/atsumi_shizuru'),
(38.1647, 140.3956, '蔵王温泉', 'ZAO TOMOE', '蔵王 巴', '#e0f9f9', '2000/10/11', 6, 'JP', '秋場ゆり', 'Hiten', 'https://onsen-musume.jp/character/zao_tomoe'),
(37.8481, 140.0381, '小野川温泉', 'ONOGAWA KOMACHI', '小野川小町', '#939a74', '2000/9/8', 6, 'JP', '村上奈津実', 'ほし', 'https://onsen-musume.jp/character/onogawa_komachi'),
(38.1561, 140.2764, 'かみのやま温泉', 'KAMINOYAMA AN', 'かみのやま 庵', '#b8c762', '2000/2/11', 6, 'JP', '進藤あまね', '甘城なつき', 'https://onsen-musume.jp/character/kaminoyama_an'),
(37.0094, 140.8503, 'いわき湯本温泉', 'IWAKI ALOHA', 'いわきあろは', '#e15a5a', '2000/8/24', 7, 'JP', '大坪由佳', 'かれい', 'https://onsen-musume.jp/character/iwaki_aloha'),
(37.8306, 140.4539, '飯坂温泉', 'IIZAKA MAHIRO', '飯坂真尋', '#98d98e', '2000/2/14', 7, 'JP', '吉岡茉祐', '有坂あこ', 'https://onsen-musume.jp/character/iizaka_mahiro'),
(37.4789, 139.9575, '東山温泉', 'HIGASHIYAMA KIRIKA', '東山季利花', '#ff7d41', '2000/5/31', 7, 'JP', '馬渕由妃', 'かる', 'https://onsen-musume.jp/character/higashiyama_kirika'),
(37.525, 140.2742, '磐梯熱海温泉', 'BANDAIATAMI HAGI', '磐梯熱海萩', '#00a0f0', '2000/2/19', 7, 'JP', '津田美波', '珈琲貴族', 'https://onsen-musume.jp/character/bandaiatami_hagi'),
(37.7122, 139.8731, '日中温泉', 'NICCHU SAYURI', '日中早百合', '#f4b3c2', '2000/6/6', 7, 'JP', '春野 杏', '裕', 'https://onsen-musume.jp/character/nicchu_sayuri'),
(36.7583, 140.3542, '大子温泉', 'DAIGO KUREHA', '大子紅葉', '#d8514b', '2000/10/19', 8, 'JP', '石橋 桃', '黒茶色のねこ', 'https://onsen-musume.jp/character/daigo_kureha'),
(36.8225, 139.7128, '鬼怒川温泉', 'KINUGAWA HINATA', '鬼怒川日向', '#ffa500', '2000/4/17', 9, 'JP', '富田美憂', 'かんざきひろ', 'https://onsen-musume.jp/character/kinugawa_hinata'),
(37.0967, 140.0003, '那須温泉', 'NASU ICHIYO', '那須一与', '#d46a78', '2000/9/10', 9, 'JP', '佐藤 舞', 'necömi', 'https://onsen-musume.jp/character/nasu_ichiyo'),
(36.9714, 139.8253, '塩原温泉', 'SHIOBARA YAYA', '塩原八弥', '#bcffbc', '2000/11/11', 9, 'JP', '澤田美晴', '望月椎那', 'https://onsen-musume.jp/character/shiobara_yaya'),
(36.6231, 138.5964, '草津温泉', 'KUSATSU YUINA', '草津結衣奈', '#f2dc5a', '2000/4/1', 10, 'JP', '高田憂希', '紅緒', 'https://onsen-musume.jp/character/kusatsu_yuina'),
(36.4975, 138.9189, '伊香保温泉', 'IKAHO HANA', '伊香保葉凪', '#f7c7c9', '2000/9/18', 10, 'JP', '茜屋日海夏', '藤真拓哉', 'https://onsen-musume.jp/character/ikaho_hana'),
(36.6433, 138.5147, '万座温泉', 'MANZA CHITOSE', '万座千斗星', '#eaedf7', '2000/11/21', 10, 'JP', '井澤美香子', '和錆', 'https://onsen-musume.jp/character/manza_chitose'),
(36.6892, 138.7781, '四万温泉', 'SHIMA HARUKA', '四万治佳', '#0088cc', '2000/11/14', 10, 'JP', '小山百代', 'ふーみ', 'https://onsen-musume.jp/character/shima_haruka'),
(36.7761, 138.9669, '水上温泉', 'MINAKAMI RIKO', '水上凛心', '#f0b1c6', '2000/3/3', 10, 'JP', '小倉 唯', 'たかやKi', 'https://onsen-musume.jp/character/minakami_riko'),
(35.9989, 139.0833, '秩父温泉', 'CHICHIBU MATSURI', '秩父美祭', '#f6ac49', '2000/12/3', 11, 'JP', '稲川英里', 'ぼに〜', 'https://onsen-musume.jp/character/chichibu_matsuri'),
(35.1058, 140.1031, '鴨川温泉', 'KAMOGAWA MARIN', '鴨川茉凛', '#aafff9', '2000/4/6', 12, 'JP', '井上ほの花', 'Go-1', 'https://onsen-musume.jp/character/kamogawa_marin'),
(34.9083, 139.8436, '南房総温泉', 'MINAMIBOSO HIYUMI', '南房総日由美', '#ffc0cb', '2000/1/31', 12, 'JP', '徳井青空', 'ろうか', 'https://onsen-musume.jp/character/minamiboso_hiyumi'),
(35.4419, 140.3881, '白子温泉', 'SHIRAKO HIMARI', '白子ひまり', '#96ffea', '2000/1/13', 12, 'JP', '来栖りん', 'teffish', 'https://onsen-musume.jp/character/shirako_himari'),
(35.6875, 139.7642, '大手町温泉', 'OTEMACHI RIRIN', '大手町梨稟', '#fff080', '2000/5/27', 13, 'JP', '楠木ともり', 'ベコ太郎', 'https://onsen-musume.jp/character/otemachi_ririn'),
(35.2325, 139.1033, '箱根温泉', 'HAKONE SAYA', '箱根彩耶', '#b4a8e6', '2000/12/25', 14, 'JP', '長江里加', '玖条イチソ', 'https://onsen-musume.jp/character/hakone_saya'),
(35.1439, 139.0828, '湯河原温泉', 'YUGAWARA IROHA', '湯河原伊露羽', '#a69abd', '2000/2/9', 14, 'JP', '大和田仁美', '40原', 'https://onsen-musume.jp/character/yugawara_iroha'),
(35.2494, 139.0483, '強羅温泉', 'GOHRA KANNA', '強羅かんな', '#7b76af', '2000/8/16', 14, 'JP', '前田佳織里', 'UGUME', 'https://onsen-musume.jp/character/gohra_kanna'),
(35.2636, 139.0142, '仙石原温泉', 'SENGOKUHARA MIKASA', '仙石原三香沙', '#fddd92', '2000/3/13', 14, 'JP', '三澤紗千香', '三つ葉ちょこ', 'https://onsen-musume.jp/character/sengokuhara_mikasa'),
(37.915, 139.2883, '月岡温泉', 'TSUKIOKA KURUMI', '月岡来瑠碧', '#90ee90', '2000/8/31', 15, 'JP', '西田望見', '月神るな', 'https://onsen-musume.jp/character/tsukioka_kurumi'),
(36.9372, 138.8081, '越後湯沢温泉', 'ECHIGO-YUZAWA KASUMI', '越後湯沢かすみ', '#eaf4fc', '2000/6/12', 15, 'JP', '東城日沙子', 'おちゃう', 'https://onsen-musume.jp/character/echigo-yuzawa_kasumi'),
(36.8856, 138.1883, '赤倉温泉', 'AKAKURA CHISAKI', '赤倉茅咲', '#be627c', '2000/8/16', 15, 'JP', '古川由利奈', '憂姫はぐれ', 'https://onsen-musume.jp/character/akakura_chisaki'),
(37.0706, 138.615, '松之山温泉', 'MATSUNOYAMA TANAMI', '松之山棚美', '#a57878', '2000/1/15', 15, 'JP', '石原夏織', '鍋島テツヒロ', 'https://onsen-musume.jp/character/matsunoyama_tanami'),
(36.8158, 137.585, '宇奈月温泉', 'UNAZUKI AKANE', '宇奈月明嶺', '#f6ae54', '2000/11/28', 16, 'JP', '黒木ほの香', 'まっくすめろん', 'https://onsen-musume.jp/character/unazuki_akane'),
(37.0894, 136.9172, '和倉温泉', 'WAKURA MANA', '和倉雅奈', '#ba55d3', '2000/11/30', 17, 'JP', '戸田めぐみ', '一色', 'https://onsen-musume.jp/character/wakura_mana'),
(36.2461, 136.3758, '山中温泉', 'YAMANAKA SORARA', '山中そらら', '#d68157', '2000/9/18', 17, 'JP', '藍原ことみ', '天三月', 'https://onsen-musume.jp/character/yamanaka_sorara'),
(36.2878, 136.3639, '山代温泉', 'YAMASHIRO YATA', '山代八咫', '#808780', '2000/3/10', 17, 'JP', '星希成奏', 'かるたも', 'https://onsen-musume.jp/character/yamashiro_yata'),
(37.3914, 136.9078, '輪島温泉', 'WAJIMA KASANE', '輪島かさね', '#e6dd7a', '2000/10/5', 17, 'JP', '大西亜玖璃', 'スコッティ', 'https://onsen-musume.jp/character/wajima_kasane'),
(36.2139, 136.2333, '芦原温泉', 'AWARA KOUME', '芦原小梅', '#cc7eb1', '2000/1/16', 18, 'JP', '相良茉優', 'Nardack', 'https://onsen-musume.jp/character/awara_koume'),
(35.6497, 138.6517, '石和温泉', 'ISAWA KOU', '石和 紅', '#d6519c', '2000/1/16', 19, 'JP', '秦 佐和子', 'しらたま', 'https://onsen-musume.jp/character/isawa_kou'),
(35.5086, 138.7619, '河口湖温泉', 'KAWAGUCHIKO TAKAMI', '河口湖多佳美', '#f9d687', '2000/2/23', 19, 'JP', '大西沙織', '遠坂あさぎ', 'https://onsen-musume.jp/character/kawaguchiko_takami'),
(35.425, 138.8475, '山中湖温泉', 'YAMANAKAKO SHINOBU', '山中湖 忍', '#dee0ea', '2000/6/22', 19, 'JP', '河野ひより', 'あるてら', 'https://onsen-musume.jp/character/yamanakako_shinobu'),
(36.1425, 137.6606, '白骨温泉', 'SHIRAHONE TOMOE', '白骨朋依', '#f5f5f5', '2000/12/22', 20, 'JP', '新田ひより', 'ゆらん', 'https://onsen-musume.jp/character/shirahone_tomoe'),
(36.9242, 138.4489, '野沢温泉', 'NOZAWA NANA', '野沢菜々', '#ffed51', '2000/4/13', 20, 'JP', '桃河りか', 'エイチ', 'https://onsen-musume.jp/character/nozawa_nana'),
(35.4453, 137.7475, '昼神温泉', 'HIRUGAMI YOZORA', '昼神夜空', '#ffcec6', '2000/6/29', 20, 'JP', '岩井映美里', 'じじ', 'https://onsen-musume.jp/character/hirugami_yozora'),
(36.7375, 138.4239, '湯田中渋温泉', 'YUDANAKASHIBU HONAMI', '湯田中渋穂波', '#996699', '2000/9/9', 20, 'JP', '大森日雅', '藤ちょこ', 'https://onsen-musume.jp/character/yudanakashibu_honami'),
(36.0444, 138.1131, '上諏訪温泉', 'KAMISUWA SHIZUNE', '上諏訪雫音', '#bcd2f4', '2000/8/15', 20, 'JP', '諏訪ななか', 'ぐれーともす', 'https://onsen-musume.jp/character/kamisuwa_shizune'),
(36.0744, 138.0872, '下諏訪温泉', 'SHIMOSUWA WATANE', '下諏訪綿音', '#ffd7d2', '2000/8/15', 20, 'JP', '菅野真衣', 'ぐれーともす', 'https://onsen-musume.jp/character/shimosuwa_watane'),
(36.3533, 138.1611, '別所温泉', 'BESSHO AISE', '別所愛染', '#e14e47', '2000/6/5', 20, 'JP', '立石 凛', 'がわこ', 'https://onsen-musume.jp/character/bessho_aise'),
(36.2975, 138.1158, '鹿教湯温泉', 'KAKEYU BANBI', '鹿教湯万美', '#89705f', '2000/2/11', 20, 'JP', '瀬戸桃子', 'marumoru', 'https://onsen-musume.jp/character/kakeyu_banbi'),
(36.4811, 138.1367, '戸倉上山田温泉', 'TOGURAKAMIYAMADA AZUKI', '戸倉上山田杏月', '#d07c59', '2000/3/5', 20, 'JP', '遠藤璃菜', 'カカオ・ランタン', 'https://onsen-musume.jp/character/togurakamiyamada_azuki'),
(35.8086, 137.2442, '下呂温泉', 'GERO MITSUKI', '下呂美月', '#7ab9ff', '2000/3/3', 21, 'JP', '佐伯伊織', '桜木蓮', 'https://onsen-musume.jp/character/gero_mitsuki'),
(36.1408, 137.2583, '飛騨高山温泉', 'TAKAYAMA TAKUMI', '高山匠美', '#ff9646', '2000/5/4', 21, 'JP', '花守ゆみり', 'らぐほのえりか', 'https://onsen-musume.jp/character/takayama_takumi'),
(35.445, 136.7725, '長良川温泉', 'NAGARAGAWA KAGARI', '長良川かがり', '#d87c77', '2000/5/11', 21, 'JP', '三谷綾子', '阿部かなり', 'https://onsen-musume.jp/character/nagaragawa_kagari'),
(36.2464, 137.525, '奥飛騨温泉', 'OKUHIDA ISUZU', '奥飛騨五十鈴', '#98bccc', '2000/6/11', 21, 'JP', '鶴見ゆき', '伍長', 'https://onsen-musume.jp/character/okuhida_isuzu'),
(36.1867, 137.5486, '平湯温泉', 'HIRAYU MITSUBA', '平湯みつば', '#ab7bcf', '2000/11/19', 21, 'JP', '堀場美希', 'りいちゅ', 'https://onsen-musume.jp/character/hirayu_mitsuba'),
(36.2239, 137.5333, '福地温泉', 'FUKUJI SANGO', '福地珊瑚', '#d5dde8', '2000/9/22', 21, 'JP', '反田葉月', 'ちょん＊', 'https://onsen-musume.jp/character/fukuji_sango'),
(35.0961, 139.0719, '熱海温泉', 'ATAMI UIKA', '熱海初夏', '#009600', '2000/7/24', 22, 'JP', '本渡 楓', 'しらび', 'https://onsen-musume.jp/character/atami_uika'),
(34.9717, 139.0917, '伊東温泉', 'ITO TSUBAKI', '伊東椿月', '#66d9ff', '2000/8/25', 22, 'JP', '鈴木絵理', 'パセリ', 'https://onsen-musume.jp/character/ito_tsubaki'),
(34.9794, 138.9308, '修善寺温泉', 'SHUZENJI TOKO', '修善寺透子', '#ffd551', '2000/1/17', 22, 'JP', '山口 愛', 'なのたろ', 'https://onsen-musume.jp/character/shuzenji_toko'),
(34.6797, 138.9442, '下田温泉', 'SHIMODA RIKA', '下田莉華', '#c8eded', '2000/6/8', 22, 'JP', '南 早紀', 'シロガネヒナ', 'https://onsen-musume.jp/character/shimoda_rika'),
(34.9083, 138.7917, '土肥温泉', 'TOI MAYU', '土肥間由', '#f7b500', '2000/6/11', 22, 'JP', '尾崎由香', '安曇アキタケ', 'https://onsen-musume.jp/character/toi_mayu'),
(34.7644, 137.6167, '舘山寺温泉', 'KANZANJI MOKO', '舘山寺萌湖', '#5ccbff', '2000/7/22', 22, 'JP', '豊田萌絵', 'うかみ', 'https://onsen-musume.jp/character/kanzanji_moko'),
(34.7736, 139.0436, '稲取温泉', 'INATORI HINAME', '稲取ひなめ', '#e45652', '2000/1/20', 22, 'JP', '鈴木杏奈', 'Noyu', 'https://onsen-musume.jp/character/inatori_hiname'),
(34.7089, 136.9419, '南知多温泉', 'MINAMICHITA MAYUNO', '南知多まゆの', '#dbff9d', '2000/8/7', 23, 'JP', '松井恵理子', 'ReDrop', 'https://onsen-musume.jp/character/minamichita_mayuno'),
(34.8217, 137.2289, '蒲郡温泉', 'GAMAGORI UTA', '蒲郡海詩', '#376dcd', '2000/11/3', 23, 'JP', '林 鼓子', '色塩', 'https://onsen-musume.jp/character/gamagori_uta'),
(34.7003, 136.3606, '榊原温泉', 'SAKAKIBARA ITO', '榊原伊都', '#463c47', '2000/7/9', 24, 'JP', '香里有佐', '村上ゆいち', 'https://onsen-musume.jp/character/sakakibara_ito'),
(34.3314, 136.8306, '志摩温泉', 'SHIMA MARIYA', '志摩茉莉也', '#cc6e87', '2000/2/22', 24, 'JP', '平野有紗', 'ねく', 'https://onsen-musume.jp/character/shima_mariya'),
(34.4825, 136.8431, '鳥羽温泉', 'TOBA AYAMI', '鳥羽亜矢海', '#566d8d', '2000/1/4', 24, 'JP', '会沢紗弥', '牛木義隆', 'https://onsen-musume.jp/character/toba_ayami'),
(35.0886, 135.8953, 'おごと温泉', 'OGOTO NENE', 'おごと寧々', '#6987dc', '2000/8/2', 25, 'JP', '野中ここな', 'うなさか', 'https://onsen-musume.jp/character/ogoto_nene'),
(35.0114, 135.6769, '嵐山温泉', 'ARASHIYAMA SHIGURE', '嵐山紫雨', '#c87cb6', '2000/3/1', 26, 'JP', '上田 瞳', 'つかこ', 'https://onsen-musume.jp/character/arashiyama_shigure'),
(34.3389, 135.4056, '犬鳴山温泉', 'INUNAKIYAMA MIKOTO', '犬鳴山 命', '#e0d1f2', '2000/4/8', 27, 'JP', '中島 唯', '草田草太', 'https://onsen-musume.jp/character/inunakiyama_mikoto'),
(34.7961, 135.2464, '有馬温泉', 'ARIMA RINKA', '有馬輪花', '#f5a491', '2000/2/17', 28, 'JP', '本宮佳奈', 'Mika Pikazo', 'https://onsen-musume.jp/character/arima_rinka'),
(34.7961, 135.2464, '有馬温泉', 'ARIMA FUUKA', '有馬楓花', '#e4a9bb', '2000/2/17', 28, 'JP', '桑原由気', 'さくら小春(QP:flapper)', 'https://onsen-musume.jp/character/arima_fuuka'),
(35.6267, 134.8111, '城崎温泉', 'KINOSAKI ARISA', '城崎亜莉咲', '#e6f497', '2000/7/20', 28, 'JP', '山下七海', 'えれっと', 'https://onsen-musume.jp/character/kinosaki_arisa'),
(35.5539, 134.4842, '湯村温泉', 'YUMURA CHIYO', '湯村千代', '#e25b54', '2000/7/15', 28, 'JP', '高木美佑', 'jimmy', 'https://onsen-musume.jp/character/yumura_chiyo'),
(33.9189, 135.7761, '十津川温泉', 'TOTSUKAWA ASUKA', '十津川飛香', '#ffccff', '2000/6/28', 29, 'JP', '影山 灯', 'れい亜', 'https://onsen-musume.jp/character/totsukawa_asuka'),
(34.265, 135.8856, '洞川温泉', 'DOROGAWA REN', '洞川 蓮', '#755d77', '2000/6/7', 29, 'JP', '久保ユリカ', 'こたつ（小龍）', 'https://onsen-musume.jp/character/dorogawa_ren'),
(33.6822, 135.3375, '白浜温泉', 'SHIRAHAMA HONAMI', '白浜帆南美', '#afeeee', '2000/7/18', 30, 'JP', '谷口夢奈', '米白粕', 'https://onsen-musume.jp/character/shirahama_honami'),
(33.9392, 135.5786, '龍神温泉', 'RYUJIN SEI', '龍神 晴', '#efefef', '2000/5/2', 30, 'JP', '中島由貴', '餡こたく', 'https://onsen-musume.jp/character/ryujin_sei'),
(33.6269, 135.9403, '南紀勝浦温泉', 'NANKIKATSUURA KIKI', '南紀勝浦樹紀', '#00ccbc', '2000/7/7', 30, 'JP', '吉岡麻耶', '茶みらい', 'https://onsen-musume.jp/character/nankikatsuura_kiki'),
(35.4578, 133.3619, '皆生温泉', 'KAIKE NAGISA', '皆生なぎさ', '#bbdbf3', '2000/8/20', 31, 'JP', '柊 優花', 'ななかぐら', 'https://onsen-musume.jp/character/kaike_nagisa'),
(35.4103, 133.8967, '三朝温泉', 'MISASA KAREN', '三朝歌蓮', '#f6bfbc', '2000/11/6', 31, 'JP', '山根 綺', '凪白みと', 'https://onsen-musume.jp/character/misasa_karen'),
(35.4914, 133.9017, 'はわい温泉', 'HAWAITOGO UKINO', 'はわい東郷浮乃', '#df7b91', '2000/7/4', 31, 'JP', '天希かのん', 'やだぽてと', 'https://onsen-musume.jp/character/hawaitogo_ukino'),
(35.4128, 133.0111, '玉造温泉', 'TAMATSUKURI KEI', '玉造 彗', '#ff5a5a', '2000/10/10', 32, 'JP', '田澤茉純', 'ニリツ', 'https://onsen-musume.jp/character/tamatsukuri_kei'),
(35.0975, 132.3503, '温泉津温泉', 'YUNOTSU SAMA', '温泉津佐間', '#77baba', '2000/6/28', 32, 'JP', '遠野ひかる', 'ふゆの春秋', 'https://onsen-musume.jp/character/yunotsu_sama'),
(35.4692, 133.0483, '松江しんじ湖温泉', 'MATSUESHINJIKO SHIJIMI', '松江しんじ湖しじみ', '#87cefa', '2000/8/3', 32, 'JP', '高野麻里佳', 'しぐれうい', 'https://onsen-musume.jp/character/matsueshinjiko_shijimi'),
(35.2044, 133.7439, '湯原温泉', 'YUBARA SAWA', '湯原砂和', '#ffefef', '2000/7/12', 33, 'JP', '佳村はるか', '桝石きのと', 'https://onsen-musume.jp/character/yubara_sawa'),
(35.1056, 134.1481, '湯郷温泉', 'YUNOGO MISA', '湯郷美彩', '#1a96ff', '2000/7/17', 33, 'JP', '岡咲美保', '八城惺架', 'https://onsen-musume.jp/character/yunogo_misa'),
(35.2319, 133.9136, '奥津温泉', 'OKUTSU KAGAMI', '奥津かがみ', '#fff189', '2000/11/10', 33, 'JP', '久保田未夢', '神岡ちろる', 'https://onsen-musume.jp/character/okutsu_kagami'),
(34.2861, 132.2575, '宮浜温泉', 'MIYAHAMA HITOKA', '宮浜仁佳', '#d15952', '2000/6/4', 34, 'JP', '長野佑紀', '掃除朋具', 'https://onsen-musume.jp/character/miyahama_hitoka'),
(34.3403, 131.1803, '長門湯本温泉', 'NAGATO SAKURA', '長門 櫻', '#fdeff2', '2000/3/23', 35, 'JP', '千本木彩花', 'シソ', 'https://onsen-musume.jp/character/nagato_sakura'),
(34.1625, 131.4561, '湯田温泉', 'YUDA KAORU', '湯田 薫', '#f7c114', '2000/9/14', 35, 'JP', '指出毬亜', 'JUNA', 'https://onsen-musume.jp/character/yuda_kaoru'),
(33.9264, 133.8311, '祖谷温泉', 'IYA MEGURI', '祖谷メグリ', '#fc64b1', '2000/8/30', 36, 'JP', '長久友紀', 'yaman**', 'https://onsen-musume.jp/character/iya_meguri'),
(34.1889, 133.8211, 'こんぴら温泉', 'KONPIRA MOMO', 'こんぴら桃萌', '#ff73d2', '2000/5/27', 37, 'JP', '吉田有里', 'かにビーム', 'https://onsen-musume.jp/character/konpira_momo'),
(34.1758, 134.0531, '塩江温泉', 'SHIONOE SHUKO', '塩江修子', '#fabf14', '2000/3/29', 37, 'JP', '田辺留依', 'しじま', 'https://onsen-musume.jp/character/shionoe_shuko'),
(33.8519, 132.7861, '道後温泉', 'DOGO IZUMI', '道後泉海', '#fab450', '2000/8/25', 38, 'JP', '篠田みなみ', 'H2SO4', 'https://onsen-musume.jp/character/dogo_izumi'),
(33.9922, 132.915, '鈍川温泉', 'NIBUKAWA MANAMI', '鈍川まなみ', '#fcf5db', '2000/5/1', 38, 'JP', '鈴原希実', 'さいね', 'https://onsen-musume.jp/character/nibukawa_manami'),
(32.7275, 133.015, 'あしずり温泉', 'ASHIZURI AKARI', 'あしずり 星', '#787878', '2000/5/20', 39, 'JP', '大空直美', '夜ノみつき', 'https://onsen-musume.jp/character/ashizuri_akari'),
(33.3644, 130.8039, '原鶴温泉', 'HARAZURU MIYA', '原鶴美鵺', '#5882cc', '2000/1/11', 40, 'JP', '石飛恵里花', '紅林のえ', 'https://onsen-musume.jp/character/harazuru_miya'),
(33.1294, 129.9861, '嬉野温泉', 'URESHINO RIKKA', '嬉野六香', '#e6e6fa', '2000/3/7', 41, 'JP', '小澤亜李', 'Anmi', 'https://onsen-musume.jp/character/ureshino_rikka'),
(33.1975, 130.0186, '武雄温泉', 'TAKEO CECIL', '武雄星知', '#c39c61', '2000/4/12', 41, 'JP', '深川芹亜', '町村こもり', 'https://onsen-musume.jp/character/takeo_cecil'),
(33.3703, 129.5539, '平戸温泉', 'HIRADO MOTOE', '平戸基恵', '#3ba63a', '2000/10/1', 42, 'JP', '矢野妃菜喜', 'ねこめたる', 'https://onsen-musume.jp/character/hirado_motoe'),
(32.7419, 130.2611, '雲仙温泉', 'UNZEN INORI', '雲仙伊乃里', '#e6e8ff', '2000/7/1', 42, 'JP', '奥野香耶', 'カグユヅ', 'https://onsen-musume.jp/character/unzen_inori'),
(32.7231, 130.2081, '小浜温泉', 'OBAMA AMANE', '小浜あまね', '#888bfe', '2000/6/30', 42, 'JP', '鬼頭明里', 'かかげ', 'https://onsen-musume.jp/character/obama_amane'),
(33.0769, 131.1394, '黒川温泉', 'KUROKAWA KIRA', '黒川姫楽', '#8b88ce', '2000/1/1', 43, 'JP', '田中美海', '三嶋くろね', 'https://onsen-musume.jp/character/kurokawa_kira'),
(32.9464, 131.0269, '阿蘇温泉', 'ASO HOMURA', '阿蘇ほむら', '#ff7f7f', '2000/2/9', 43, 'JP', '髙橋麻里', 'ももこ', 'https://onsen-musume.jp/character/aso_homura'),
(32.2117, 130.7606, '人吉温泉', 'HITOYOSHI AOI', '人吉青井', '#feeed6', '2000/4/28', 43, 'JP', '青山吉能', '煎路', 'https://onsen-musume.jp/character/hitoyoshi_aoi'),
(32.9364, 130.5661, '玉名温泉', 'TAMANA MAMI', '玉名満美', '#d8bfd8', '2000/4/1', 43, 'JP', '青木陽菜', 'みらくるる', 'https://onsen-musume.jp/character/tamana_mami'),
(33.2644, 131.3553, '由布院温泉', 'KANADE BADEN YUFUIN', '奏･バーデン･由布院', '#ffb0d7', '2000/6/15', 44, 'JP', '和多田美咲', '小原トメ太(QP:flapper)', 'https://onsen-musume.jp/character/kanade_baden_yufuin'),
(33.2842, 131.5078, '別府温泉', 'BEPPU TAMAKI', '別府環綺', '#6e6efa', '2000/8/8', 44, 'JP', '岩橋由佳', 'ぽんかん⑧', 'https://onsen-musume.jp/character/beppu_tamaki'),
(33.315, 130.935, '日田温泉', 'HITA AYAME', '日田絢芽', '#68a4d9', '2000/9/1', 44, 'JP', '田中音緒', '咲良ゆき', 'https://onsen-musume.jp/character/hita_ayame'),
(33.2217, 131.3211, '湯平温泉', 'YUNOHIRA TOUKA', '湯平燈華', '#aea9c3', '2000/12/28', 44, 'JP', '礒部花凜', '吉田依世', 'https://onsen-musume.jp/character/yunohira_touka'),
(31.7303, 131.3853, '北郷温泉', 'KITAGO KONOMI', '北郷このみ', '#fff799', '2000/9/5', 45, 'JP', '江口菜子', '胡麻乃りお', 'https://onsen-musume.jp/character/kitago_konomi'),
(31.2389, 130.6408, '指宿温泉', 'IBUSUKI ERINA', '指宿絵璃菜', '#ff69b4', '2000/6/1', 46, 'JP', '松田颯水', '竹花ノート', 'https://onsen-musume.jp/character/ibusuki_erina'),
(31.8847, 130.8353, '霧島温泉', 'KIRISHIMA KUROE', '霧島黒恵', '#4c484c', '2000/11/7', 46, 'JP', '佐藤日向', '魔太郎', 'https://onsen-musume.jp/character/kirishima_kuroe'),
(24.4178, 123.8219, '西表島温泉', 'IRIOMOTEJIMA YAEKA', '西表島八重夏', '#5bdeff', '2000/2/22', 47, 'JP', '田村響華', '茨乃', 'https://onsen-musume.jp/character/iriomotejima_yaeka'),
(24.7061, 121.1969, '尖石温泉', 'JIANSHIH NEIWAN', '尖石内湾', '#c4f2f9', '2000/4/16', 1, 'TW', '安齋由香里', '佃煮のりお', 'https://onsen-musume.jp/character/jianshih_neiwan');
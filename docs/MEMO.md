DBは複数ログインに対応できるような設計にするが、一旦はログイン機能なしで単一ユーザを想定して設計・作成

使用したい用途を考えると複数ユーザでログインする必要はないため、ユーザの管理機能は本来用途を達成してから

# 温泉むすめガイドライン
https://onsen-musume.jp/news/5082

# 実装予定機能
| 機能名                       | 優先度 | 備考           |
|---------------------------|-----|--------------|
| 温泉むすめの温泉地マーカーを表示          | 高   | |
| マーカークリックでgooglemapの地点に飛ばす | 高   |  | 
| マーカーに行ったかどうかのチェックをつける     | 高   |  |
| マーカーをgooglemapの地点情報から作成する | 中   |  |
| マーカーの位置情報からgooglemapの地点を参照する | 中||
| ログイン機能                    | 低   | アクセス統制＋勉強のため |

# 公開のための構築予定のインフラ図
![](/docs/InfrastructureDiagram.png)

# DB 

```mermaid
erDiagram
    %% 関係の定義
    users ||--o{ custom_markers: "作成（所有）"
    users ||--o{ marker_notes: "記載"
    onmusu_markers }o--|| prefecture : "所在"
    custom_markers ||--o| marker_notes: "情報記録"
    onmusu_markers ||--o| marker_notes: "情報記録"
    
    
    %% テーブル情報の定義
    onmusu_markers {
        uuid uuid PK "UUID"
        double lat "緯度"
        double lng "軽度"
        string hot_springs "温泉名 マーカーのタイトルになる"
        string name "名前"
        int prefecture_id PK "温泉がある県"
        string cv_name "声優名"
        string illustrator_name "イラストレータ名"
        string official_url "公式サイトのURL"
    }
    
    %% 県
    prefecture {
        uuid uuid PK "UUID"
        string name "名前"
    }
    
    %% 地図上に表示するマーカーの情報
    custom_markers {
        uuid uuid PK "UUID"
        uuid user_uuid FK "users.uuidへの外部キー"
        double lat "緯度"
        double lng "軽度"
        string title "マーカーのタイトル"
    }
    
    %% ユーザーがマーカーに付与する情報
    marker_notes{
        uuid uuid PK "サロゲートキー"
        uuid marker_uuid FK "複合ユニーク制約（1/2） onmusu_markers.uuidとcustom_markers.uuidへの外部キー"
        uuid user_uuid FK "複合ユニーク制約（2/2） users.uuidへの外部キー"
        string note "説明文"
        boolean isVisited "行ったかどうか"
        timestamp updated_at "更新日時"
    }
    
    %% ユーザマスタ
    users {
        uuid uuid PK "UUID"
        string login_id UK "ログインID"
        string password "パスワード"
    }
```

/**
 * id=mapのdiv要素に日本のマップを表示
 *
 * @param {Object[]} markerOptions - 地図上に置くマーカーの情報
 * @param {[number, number]} markerOptions.coords - マーカ設置座標
 * @param {String} markerOptions.text - マーカにつける説明文
 *
  */
function createJapanMap(markerOptions = []) {

    // 固定値の定義
    const initialPosition = [36.0, 137.0]; // 初期表示位置
    const initialZoom = 5; // 初期ズーム
    const minZoom = 5; // 最大縮小率
    const maxSouth = 20.0; // 表示最大範囲（南）
    const maxWest = 122.0; // 表示最大範囲（西）
    const maxNorth = 46.0; // 表示最大範囲（北）
    const maxEast = 154.0; // 表示最大範囲（東）



    // 日本全体を表示する初期表示を設定
    const map = L.map('map').setView(initialPosition, initialZoom);

    // 地図の表示可能範囲を設定
    const southWest = L.latLng(maxSouth, maxWest);
    const northEast = L.latLng(maxNorth, maxEast);
    const bounds = L.latLngBounds(southWest, northEast);
    map.setMaxBounds(bounds);

    // 地図の最大縮小率を設定
    map.options.minZoom = minZoom; // これ以上小さくなると日本からはみ出すため

    // おまけ：範囲外に移動しようとした時にバウンス（跳ね返り）させる設定
    // TODO: これでなにがどう変わるか確認する
    map.on('drag', function() {
        map.panInsideBounds(bounds, { animate: false });
    });

    // たぶん地図のスタイル
    // TODO: 地図のスタイルを変更する
    L.tileLayer('https://{s}.tile.openstreetmap.jp/{z}/{x}/{y}.png', {
        attribution: "&copy; <a href='http://osm.org/copyright'>OpenStreetMap</a> contributors"
    }).addTo(map);



    // 3. マーカーの設置
    const markers = markerOptions.map((markerOption) => {
        // マーカーの作成
        const marker = L.marker(markerOption.coords).addTo(map);

        // 4. ポップアップの設定
        marker.bindPopup(markerOption.text);

        return marker
    });
}
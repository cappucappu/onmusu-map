/**
 * id=mapのdiv要素に日本のマップを表示
 */
export function createJapanMap(markerOptions = []) {
    // 固定値の定義
    const initialPosition = [36.0, 137.0]; // 東京の座標
    const initialZoom = 5; //　初期ズーム
    const minZoom = 5; // 最大縮小
    // 表示最大範囲
    const maxSouth = 20.0;
    const maxWest = 122.0;
    const maxNorth = 46.0;
    const maxEast = 154.0;
    // 地図の初期化
    const map = L.map('map').setView(initialPosition, initialZoom);
    // 地図の表示可能範囲を設定
    const southWest = L.latLng(maxSouth, maxWest);
    const northEast = L.latLng(maxNorth, maxEast);
    const bounds = L.latLngBounds(southWest, northEast);
    map.setMaxBounds(bounds);
    map.options.minZoom = minZoom;
    // 範囲外移動の制御
    map.on('drag', () => {
        map.panInsideBounds(bounds, { animate: false });
    });
    // タイルレイヤー（地図の見た目）の設定
    L.tileLayer('https://{s}.tile.openstreetmap.jp/{z}/{x}/{y}.png', {
        attribution: "&copy; <a href='http://osm.org/copyright'>OpenStreetMap</a> contributors"
    }).addTo(map);
    // マーカーの設置
    markerOptions.map((option) => {
        const marker = L.marker(option.coords).addTo(map);
        marker.bindPopup(option.text);
    });
}
//# sourceMappingURL=JapanMap.js.map
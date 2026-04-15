declare const L: typeof import('leaflet');

/**
 * マーカー情報の型定義
 */
interface MarkerOption {
    coords: [number, number]; // [緯度, 経度] のタプル型
    text: string;
}

/**
 * id=mapのdiv要素に日本のマップを表示
 */
export function createJapanMap(markerOptions: MarkerOption[] = []): void {

    // 固定値の定義
    const initialPosition: [number, number] = [36.0, 137.0]; // 東京の座標
    const initialZoom: number = 5; //　初期ズーム
    const minZoom: number = 5; // 最大縮小

    // 表示最大範囲
    const maxSouth: number = 20.0;
    const maxWest: number = 122.0;
    const maxNorth: number = 46.0;
    const maxEast: number = 154.0;

    // 地図の初期化
    const map: L.Map = L.map('map').setView(initialPosition, initialZoom);

    // 地図の表示可能範囲を設定
    const southWest: L.LatLng = L.latLng(maxSouth, maxWest);
    const northEast: L.LatLng = L.latLng(maxNorth, maxEast);
    const bounds: L.LatLngBounds = L.latLngBounds(southWest, northEast);

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
    markerOptions.map((option: MarkerOption): void => {
        const marker: L.Marker = L.marker(option.coords).addTo(map);
        marker.bindPopup(option.text);
    });
}
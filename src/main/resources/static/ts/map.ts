declare const L: typeof import('leaflet');

import {OnmusuResponse} from "./models";

export class Map {

    // 初期表示
    private initialPosition: [number, number] = [36.0, 137.0]; // 東京の座標
    private initialZoom: number = 8; //　初期ズーム

    // ズームの設定
    private minZoom: number = 5; // 最大縮小

    // マップの表示最大範囲
    private maxSouth: number = 20.0;
    private maxWest: number = 122.0;
    private maxNorth: number = 46.0;
    private maxEast: number = 154.0;

    // マップオブジェクト
    private map: L.Map;
    private southWest: L.LatLng;
    private northEast: L.LatLng;
    private bounds: L.LatLngBounds;

    constructor(id?: string) {
        if(id === undefined) {
            id = 'map'
        }

        // 地図の初期化
        this.map = L.map(id).setView(this.initialPosition, this.initialZoom);

        // 地図の表示可能範囲を設定
        this.southWest = L.latLng(this.maxSouth, this.maxWest);
        this.northEast = L.latLng(this.maxNorth, this.maxEast);
        this.bounds = L.latLngBounds(this.southWest, this.northEast);

        this.map.setMaxBounds(this.bounds);
        this.map.options.minZoom = this.minZoom;

        // 範囲外移動の制御
        this.map.on('drag', () => {
            this.map.panInsideBounds(this.bounds, { animate: false });
        });

        // タイルレイヤー（地図の見た目）の設定
        L.tileLayer('https://{s}.tile.openstreetmap.jp/{z}/{x}/{y}.png', {
            attribution: "&copy; <a href='http://osm.org/copyright'>OpenStreetMap</a> contributors"
        }).addTo(this.map);
    }

    public putMarker(markerList: OnmusuResponse[]) {
        // マーカーの設置
        markerList.map((option: OnmusuResponse): void => {

            const marker: L.Marker = L.marker([option.latitude, option.longitude]).addTo(this.map);
            marker.bindPopup(option.hotSprings);
        });
    }
}

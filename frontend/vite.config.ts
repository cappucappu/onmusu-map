import { defineConfig } from 'vite'
import { resolve } from 'path';

export default defineConfig({
    build: {
        // Spring Bootのstaticフォルダの中に出力する
        outDir: '../src/main/resources/static/dist',
        emptyOutDir: true, // ビルドのたびに古いファイルを消す
        manifest: true,    // 本格的に運用するならハッシュ化管理用に有効化
        lib: {
            // 起点となるTSファイルを直接指定
            entry: resolve(__dirname, 'src/map.ts'),
            name: 'OnmusuMap',
            fileName: 'map-bundle',
            formats: ['es'] // モダンなブラウザ向け
        },
        rollupOptions: {
            // 通常、ライブラリモードでは外部化されるものを「強制的に含める」ようにする
            external: [],
            output: {
                // 全ての依存関係を bundle 内に含める設定
                globals: {
                    leaflet: 'L'
                }
            }
        }
    }
})
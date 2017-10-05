# docker-centos7-phpfpm

# 設定内容
- ロケール設定
- タイムゾーン
- インストール
  - 運用ツール
  - nginxインストール
  - php-fpmインストール
  - PHP関連ツール
  - アプリの設定登録
- yumキャッシュクリア
- アプリ用ポートの開放

# 起動方法
- $ docker run --name phpfpm -dit -p 80:80 -p 9000:9000 --privileged oshou/docker-centos7-phpfpm54
- $ docker exec -it phpfpm /bin/bash

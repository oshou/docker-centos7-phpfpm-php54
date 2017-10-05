# docker-centos7-phpfpm

# 設定内容
- ロケール設定
- タイムゾーン
- インストール
  - 運用ツール
  - Nginx
  - php-fpm
  - PHP関連ツール
- yumキャッシュクリア
- 各ミドルウェアの設定ファイル配置
- 公開用ポートの設定
- curl 

# 起動方法
- $ docker run --name phpfpm -dit -p 80:80 -p 9000:9000 --privileged oshou/docker-centos7-phpfpm54
- $ docker exec -it phpfpm /bin/bash

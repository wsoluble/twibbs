# twibbsについて

twibbsは、Twitterユーザー向けの簡易掲示板です。
Twitterユーザーがログインして、自由に自分のスレッドを作成したり、他人の作成したスレッドにレスを書き込んだりすることができます。

実装したのは2017年。
使用した言語はPHP。
[Codeigniter](https://codeigniter.jp/user_guide/3/)というフレームワークを利用しています。

MariaDBのSpiderストレージエンジンを一度使ってみたかったので、Spider版と、InnoDB版があります。

機能はほぼ同じですが、それぞれのREADMEを参照してください。

## Spider版

DBを[Spiderストレージエンジン](https://mariadb.com/kb/en/spider-storage-engine-overview/)で実装したバージョン。Spiderストレージエンジンは、ネットワークをまたいでテーブルをシャーディング（水平分散）する機能を備えたストレージエンジンです。ただし、このプロジェクトは一つのDBサーバー（db_masterコンテナ）内でシャーディングしております。

https://github.com/wsoluble/twibbs/tree/master/dev/spider

## ノーマル版

DBをInnoDBで実装したバージョン

https://github.com/wsoluble/twibbs/tree/master/dev/normal


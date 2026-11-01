# いきもの掲示板

## アプリケーション概要
生き物の写真を投稿し、ユーザー同士で閲覧・交流ができるアプリケーション

## 実装した機能
- ユーザー登録・ログイン
- 写真にタイトル・撮影日時などの情報を添えた投稿の作成・編集・削除
- プロフィール画像・一言コメントの編集
- 投稿のブックマーク登録、コメント送信
- 投稿およびユーザーのキーワード検索
- 投稿のカテゴリによるフィルター
- 投稿の新しい順・古い順・ブックマーク順によるソート
- 管理者権限によるユーザー・投稿・コメントの閲覧・削除

## 製作経緯
プログラミングスクールで学習したことを活かし、Ruby on Railsで作成したWEBアプリケーションです。
基本的なCRUD機能の実装に加え、目当ての投稿にたどり着きやすくするために投稿のソート・フィルター機能を充実させました。
ログイン認証はDeviseで実装しました。テストの一部はRSpecを実装して自動化を
デプロイ完了後、画面構成を見直してUIを改善しました。
それに伴い、Railsのアップデート(6.1 → 7.0)を行いました。

## 反省点と今後の課題
テーマで迷走、アプリの方向性を決めるべきだった
見た目にこだわるとキリがないとはいえ画面がシンプルすぎ、画面の見た目やアニメーションを工夫する余地があった
デプロイに手一杯でAWSの他の機能を活用できなかった、特にストレージ機能を実装したい
​
## 開発環境
- OS： Windows, Ubuntu
- 言語： HTML, CSS, JavaScript, Ruby(3.1.2)
- データベース: SQLite, MYSQL
- フレームワーク： Ruby on Rails(7.0.10)
- JSライブラリ： Bootstrap(5.0.0)
- インフラ： AWS
- IDE： VSCode
- その他： RSpec, rubocop, Git, GitHub, nginx, Figma
​
## 使用素材
- Font Awesome
- いらすとや
- 写真AC

## 設計書
- ER図：https://drive.google.com/file/d/16bf4MvgjYSpM3mfgn5MDS9HV-OgtP0JP/view?usp=drive_link
- UIFlows：https://drive.google.com/file/d/1Lf4FRIQ1mA2k2eYtW5ngxovmxTgxB8pb/view?usp=drive_link
- アプリケーション詳細設計書：https://docs.google.com/spreadsheets/d/1-x2HTD88kHMjN3m_qiLWZNKTJvGvyXAZ1Y_fpeMa6Fw/edit?usp=drive_link
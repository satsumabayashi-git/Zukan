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
アプリケーション作成に先駆けて設計書を作成し、全体像を掴みました。
また、AWS EC2上のUbuntuに開発環境を準備しました。
基本的なCRUD機能の実装に加え、目当ての投稿にたどり着きやすくするために投稿のソート・フィルター機能を充実させました。
ログイン認証はDeviseで簡易的に実装しました。テストの一部はRSpecを実装して自動化しました。
デプロイ完了後、画面構成を見直してUIを改善しました。
それに伴い、JavaScriptライブラリを最適化するため、Railsのアップデート(6.1 → 7.0)を行いました。

## 反省点と今後の課題
- 実装すべき機能を絞り込めず、特徴に欠けるアプリケーションとなった。最初にアプリの方向性を決め、ターゲットユーザーを明確にする必要があった。
- 見た目にこだわるとキリがないと感じたため画面をシンプルにまとめたが、画面の質感やアニメーションは工夫する余地があった。UI/UXについて学習して画面構成を改善できるようにしたい。
- デプロイに手一杯でAWSの機能を活用できなかった。特に画像ファイルを扱うにあたり、S3を利用してデータベースの効率化を検討したい。
- デプロイ後に手動で何度も修正して再デプロイをする非効率さを実感したので、CI/CDを導入したい。
​
## 開発環境
- OS： Windows, Ubuntu
- 言語： HTML, CSS, JavaScript, Ruby(3.1.2)
- データベース: SQLite, MYSQL
- フレームワーク： Ruby on Rails(7.0.10)
- JSライブラリ： Bootstrap(5.0.0)
- インフラ： AWS(EC2、RDS、VPC、CloudWatch)
- IDE： VSCode
- その他： RSpec, rubocop, Git, GitHub, nginx, Figma
​
## 使用素材
- Font Awesome
- いらすとや
- 写真AC

## 設計書
- ER図：https://drive.google.com/file/d/1FPUeg3Yy38Ax06hUtRAeRjxOW845N0Eq/view?usp=sharing
- UIFlows：https://drive.google.com/file/d/1p-7iQLqCLVAoPXS4zxosTJErxXphhjO8/view?usp=sharing
- アプリケーション詳細設計書：https://docs.google.com/spreadsheets/d/1lGhlJQbRXk66gI4qcmguzXhn0RFjN8yN/edit?usp=sharing&ouid=109413690513704898064&rtpof=true&sd=true
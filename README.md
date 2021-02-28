# 確定申告用 帳簿作成アプリ

このアプリは、フリーランスのための確定申告用の帳簿を作成するアプリです。(日本用)

## 概要

売上や経費を入力すると、現金出納帳、経費帳、仕訳帳、総勘定元帳、損益計算書、貸借対照表を自動で作成してくれます。

起業一年目の方や、エンジニアで副業がある方など、日々の取引が少なく毎日記帳するのは面倒だと思っている方向けです。  
確定申告期間ギリギリでも作成しやすいようシンプルで分かりやすいアプリを作成しました。

エクセルで経費を管理している方も多いと思います。  
エクセル風の表で表示されるところが特徴です。まるでエクセルで管理しているようで、親しみやすいかと思います。

確定申告が手軽にできるものになりますように！

### 注意事項

アプリの仕訳は現金のみ対応しています(当座預金はありません)。  
確定申告は自己責任でお願いします。

### URL

https://cash.record-for-kakutei.ml  
テスト用 メールアドレス: sample@sample.com  
パスワード : sample

### 想定している人

- 仕入れがない
- 従業員がいない
- 売上が 1000 万円以下
- エンジニア、デザイナーなど

## デモ

最初の画面でアプリの説明を行っています(React.js)
![アプリ説明](https://i.gyazo.com/06817240b3c4a103d5c83574b0124574.gif)

ログイン後、入力画面(エクセル出力可能)
![入力画面](https://i.gyazo.com/579f46a9561152d6e64d695de6bff46c.png)

入力欄の下には、科目説明もあります。勘定科目が分からなくなったら見てください。
![科目説明](https://i.gyazo.com/7b7026bac132dc45f1593bacb3e1515d.gif)

確定申告の際に必要な資料が作成されます。
![損益計算書](https://i.gyazo.com/65a70398397d46f941ac5c802ae8d57f.png)

![貸借対照表](https://i.gyazo.com/722a37ff2b4480f198cc9fe0fc34e2a0.png)

## 使用技術

- フロントエンド

  - React.js(react-rails)
  - JavaScript
  - HTML / CSS / SCSS

- バックエンド

  - Rails 6.1.3
  - Ruby 2.6.3

- インフラ(冗長化構成)

  - MySQL 8.0.23
  - AWS(マルチ AZ, EC2, RDS, Route53, IAM, ELB(ALB), CloudWatch, AutoScaling, S3(sorry ページ))

  なお現在は、EC2 一つと RDS のマスター 一つで運転中です。(無料枠を使用しているため)

- テスト(単体テスト・結合テスト)

  - Rspec

- UI
  - react-icons

## AWS 構成図

![AWS構成図](https://i.gyazo.com/feb77416a7b524df752a5c2db60d9ad2.png)

Route53 フェイルオーバールーティング　セカンダリ Sorry ページ
![Sorryページ](https://i.gyazo.com/22766d5bd05106d8fd36d18803d75127.png)

## 機能一覧

- アプリ説明画面(React.js)

- ユーザー認証(devise)

  - 新規登録
  - ログイン

- レコードの登録(CRUD)

  - 新規作成
  - 編集
  - 削除
  - 更新

- 表計算

  - 現金出納帳
  - 経費長
  - 仕訳帳
  - 総勘定元帳
  - 試算表
  - 損益計算表
  - 貸借対照表

- エクセル風表出力

- レスポンシブ Web デザイン
  - ハンバーガーメニュー(JavaScript)

## DB 設計

![ER図](https://i.gyazo.com/ec01d102b3c698c2e9a9b2888154dc92.png)

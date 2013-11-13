# lod2013-examples

LODチャレンジ2013 第6回LODチャレンジデー用のサンプルコード

## 準備

* Windows AzureかCloudnでUbuntu 12.10 を起動してsshで入れるようになるまで設定しておくこと

### 環境の更新

    $ sudo apt-get update
    $ sudo apt-get -u upgrade

yと入力すると更新が実行される．終了するまでに数分かかる．

### 必須ソフトウェアのインストール

    $ sudo apt-get install git-core ruby1.9.3
    $ sudo install bundler

### サンプルコードインストール

    $ git clone https://github.com/fumi/lod2013-examples.git
    $ cd lod2013-examples/src/
    $ bundle install

### サンプル起動

    $ bundle exec shotgun app.rb

ブラウザで http://localhost:9393 見らればOK．



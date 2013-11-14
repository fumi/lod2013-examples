# lod2013-examples

LODチャレンジ2013 第6回LODチャレンジデー用のサンプルコード

## 準備

* Windows AzureかCloudnでUbuntu 12.10 を起動してsshで入れるようになるまで設定しておくこと

### 環境設定

    $ sudo locale-gen ja_JP.UTF-8
    $ sudo apt-get update
    $ sudo apt-get -u upgrade
    $ sudo apt-get install git-core ruby1.9.3

yと入力すると更新が実行される．終了するまでに数分かかる．

### gemの設定

~/.bashrcに以下を追加する．
    GEM_HOME=~/.gem
    PATH=~/.gem/ruby/1.9.1/bin:$PATH

その後以下を実行
    $ source ~/.bashrc
    $ gem install bundler --user-install
    

### サンプルコードインストール

    $ git clone https://github.com/fumi/lod2013-examples.git
    $ cd lod2013-examples/src/
    $ bundle install --path vendor/bundle 

### サンプル起動

    $ bundle exec shotgun app.rb

ブラウザで http://localhost:9393 見らればOK．



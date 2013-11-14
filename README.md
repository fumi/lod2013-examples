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

    $ bundle exec shotgun -o 0.0.0.0 app.rb


ブラウザで http://ホスト名:9393 にアクセスして見らればOK．
あらかじめWindows AzureあるいはCloudnで9393ポートを開いておくこと．

#### Windows Azure
仮想マシン → エンドポイント → 追加 → スタンドアロン エンドポイントの追加

    名前: shotgun
    プロトコル: TCP
    パブリックポート: 9393
    プライベートポート: 9393

#### Cloudn
ネットワーク → ビューの選択: セキュリティ グループ → [該当のグループを選択]

    受信規則
    プロトコル: TCP
    開始ポート: 9393
    終了ポート: 9393
    CIDR: 0.0.0.0/0


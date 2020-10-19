# Instagramのクローンアプリケーション


これは、次のアプリケーションを基に作られたクローンアプリケーションです。
[*Instagram*](https://www.instagram.com)

参考にした教材は、
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
（第6版）
[Michael Hartl](https://www.michaelhartl.com/) 著
 
 
# デモ

 
"hoge"の魅力が直感的に伝えわるデモ動画や図解を載せる


# 特徴
 
 
Samplegramは日々の日常や体験、興味関心のあるものを写真として共有することによって、
友人や周りの人と繋がることができます。

また、思い出を鮮明に残したり、趣味の合うユーザーの投稿や素敵な写真を眺めることで、
ご自身の価値観を広げることができます。

ぜひ、写真を投稿して新しい自分を見つけてみませんか？


# アプリのURL


### **https://arcane-sea-92693.herokuapp.com**


# 使い方
 
 
このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。

```
$ git clone https://github.com/younghotblue/samplegram.git
```
ディレクトリを移動します。

```
$ cd samplegram
```

その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ bundle install --without production
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```

👉 http://localhost:3000
 
 
# 作者
 
* Shota Tamada
* sho.sodawater@gmail.com

#ライセンス

This project is licensed under the MIT License - see the LICENSE.md file for details
このプロジェクトは MIT ライセンスの元にライセンスされています。 
詳細は[LICENSE.md](LICENSE.md)をご覧ください。
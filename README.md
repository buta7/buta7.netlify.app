# README

**hugo-theme-dream**はメディアファイル(css/js)を/から参照するのでnetlifyやgithub pagesのproject向き(github pagesのuserはだめ)

## セットアップ

サイト作成

    $ hugo new site buta7.netlify.app

テーマ設定(テーマをカスタマイズせずそのまま使う場合はsubmodule化がよい)

    $ cd buta7.netlify.app/themes
    $ git submodule add https://github.com/g1eny0ung/hugo-theme-dream.git

サイト設定

    $ cp -pr ./themes/hugo-theme-dream/{archetypes,i18n,images,layouts,static} .
    $ cp -pr ./themes/hugo-theme-dream/exampleSite/config.toml .
    vi config.toml
    baseURL = "http://buta7.netlify.app/"
    languageCode = "ja"
    title = "Buta7 Web Site by Hugo"
    theme = "hugo-theme-dream"

## 使い方

### 投稿

新規投稿

    $ hugo new posts/2020/05/helloworld.md
    content/posts/2020/05/helloworld.md created
    
文書作成

    $ vi content/posts/2020/05/helloworld.md
    
下書きモード解除

    $ vi content/posts/2020/05/helloworld.md
    ...
    draft: false
    ...
    
(古い情報)下書きモード解除

    $ hugo undraft content/posts/2020/05/helloworld.md

固定ページの作成(architypeのabout.mdを使う)

    $ hugo new about/_index.md
    ...
    
上記ファイル構成を元にconfig.tomlのメニューを設定

    [[menu.main]]
      name = "Blog"
      url = "posts"
      weight = 1
    
    [[menu.main]]
      name = "Tags"
      url = "tags"
      weight = 2
    
    [[menu.main]]
      name = "About"
      url = "page/about/"
      weight = 3

プレビュー(http://localhost:1313)

    $ make run

## Github連携

config.tomlに以下の設定

    baseURL = "https://higebobo.github.com/buta7.netlify.app/"
    publishDir = "docs"

公開(githubにプッシュ)

    $ make deploy

## Link

* [Hugo \+ Github Pagesでブログを公開してみた \- Qiita](https://qiita.com/eichann/items/4fe61b8b9bbafcfbe847)
* [GitHub PagesとHugoでブログをつくった \- meow\.md](https://uzimihsr.github.io/post/2019-08-07-create-blog-1/)

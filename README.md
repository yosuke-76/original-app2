# アプリケーション名
---
## 喫茶 MyWorld

# アプリケーションの概要
---
私はInstagramで見かけるおしゃれな飲食店より、祖父母世代が営むようなレトロな雰囲気の喫茶店によく足を運ぶのですが、
高齢の方が営んでいるということもあるせいか、お店の情報を発信している事があまり無いように思いました。  
実際に足を運んでみると、同年代と思われる方も多くいるため、ジャンルを絞った発信の場所を設けることで、
さらにコミュニティーを拡大できると思い今回の開発に至りました。

# URL
---
* https://original-app2.herokuapp.com/

# テスト用アカウント
* ユーザー1
  email: test1@com  
  password: testtest1

# 洗い出した要件
| _機能_ | _目的_ | _詳細_ | _ストーリー_ |
| ----- | ------ | ----- | ----------|
| 他社API | GoogleMapを利用し位置情報の取得 | 入力された住所の位置情報を取得し表示する | 新規投稿、編集時に住所を入力すると自動で位置情報を取得し、詳細画面に表示する |
| フォロー機能 | ユーザー同士がフォローできるようにする | ユーザー同士がフォローでき、一覧画面で確認することができる | フォローする事でユーザー同士のコミュニティーが広がる |
| DM機能 | 1対1で会話をできるようにする | ユーザー詳細画面からトークルームを作成することが出来る | トークルームに遷移し1対1でやりとりをすることができる |
| いいね機能 | 投稿された記事にいいねをつけれるようにする | 他ユーザーの投稿詳細画面でいいねを付けることができる | 投稿された記事にいいねを押すことができる。押された投稿はマイページのお気に入り一覧に表示させることができる |
| 通知機能 | 他ユーザーからのアクションの通知が届くようにする | 他ユーザーからフォロー、コメント、いいねがあった場合に通知が届く | 通知が届いた時、通知一覧から各linkに遷移することが出来る |
| コメント機能 | 投稿された記事にコメントをすることが出来る | 投稿された記事にログイン中であればコメントをすることができる | 投稿された記事に対してコメントを残すことができる。コメントした場合他ユーザーのコメントも通知を受け取る |
| 複数枚の画像投稿 | 1つの投稿に複数枚の画像を添付することができる | 新規投稿、編集時に複数枚の画像を添付することが出来る | 投稿詳細画面でメイン画像とその他複数枚の画像を表示することができる |

# 実装した機能
* ユーザー管理機能
  - トップページのみ未ログインユーザーでも閲覧可
  - 初めて登録する際は新規登録、新規登録を済ませている場合はログインを行う
    ![ユーザー管理](https://gyazo.com/51df88f0af691a70a0efd4e8e758c998.gif)

* 投稿詳細表示、複数枚の画像投稿機能、他社API、コメント表示、いいね機能
  - トップページの画像をクリックすると投稿詳細画面に遷移する
  - 画像が複数枚ある時は1枚目をメイン画像とする
  - 投稿時に入力した住所に基づきGoogleMapに表示
  - いいね、コメントをする事が可能
  　　　　![投稿詳細](https://gyazo.com/4aa4e0b276e6d2660b850a496072ebb9.gif)

* マイページ機能、ユーザー編集機能、フォロワー一覧、
  - 投稿者名をクリックするとマイページに遷移する
  - 投稿一覧、いいねした投稿一覧を表示する
  - 自分のページの場合、ユーザー編集ボタンが表示される
  - 自分の投稿の編集、削除が出来る
  　　　　![マイページ](https://gyazo.com/faf59204f40337712a18757296fe517d.gif)

  - 他ユーザーの場合
     トークルーム作成ボタンとフォローボタンが表示される
     ![他ユーザー](https://gyazo.com/d8033a075b191c06df757377f9ab9bd5.gif)

* 通知一覧機能
  - ユーザーに対するフォロー、投稿に対するいいね、コメントを一覧で表示する
  - 各linkにて該当ページに遷移することができる
    ![通知一覧](https://gyazo.com/ac0371fdbc728524907eba1d3b6a66c6.gif)

* DM機能
  - トークルーム画面で各ユーザーとのルーム一覧が表示される
  - メッセージ画面では右側に自分、左側に相手のメッセージが表示される
    ![DM](https://gyazo.com/9eee6b68b1188e8377bc413d8e835690.gif)

# 工夫したポイント
  - GoogleMapを用いて位置情報の表示を行なったところ
  - headerを固定させスクロールをしても常に表示させているところ
  - コメントした投稿に別のコメントが付いた場合通知を受け取る

# データベース設計
![datebase](https://gyazo.com/32c5f5e952320a8286771e6ce574b9b5.png)

# usersテーブル
|  Column  |  Type  |  Options    |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| images   | string |             |

## Association
- has_many :messages, dependent: :destroy
- has_many :entries
- has_many :rooms, through: :entries
- has_many :likes, dependent: :destroy
- has_many :like_articles, through: :likes , source: :article
- has_many :comments, dependent: :destroy
- has_many :articles, dependent: :destroy
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
- has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
# articlesテーブル
|   Column   |    Type    |   Options                       |
| ---------- | ---------- | ------------------------------- |
| store-name |   string   | null: false                     |
|    text    |    text    | null: false                     |
|    user    | references | null: false, foreign_key: :true |
|   address  |   string   | null: false                     |
|  latitude  |   float    | null: false                     |
|  lomgitude |   float    | null: false                     |

## Association
- belongs_to :user
- has_many_attached :images
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :like_users, through: :likes, source: :user
- has_many :notifications, dependent: :destroy

# Commentsテーブル
|   Column   |    Type    |   Options   |
| ---------- | ---------- | ----------- |
|  user_id   |   integer  |             |
| article_id |   integer  |             |
|   text     |   text     | null: false |

## Association
- belongs_to :user
- belongs_to :article
- has_many :notifications, dependent: :destroy

# entriesテーブル
|   Column   |    Type    |   Options                       |
| ---------- | ---------- | ------------------------------- |
|    user    | references | null: false, foreign_key: :true |
|    room    | references | null: false, foreign_key: :true |

## Association
- belongs_to :user
- belongs_to :room

# likesテーブル
|   Column   |    Type    |   Options          |
| ---------- | ---------- | ------------------ |
|    user    | references | foreign_key: :true |
|   article  | references | foreign_key: :true |

## Association
- belongs_to :user
- belongs_to :article

# messagesテーブル
|   Column   |    Type    |   Options                       |
| ---------- | ---------- | ------------------------------- |
|    user    | references | null: false, foreign_key: :true |
|    room    | references | null: false, foreign_key: :true |
|   content  |   string   | null: false                     |

## Association
- belongs_to :user
- belongs_to :room

# notificationsテーブル
|   Column   |    Type    |   Options                       |
| ---------- | ---------- | ------------------------------- |
| visitor_id |   integer  | null: false                     |
| visited_id |   integer  | null: false                     |
| article_id |   integer  |                                 |
| comment_id |   integer  |                                 |
|   action   |   string   | null: false, default: ''        |
|  checked   |   boolean  | null: false, default: false     |

## Association
- belongs_to :article, optional: true
- belongs_to :comment, optional: true
- belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
- belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

# Relationshipテーブル
|   Column   |    Type    |   Options                       　　　　　　　　　|
| ---------- | ---------- | ---------------------------------------------- |
|    user    | references | null: false, foreign_key: :true 　　　　　　　　　|
|   follow   | references | null: false, foreign_key: { to_table: :users } |

## Association
  belongs_to :user
  belongs_to :follow, class_name: 'User'

# roomsテーブル

## Association
- has_many :messages, dependent: :destroy
- has_many :entries, dependent: :destroy
- has_many :users, through: :entries

# 開発環境
* フロントエンド: HTML/CSS
* バックエンド: Ruby on Rails/Ruby/JavaScript
* テスト: RSpec
* データベース: MySQL/Sequel Pro
* インフラ: Heroku
* タスク管理: GitHub/Trello

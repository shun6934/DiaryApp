# DiaryApp

- [DiaryApp](#diaryapp)
  - [What](#what)
  - [Purpose](#purpose)
  - [Function](#function)
  - [Environment](#environment)
  - [Set up](#set-up)
    - [Cocoapods](#cocoapods)
  - [Reference](#reference)
  - [Qiita](#qiita)

## What
カレンダーが表示されており、その日の出来事や自分の感想を書くことができる日記アプリ。

## Purpose
1. 日記を書くことで日常の整理をできるようにする。
2. 日記を書くことを週間づける。
3. 思い出を共有する。

## Function
- カレンダーが表示されており、その日に日記を書くことができる。
- ローカルに保存されているため、いつでも閲覧が可能になる。

## Environment
- Xcode 10.1
- Swift 4.2
- Realm 3.15
- Cocoapods 1.5.3

## Set up
1. AppStoreでXcodeをインストール
2. XcodeでCreate a new Xcode project を行い、プロジェクトを立ち上げる。

### Cocoapods
3. `sudo gem install cocoapods` でcocoapodsをインストール
4. `pod --version` で確認。
5. 開発ディレクトリに移動し、`pod init` でPodfileを作成。
6. Podfileを以下のように編集。

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '12.1'
target 'Diary_App' do
   # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
   use_frameworks!
   # 以下、追加
   pod 'JBDatePicker'
   pod 'RealmSwift'

   # Pods for Diary_App
end
```
7. 編集できたら、`pod install` でライブラリをインストール。

## Reference
- [Swiftで日記アプリを作ろう](https://qiita.com/ryoegu/items/1e5d1b8cadbf0061f6a7)
- [JBDataPicker](https://github.com/Tuslareb/JBDatePicker)
- [Cocoapods](https://cocoapods.org/)

## Qiita
このアプリについて記事を書いたため、載せておく。
1. [Realmを使用した日記アプリ](https://qiita.com/shun6934/items/e4e6e81cecf68b22bdc3)

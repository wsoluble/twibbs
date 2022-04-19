-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: 2016 年 12 月 12 日 04:20
-- サーバのバージョン： 5.5.42
-- PHP Version: 5.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `twibbs_samples`
--
CREATE DATABASE IF NOT EXISTS `twibbs_samples` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `twibbs_samples`;

-- --------------------------------------------------------

--
-- テーブルの構造 `_sample_comment_text`
--

CREATE TABLE `_sample_comment_text` (
  `sample_comment_text_id` int(11) NOT NULL COMMENT 'プライマリ',
  `comment_text` text NOT NULL COMMENT 'コメントサンプル'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='コメントサンプル';

--
-- テーブルのデータのダンプ `_sample_comment_text`
--

INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(1, '【津波情報】\r\n政府は、トンガ諸島の火山噴火による津波に関する官邸連絡室を設置しました。関係府省が連携し対応に全力を挙げます。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(2, '日本でも津波警報が出ている元となったトンガの噴火。windyの衛星写真がそろそろ見えなくなってしまうので〜。\r\n噴煙の大きさは北海道をほぼ覆うくらいの大きさ、恐ろしいのです…');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(3, '経理のDX、難しいこといわずに全員SQLとRDBやりましょうでよい気がしてきた。基幹システムのマスタとか見える世界がかなり変わるはず。\r\n\r\n流行りのPythonとか機械学習とかは後回しでもよくないですかね。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(4, 'Twitter いるとプログラマはみんな React さわれて Python も Go も Rust も書けて、なんなら言語処理系作れて自作 OS もやっちゃってる、みたいに感じるけど実際そんな人、雀の涙くらいですからね。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(5, '作品に罪はないので見るよ\r\n上の論理で言うなら\r\n「中古車でもベンツ」だから');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(6, 'SQL はそもそも抽象化を目指して作られているので、状況を合わせるなら「もっと低レベルの制御をするための言語が存在するべき」くらいのお気持ちがありますね。「Python で CPU の気持ちを想像するようになったら言語チョイスが間違っている」が近いかもしれない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(7, 'プログラミング言語の学習の前に、Linux環境で、Apache、PHP、MYSQLを設定して、WordPressの開発環境の構築までを調べながらでいいので、まず半日でできるかがエンジニアとして向き不向きの鍵になります。\r\nあ。私は元C/Sシステム系プログラマです。\r\n仕事がハードで体を壊して辞めました。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(8, 'MATLABの会社に勤めていると他の言語はやらないでしょと思われがちですが、実はやってます。今日はMATLABのサーバーを呼び出す処理をPythonでゴリゴリと。JavaScriptで以前書いた処理を書き直してました。VS Codeを使って。Stack Overflowに何度お世話になったことか号泣');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(9, 'おはようございます口を開けた笑顔\r\nちと寝過ぎました笑\r\n#今日の積み上げ \r\n中くらいの星サイト制作\r\n中くらいの星PHP&amp;MySQL\r\n中くらいの星各所連絡\r\n\r\n昨日zoom打ちで一気にやる事が明確になり、今月25日への納品に向けダッシュしますダッシュ\r\n\r\n皆さん、今日もよろしく〜片手を上げて喜ぶ男性');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(10, 'Docker でシンプルな Apache・PHP・MySQL の環境構築ができたので今日はねます…\r\n\r\nおやすみなさい寝顔');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(11, '①HTML/CSS\r\n②JavaScript \r\n③Vue.jsかReact\r\n④PHP \r\n⑤Laravel\r\n⑥MySQL\r\n\r\nまずはこの手順で学習すると、WEBアプリを作るのに必要な基礎知識が身に付きますイイね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(12, 'Reactを使うことによってjQueryスパゲティをuseEffectピタゴラスイッチに変えることができます');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(13, 'Reactの保守ができる人が抜けて、できる人探してるって見たけど、それってReactで作らない方が良かったのでは考えている顔と思ってしまったのう');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(14, '今日4社面談しましたが、React（TypeScript）とGo言語の実務経験が1年以上あって、両方できれば基本採用で落ちることないです。\r\n完全にチートできる。\r\nWeb開発やってる人は、マジでここ目指したほうが良いですよ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(15, 'React → 膝に矢を受けてしまってな\r\nPython → 膝に矢を受けてしまってな\r\nGo → 膝に矢を受けてしまってな\r\nRust → 膝に矢を受けてしまってな\r\nコンパイラ自作 → 膝に矢を受けてしまってな\r\nOS 自作 → 膝に矢を受けてしまってな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(16, 'Salesforce、AWSなどの外資ITに行った同期。\r\n給料上がったけど求められるレベルも高い。\r\nでも、口を揃えて「年収高い分、期待されてるし頑張らないといけない」と言って休みの日も勉強してる。\r\n人に投資することは大事で、自然と優秀層が集まる。行きたいと思える会社づくりしないとね！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(17, 'https://youtu.be/IpWx4bGsuPE\r\nhttps://nico.ms/sm9320604\r\nhttps://imgur.com/YavKS09');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(18, '#今日の積み上げ  \r\n\r\n白い太字のチェックマークAWS WEB問題集\r\n\r\nAWS WEB問題集をついに購入しました。\r\nudemyと違い、解説がドキュメントのコピペじゃないところが分かりやすくていい考えている顔\r\n\r\n明日もやります！！\r\n#AWS  \r\n#駆け出しエンジニアとつながりたい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(19, 'インフラを深く学習するつもりがない人でも、#プログラミング をやるんなら、ある程度知識がある方が有利なので、#aws を少し学習してみるのがおすすめですキラキラ\r\n\r\n#駆け出しエンジニアと繋がりたい \r\n#プログラミング初心者 \r\n#プログラミング独学');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(20, 'アプリケーションエンジニアだけどAWS触るってケースも最近増えてきて嬉しいことだけど知識不足は否めないしそこの教育も考えなきゃだよな\r\nQiitaとか本の内容コピって動きませんでしたって何度泣き付かれたことか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(21, '今日の積み上げ \r\n\r\n・AWSの学習\r\n・GitHubの草生やし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(22, 'ぶっちゃけAWSの環境構築なんて9割は社内のテンプレ展開してちょっと設定いじるだけで終わる\r\nそんなの3回ぐらいやれば誰でもできるようになるからインフラエンジニアが食っていくには残り1割のいつもの構成が使えない時に考えて組む知識といつ来るか分からない障害へ対処できる経験値が求められる');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(23, '今年の目標を明確にする\r\n\r\n1. エンジニアの基礎的な技術を固める\r\n- TCP/IP・DB・sql・正規表現・linux・nginx・docker\r\n\r\n2. 機械学習で、簡単なモデルの作成までできるように\r\n3. awsのSecurityの資格1つ取る\r\n\r\n全力で、エンジニア力UPに注力しつつ、合間合間のご褒美的な感じで、婚活に励みます');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(24, '身につける技術に迷ったら、以下から選ぶのがオススメです。\r\n\r\n白い太字のチェックマーク リモートワーク\r\nRuby、PHP、Go、Vue、React\r\n\r\n白い太字のチェックマーク 地方で安定的に稼げるスキル\r\nPHP、Java\r\n\r\n白い太字のチェックマーク とにかく金\r\nDevops＋上記言語＋AWS・GCP\r\n\r\n何事も目的からの “逆算” が大事\r\n\r\n#駆け出しエンジニアと繋がりたい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(25, 'IT & コンピュータ基礎知識\r\nLinux\r\nMac\r\nGit\r\nエディタ\r\nパッケージマネージャ\r\nHTML/CSS/JavaScript\r\nサーバーサイド言語とフレームワーク\r\nSQL\r\nAWS\r\n\r\n【言語・技術別】Webエンジニアのおすすめ学習本・サイトまとめ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(26, '【OCI Developer 2021 Associateの感想】\r\nOCIで実現されるサーバレスは、コンテナライクだなーと思いました。OKE, Functionsについては手を動かしながら学んでみたのですが、Functionsのコンソールから関数が書けないこと、VCNが必須というところはAWSとの大きな違いだなと驚きました。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(27, '単にAWSの利用経験があると言っても、単にEC2やRDSを使ったことがあるだけの人と、サーバーレスアーキテクチャやデータレイクアーキテクチャなどの構築経験や、非機能要件やコストなどを考慮したアーキテクチャの設計経験、AIやIoTなど先端技術のクラウド開発経験がある人とでは雲泥の差があります。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(28, '未経験からインフラエンジニアを目指すなら\r\n\r\n①CCNA\r\n②LPICレベル123\r\n③AWS CLF SAA SAP\r\n\r\nこの順番が最適解な気がしないでもない。余力があればITIL、応用情報、ネットワークスペシャリストもあり。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(29, '年が明けてだいぶ経ってしまいましたが、エンジニア転職して2年目に入りました初心者マーク\r\n年末からrailsとNext.jsの開発を担当し、β版プレリリースのため初めてのAWS ECSデプロイを終えたところ…（Next.jsはVercel様キラキラ）\r\n\r\n年始から燃えていますが今年も頑張ります号泣炎');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(30, '【エンジニアになるまでに学習した技術】\r\n・HTML/CSS\r\n・JavaScript\r\n・Ruby, Ruby on Rails\r\n・Linux コマンド\r\n・Git, Github\r\n・Docker\r\n・AWS\r\n\r\n個人的には Docker, AWS は後回しでもいい気がしてます。\r\nその分今めちゃめちゃ勉強中ですが笑\r\n他に意識したことは固定ツイートに。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(31, 'インフラエンジニアは\r\n・事業会社(内製化)\r\n・自社開発\r\n・SIer(CIer)\r\n・SES(高還元、派遣、フリーランス)\r\nに加えて海外企業などでも仕事が出来る可能性があるんですね考えている顔\r\n\r\nスペシャリストになりたいのか、PMがいいのか、経営幹部を目指すのか、コンサルかどれを目指すかでも変わってきそう');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(32, '古スタックエンジニアなのでLAMP環境構築できます！！！！！！！！！！！！！！！！！！！！！！！！！！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(33, 'LAMP環境構築できましたっ男性技術者太陽の光\r\n環境構築楽しいけどまじ疲れました。erernoteスクショだらけ！\r\nインフラの人すごいっす…\r\n\r\n今回はphpmyadmin使わずにデータベース使おうかなーと思ってます\r\nそっちのがかっけえじゃん！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(34, '会社員からフリーランスなった子に\r\n「希望単価ある？」\r\nって聞くと\r\n「25万ぐらいですかね？」\r\nと経験4年、LAMP環境／AWS／Laravelバリバリいける人に言われた。\r\nいやいや。。。君なら最低60はいけるで。。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(35, '便利になったけど、LAMP環境作ってコード書いてヨシ！みたいな大雑把な時代は終わったよなーー正直なところ雰囲気で使ってる技術も多い。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(36, '転職して数日ですが\r\n最近はまだ環境構築等してます。\r\n\r\nLAMP環境構築の時点で\r\nむずかしい..\r\n\r\nサーバーほとんどやったことないのでipconfigくらいのレベルでしかよくわからない..\r\n\r\nLinuxいじってますがこれもよく分からない..\r\n\r\nサーバーの勉強しないと、、\r\n何かいい参考書等あれば\r\n教えてください^ω^');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(37, 'サーバーサイド言語はPHPでよくあるLAMP環境で，O2Oっぽい感じの自社サービスをやっていってます。まだまだ社員数も少なくかなり自由な感じでやりがいも（ストックオプションもぼちぼち）得られる環境だと思うので興味があるWebエンジニアの方は是非！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(38, 'React(本命)とVue(浮気相手)の二股を1年間楽しんだ上で、Svelte (元彼)に戻ってきたんだけど、やっぱりSvelteは凄かった(語彙力)\r\n\r\nデザイナーやコーダーでjQueryから脱したい人は、ReactやVueよりSvelteを推す。教材を買わなくても公式チュートリアルで十分。\r\n\r\n今週末はSvelte Nativeで遊びたい！！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(39, 'これは凄すぎる。\r\n\r\n20個のWebアプリ開発を通して、HTML,CSS,JavaScriptを学ぶことができる「20+ Web Projects」。どれも頻出の実装かつ、開発しやすいものが厳選されているので、かなり勉強になる。\r\n\r\nhttps://vanillawebprojects.com');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(40, '私がJavaScriptの勉強をしていく中で大事だと思うのは、\r\n・Promise\r\n・プロトタイプ指向\r\n・イベントループ\r\nこの辺りが理解できていれば、他の言語を勉強するときも頭に入りやすと思うし。\r\nだから、この辺りをしっかり理解できるように時間を使うし。教える時にもじっくりやりたい。\r\n基礎は大事。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(41, 'JavaScriptの変数 [let / const / var]の違い分かりますか？\r\n\r\n・let → 再宣言×　再代入⚪︎\r\n・const →再宣言×　再代入×\r\n・var → 再宣言⚪︎　再代入⚪︎\r\n\r\n他にも生成されるスコープの違いなどがあります。\r\nこれを知れば「なぜvarが非推奨なのか」が理解できます食べ物を味わう顔');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(42, '僕はJavascriptとpythonしかやらないことに決めました。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(43, 'JavaScript\r\nメモアプリ開発 - リセット処理の実装\r\n\r\nボタンクリック時に表示しているメモの一覧を削除します。\r\n\r\n1. document.querySelector で要素を取得\r\n2. 要素.firstChild で先頭の子要素を取得\r\n3. 要素.removeChild で子要素を削除\r\n※2,3の繰り返しで子要素をすべて削除');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(44, 'コンピューター上で脳をシミュレーションできる→脳の仕組みが100％解明される→メタバース関連で脳とコンピュータをつなぎ始める→BMI普及、パソコンハッキングのように脳をハッキングできるようになる→脳ハッキングが社会問題化する!!');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(45, '誰でも簡単補修！レンチ男の子女性 🦰おばあさん赤ちゃん100点\r\n「oculus quest2 コントローラー ジョイスティック 修理~!\r\n\r\n超簡単！驚いた顔\r\n45秒修理！🏎');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(46, 'メタ傘下のオキュラスをＦＴＣ（米連邦取引委員会）が調査。オキュラスの価格が競合他社を不利な状況に置いている疑い。「オキュラス・クエスト２」の販売価格がＨＴＣなどから出ている一部モデルを大きく下回っている。\r\n\r\nQuest2安すぎて訴えられそうになってて草');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(47, 'VRのMMORPGってないのかな‥‥と思ってググったら普通にありました。しかもSteamでダウンロード可能。1月27日リリースらしい…！Oculus Quest、PSVRにも対応。\r\n\r\n剣よ魔法よ鮮やかに―VR対応MMORPG『Zenith: The Last City』リリース日が決定\r\nhttps://youtu.be/CWNtT8SMcpM');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(48, 'Oculus Quest改め『Meta Quest』、Facebookアカウント不要へ方針変更');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(49, 'OculusQuest2(MetaQuest2)でVRChatを始めたら\r\nわからない事だらけで最初は色々戸惑うと思いますけど、ここへ行けばすべてOK！\r\n\r\nという画像です\r\n\r\n#VRChat \r\n#Oculus\r\n#OculusQuest2');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(50, 'はじめまして！ジュートといいます！\r\n今はこの格好でうろついていることが多いです～！\r\noculus quest2を使っています！(*´▽｀*)\r\n見かけましたら仲良くしてやってくださいね～\r\nhttps://pbs.twimg.com/media/FJEZsllVQAAfO2m?format=jpg&name=large');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(51, 'Go Conference 2022 SpringのCFPがacceptされましたパーティーフェイスパーティーフェイス\r\nGo言語における最大級のカンファレンスです。\r\nCNDTに続いてこのような機会をいただけて大変嬉しく思います！笑顔');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(52, 'おれのイヤホンはちょいざぶろーだって言ってた');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(53, 'Rustも採用されててコードも綺麗なら尚更気になる。roseがGo言語だからGoの本買おうかなとか思ってたけど、rust気になってたから尚更気になる。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(54, 'Go言語初めての方へ\r\n\r\n公式が作ってる「A Tour of Go」というサイトがあります。サイト上の仮想環境でコードを実行できるので、ローカルで環境構築する必要はありません。\r\n日本語にもなってるので（たまに変な日本語ですが）、まずはここから触ってみましょうイイね\r\n\r\nhttps://go-tour-jp.appspot.com/welcome/1');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(55, 'C言語ってこんなに手のかかる言語だったな。。。\r\n特にファイルIO関連がヤバい。\r\n学生時代はC言語一色だったんだけど完全に忘れてる。\r\npythonの楽さに甘えすぎたわ。\r\n\r\n去年面倒だと思っていた、Go言語ですらパッケージが充実していて楽な部類だったのね。\r\n');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(56, 'Go言語で一番キツいのは使おうと思ったライブラリがメンテナンスされてないことが結構あることかなぁ。\r\n恵まれてるはずのJavascriptプロジェクトでも選択肢が少なかったりするし、ライブラリー選定も綱渡りである。どうしようもなければ自分でメンテするしかないぞ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(57, 'フリーランス案件の獲得ができて受注も安定してきたら、業界の傾向とかも見てみよう。\r\nとりあえず最近はWeb系がどんどん増えていることは間違いない…。\r\nあとはGo言語の需要も少しずつ高まっているらしい…');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(58, 'そろそろ人間的にアップグレードのためにGo言語くらい覚えないとダメなのかも知れない。\r\nコード書くのは苦手というか、綺麗なコードにならないから人に見せたくねぇんだよなあ…');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(59, 'しかしGo言語は自分で書いたのも他人が書いたのも関係なく読みやすいからすごい言語だよな。他の言語は他人の書いたコードは基本読み難いのにGo言語はそれがない。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(60, '帰ったら、KotlinとGO言語で作った\r\nDiscordのBot\r\nGitHubにリポジトリ置いとくかぁ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(61, 'Go言語には致命的欠陥がある。\r\n名前が一般的過ぎて、検索が困難すぎる。特にgoはとびぬけて最悪だと思う。\r\n名前に一般名詞や、ましてや動詞を付けるのはマジでやめたほうがいいと思う。\r\nPythonも蛇をググりたいひとにとってとても迷惑だとおもう。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(62, '私はGo言語のライブラリーを探すことが多いのですが、メンテナンス放棄されてるのが沢山あります。しかも代替品はない。\r\nこれがかなり悲しくてね。\r\n代替品がある言語は恵まれてると思うし、何かあったら代替品がでてくるなんて思わない方がよいですよ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(63, 'mariaDBはバージョンによってmysqlで使える構文が使えないので注意すること');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(64, 'mariaDBくん、generatedColumnsに NOT NULL 制約をかけられないので嫌い（ほんとは好き）\r\nhttps://jira.mariadb.org/browse/MDEV-7687');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(65, '去年の7月頃、新プロジェクトでRDBをどうするか色々悩んだ結果、MariaDB選定したのにも関わらず、本日MySQLへの移行を終えた僕の心境を140文字で答えなさい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(66, 'jQueryの学習終了。JSよりめっちゃ短くコードかけて便利！John Resigさんありがとうって感じほっとした顔他のライブラリも気になっていて、最近注目されているReactも時間作って学習しようこぶし\r\n\r\nそしてPHPとMariaDB(MySQL)へ突入！少しずつだけど出来ることが増えていくと、成長を実感できてモチベ上がる↗︎');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(67, 'MariaDBのdumpをBackupするバッチ処理\r\n\r\n１．開始ログ出力\r\n２．WindowsPCからLinuxサーバーへ接続しdump取得\r\n３．世代管理ツール（VBS）実行\r\n４．終了ログ出力\r\n\r\nすごく地味な処理だけど、サーバーやDBが死んだ時にこのdumpは【神】として崇められるファイルになる。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(68, 'カエルの顔今回ブログのローカル構築用は、LinuxでなくWIN上の仮想でする事にしたのでVMwareでなくメンテのことを考えてV-BOXでLinuxMintにApache+MariaDB+PHPでLAMP環境。サックっと進めるつもりが久しぶりで調整に小一時間だYO。時間切れでWordPress入れられず又来週ｗ XAMPPでやるべきだったなー(ToT)');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(69, 'MariaDB やっぱダメだな。OS再起動もしてみたけど状況変わらずだし、ログにもNoticeしか出てなくてエラーないしで困った。また再構築するか。XAMPPじゃなくて、Dockerコンテナだと安定するのかな。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(70, 'RDS・・・Aurora, PostgreSQL,MySQL,MariaDB,Oracle,SQL Serverをサポート\r\nAurora・・・MySQLの5倍、PostgreSQLの3倍のスループット。3箇所のAZに保存かつ1AZにつき2箇所のディスクに書き込み（計6箇所）');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(71, 'SQL のお勉強に\r\n最初に postgresql だの mysql だか mariadb とか大物立てようとして、挫けるくらいなら\r\nまずは sqlite から感覚掴めよ、とは思う\r\nテーブルの構成、インデックスの張り方、最初は試行錯誤せざる得ないし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(72, 'Ruby → PHPに負けてオワコン\r\nPHP → 小銭稼ぎ\r\nJava → SES向け業務価格\r\nC/C++ → Go に取って代わられつつある\r\nScala → 高単価\r\nPython → スクレイピングで小銭稼ぎ、または機械学習を名乗り詐欺れる\r\nKotlin → Android 専用\r\nGo → あと数年くらいでオワコン');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(73, 'もうクラウドばっかじゃね？って思ったら、企業の基幹システムは2023年でも8割がオンプレって言われてたり。PHPクソって言われ続けてると思ったら、世のWebサイトの8割が実はPHPだったり。jQueryってオワコンなんだぁと思ったら、まだまだ現役だったりと。今の世の中流行りと実態に差がありすぎでは？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(74, 'Rubyオワコンというツイートをチラホラ見かけるけど、PHPオワコンとかこれからPythonがくるって10年以上前から言われててこの状況なので、ギークな人の言語トレンド予測は基本信用してない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(75, 'Javaが「オワコン」なら分からんでもないんだけど、なんで「レガシー」なんだろうな。Pythonの公開はJavaより前、PHPはJavaと同時期に公開された言語だし、別にJavaが古い言語ってわけではないんだよな。\r\nPHPも古いバージョンで書かれたシステムたくさんあるだろうけど、なぜかレガシーと言われない。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(76, 'PHPはオワコンだ、なんだ言われてるが、\r\n・求人数が2020年1月以来834％と大幅に増加\r\n・実務経験1〜5年の平均給与は73,334ドル\r\nまだまだ現役笑顔とハート3つ安心天使の笑顔キラキラ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(77, 'Rubyオワコンって駆け出しエンジニアに発信してて、おすすめがHTML+JS+jQuery ってマジかってなるんだが考えている顔\r\nRuby個人的には嫌いじゃないんだけどなんとなくPHPに走っちゃうかなぁ〜考えている顔');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(78, 'webエンジニアにreact進めるのは分かるけど、webデザイナーにreact進めるのはどうかと。jqueryで十分でしょ。\r\nデザイナーはIAとかUI/UXとかイラレとかフォトショップとか、やること多いのに。求めすぎじゃない？CSSだって大変なのに。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(79, '【JavaScript勉強法】\r\n・ #Progate でES06シリーズを学習していく。\r\n・ドットインストールでサンプルアプリを全て作る。\r\n・オライリーの「開眼！JavaScript」を読んで理解を深める。\r\n・JavaScriptのライブラリ(JQuery)やフレームワーク(React.js)の勉強を始めてみる。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(80, '簡単・楽だからといって「もっとjQueryを使いたい!!!」となってjQueryばかり詳しくなる方がいますが、それはNGです。\r\njQueryから他のFW（React,Vueなど）へ発展させることはできず、その学習時間が徒労に終わる可能性大ですのでご注意をNGサインの男性\r\n');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(81, 'フロントの知識 jQuery でとまってるので、React やってみる！\r\nGo+Lambda と相性いい気がするんだよね、なんとなく\r\n\r\n立ち読みした結果カラーで見やすかったので\r\n#挫折しないReact本\r\n買ってみた。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(82, 'Web制作の勉強順序\r\nHTML/CSSの後はjQueryをやって動かす感動を覚えた\r\n今はReact.jsやレスポンシブもTailwindなど進歩は早いが基礎固めはしっかり目に\r\nモチベ保つにはどんなことでも「できた！」の感覚が必要\r\nfadeinの実装で感動したの今でも覚えてるくらい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(83, 'webサイトで動作させるなら断然jQueryだと思います。アコーディオン、タブ切り替え、ページの先頭に戻る、なんかのちょっとした動きは全部jQueryです。\r\nweb制作がメインなら、最初に勉強するのはjQueryで良いと思います＾＾\r\n個人的な意見ですが、ReactよりjQueryのほうがまだ理解しやすいｗ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(84, 'JSの基礎なんてさらっとでいいんですよ\r\n\r\n軽くjQueryを学んで、辛さをしって\r\n\r\nVueを学んでコードを書く気持ちよさを学んで\r\n\r\nNuxtで楽をして\r\n\r\nReactで設計とかを学んで\r\n\r\nあとはTSとかテストとかを頑張る');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(85, 'HTML, CSS, JavaScript, jQuery, Git, Github はフロントエンドだろうがバックエンドだろうが絶対です☀\r\n\r\nフロントなら TypeScript + React or Vue + UI/UX\r\nバックなら SQL + Java or PHP or Python or Ruby');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(86, 'JavaScript の Web UI 系ライブラリを色々見てるけど、やはり jQuery 依存のものは根強いな。そしてそれ以外は React コンポーネントのものが幅広く増えていっている。被りすぎだろって言うくらい。所々 Angular がある。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(87, 'ましかし、何もないところからjQueryとかを経てReactに至り、TypeScriptで型安全性をもたらし、esbuildやviteでラストワンマイルの開発体験向上を目指しているという、人類の涙ぐましい努力の軌跡なわけで。すごいね。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(88, '遡って見つけましたが、令和の今、わざわざ jQuery を使う必要はありません。\r\nプログラミング塾でも jQuery をカリキュラムに入れてるところがありますが、古いです。\r\nReactかVueを学んだ方が将来役に立つでしょう。jQueryを使う現場もあるかもしれませんが、たぶん古臭い環境です。無視でOK。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(89, '今回もハシビロコウが豪快にいっちゃってます... #公式 です。\r\nhttps://youtu.be/cpEidQMriG4');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(90, '＃野鳥動画＃日本の野鳥＃Japanese wild birds ＃4K動画＃鳴き声\r\n「日本の野鳥」としてアップして3年、好評につき過去の動画に加え新たな野鳥を含め70種を「新日本の野鳥」としてアップする事にしました。\r\n\r\n関連動画\r\n※映像で見る野鳥と風景\r\nhttps://youtu.be/Kek51HVxdO0\r\n\r\n※四季の野鳥\r\nhttps://youtu.be/l1AVQXtalCg\r\n\r\n※映像で見る野鳥と風景\r\nhttps://youtu.be/Kek51HVxdO0\r\n\r\n※猫のためのビデオ 見る - 私の庭の鳥\r\nhttps://youtu.be/CHsQ53smlnk');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(91, 'あまり逃げないハトが来たので、手に乗せてみる～その正体は凄い鳥だった★\r\n庭を見たら、ちょっといつもと違うハトがいました(๑˙❥˙๑) \r\nおとなしいので手に乗せて搬送。\r\nそれは実は凄いハトだったのです( ´;ﾟ;ё;ﾟ;)\r\n\r\nドバト レース鳩 ビオトープ 狭山丘陵\r\nバードウォッチング 野鳥 餌台 えさ台\r\nエサ台\r\nhttps://youtu.be/94XXSIYrGTk');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(92, 'そろそろ田んぼ道でも沢山の野鳥が見られるようなので、\r\n農耕地を歩いて、探してみようと思います！\r\n\r\n冬の小鳥たちが、よく野鳥が食べているアレとは？\r\nそんな気になる疑問にお答えするべく、\r\nカメラを片手に映像でお届けします！\r\n\r\n今回はどんな野鳥たちに出会えるのでしょうか？\r\nhttps://youtu.be/Ng5JywRqdtM');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(93, '水中に飛び込み魚を仕留めるカワセミ。磨き上げられた飛行技術と鋭く強いクチバシは狩りだけに使われるわけではない。\r\nhttps://youtu.be/DAgesR6bk90');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(94, 'カワセミのさえずり。雄雌2羽が近くで鳴き合ってた。下の嘴が赤いのがメスだよ。地鳴きもほとんど声質は変わらないみたいだね。\r\n📷【猛禽類の捕食をカワセミが露骨に警戒】\r\nhttps://youtu.be/1keYo8fdMVM\r\n\r\n📷【カワセミがザリガニを捕食】\r\nhttps://youtu.be/qkXztx742E4\r\n\r\nhttps://youtu.be/NEJ8c517y_8');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(95, '宝石、瑪瑙、クリスタル、ゴールド。 山中の火山岩を発掘\r\nhttps://youtu.be/4VD3rVEIfkI');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(96, '山の中に「ガマ」と呼ばれるポイントがあるそうです。\r\nそこには水晶などがたくさんあるそうです。\r\nhttps://youtu.be/_m4oGSthRc8');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(97, 'アメジストの正式名称はアメシストらしいです。\r\n昨日新産地を見つけたので次回はそこを攻めていきたいと思います。\r\nhttps://youtu.be/rtP-7B8Nd2s');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(98, 'たまた鉱物採集に同行させてもらいました。\r\n表面が細かい水晶だらけの岩を割ってみた動画です。（見つけたのは自分ではありません）\r\n\r\n軽い力でタガネがどんどん入っていくので驚きました。\r\nhttps://youtu.be/EKV_gRi9OLk');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(99, 'I wish to follow a day life of Shoebill Stork inhabits in Mabamba Swamp in Uganda.\r\nウガンダ、マバンバ湿地に生息するハシビロコウの生態を追ってみます。\r\nhttps://youtu.be/IYhw2soy8So');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(100, '運動場を行ったり来たり～遊具に上ったり下りたり～と\r\n歩きまわる「楓浜」。\r\nベストポディションを見つけると丸くなってお昼寝し始めました♪\r\nhttps://youtu.be/1aUSfxrAA94');

-- --------------------------------------------------------

--
-- テーブルの構造 `_sample_thread_title`
--

CREATE TABLE `_sample_thread_title` (
  `sample_thread_title_id` int(11) NOT NULL COMMENT 'プライマリ',
  `thread_title` text NOT NULL COMMENT 'スレッドタイトルサンプル'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='スレッドタイトルサンプル';

--
-- テーブルのデータのダンプ `_sample_thread_title`
--

INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(1, '207で1年間磨き続けた1on1のフォーマットを公開します ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(2, '受験生ら切りつけ 逮捕の高2「事件起こし死のうと思った」供述');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(3, 'トンガで大規模噴火 周辺で1m近い津波発生 日本 被害心配なし');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(4, 'オミクロン株感染、NYなど米大都市で収束の兆し');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(5, 'Twitterの「クソリプ」を追跡して精神の病み具合を調査しようとした結果「ブロック」や「ミュート」機能の意味を理解した');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(6, '「負の遺産」清算、懸案先送り　内閣支持率が異例の上昇―時事世論調査');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(7, 'トンガ近くの火山島で再び大きな噴火衛星画像で巨大な噴煙捉える');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(8, 'マクドナルドはなぜ国産じゃがいもを使わない？　ポテト販売休止でTwitterに流れるウワサ、真相を取材した');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(9, 'ゆうちょ銀行 硬貨預け入れに手数料 17日から枚数に応じて');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(10, '太陽光パネル“大廃棄時代”がやってくる');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(11, 'ケーキ屋さんが『洋生菓子は原価が高く、売れ残るとすぐ廃棄。我々は焼き菓子でしか粗利を稼げない』と言うのでこれからは焼き菓子も併せて買いたい');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(12, '視力回復のための白内障手術を受けた高齢者は認知症が発症しにくくなるという研究結果');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(13, 'アビゲイル・シュライアー：「恐怖の時代における自由」 ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(14, '新型コロナウイルス、空中で20分後には感染力の大部分失う－英大調査');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(15, '池の水ぜんぶ抜いたら「完全な状態の巨大な魚竜の化石」が出てきた（英国）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(16, '【宝石】404カラットの巨大ダイヤモンド、アンゴラで発見');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(17, '【国内】＜甲状腺がん＞福島の子ども「数十倍」…放射線の影響否定的　[毎日新聞]');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(18, 'NASAがクマムシを「光速の30%」まで加速させる宇宙飛行計画を発表');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(19, '男児＝大荷物　女児＝小荷物　死刑判決受けた河南省「人さらい」組織の信じられない悪事の数々…');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(20, 'はるかな未来から少し先のニューノーマルまで、パンデミック後の多様な世界を表現する韓国ＳＦアンソロジー──『最後のライオニ 韓国パンデミックSF小説集』');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(21, 'Qiita記事「エンジニアの\"有害な振る舞い\"への対処法」への強烈な違和感');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(22, 'SQLクエリを実行、可視化できるウェブアプリ「SQLPad」を試してみた');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(23, 'Python開発者のためのセキュアコーディングのコツ10個');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(24, 'clapでシェルの補完スクリプトを生成する');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(25, '廃棄物処理施設などで発生する廃熱使い水素、燃料電池車に　トヨタと愛知県が実証実験');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(26, 'これはかなりオススメの良書！ 最近のWebデザインのアイデア・作り方がよく分かる -Webデザイン良質見本帳');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(27, '「Blender」で作ったかわいい怒り顔を「3tene」で使えるようにする方法');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(28, 'Mac版「OneDrive」のファイル オンデマンドが刷新、「macOS 12.1」以降で利用可能に');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(29, 'Google、オープンソースソフトウェア保護に官民の協力を呼びかけ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(30, 'Windows 11で必須になったBIOS（バイオス）の後継者「UEFI」って何なの？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(31, 'アップルのＶＲ／ＡＲヘッドセット開発遅れ、来年発売の可能性も');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(32, '自然な日本語ダミーテキストを生成するWebアプリを作りました');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(33, 'AWSのマルチアカウント戦略ってなに？なぜ必要？【社内勉強会スライド】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(34, 'Web3時代はすぐそこか？ 暗号資産・ブロックチェーン業界を牽引する52人の「2022年の展望」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(35, '全世界を揺るがした「Log4j」のようなオープンソースソフトウェアを無償でメンテし続けるという難題を解決すべくGoogleが立ちあがる');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(36, 'たった2ヶ月半でSLOを導入して事業判断に影響を与えた話');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(37, '2022年1月セキュリティパッチでWindows Serverが勝手に再起動');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(38, 'グーグルとIBM、重要なオープンソースプロジェクトの特定を呼びかけ--「Log4j」問題を受け');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(39, 'ロボット不具合「原因分からない、見通し不明…」　福島第一原発1号機、高線量の内部調査に高い壁');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(40, '2日目：Python 3.10新機能パターンマッチの神髄がわかる');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(41, '仮想通貨・ビットコインの開発者を訴訟の危機から保護するための基金「Bitcoin Legal Defense Fund」をTwitter創業者のジャック・ドーシーが立ち上げ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(42, '世界的エンジニアが株主として提案。ソニーが撤退すべき分野、分社化すべきビジネス');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(43, 'オープンソース開発者が広く使用されている自分のライブラリを改ざん、大量のプロジェクトに影響');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(44, 'なぜ人工衛星開発スタートアップで元ウェブ系エンジニアが快適に働けているのか');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(45, '【朗報】「俺の嫁」が3Dになる時代らしい');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(46, '急なTypeScript案件🔥最初の30日間に使い倒したい「コードリーディング支援ツール」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(47, 'オンプレからクラウドへの移行の2年半の軌跡');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(48, '永久保存版！エンジニア向け情報収集サイトをまとめてみた【定期更新】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(49, '新旧両極端の「Rust」と「COBOL」、両方学んで最強のソフト開発者に');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(50, 'イーサリアム開発者の２０２２年年頭におけるこれまでの振り返り');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(51, '雰囲気でOAuthを使っていたエンジニアがOAuthサーバ(RFC6749)を自作してみる');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(52, 'IT人材 2021年まとめと2022年トレンド予測：難航し続ける採用と定着');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(53, '技術系スタートアップが在宅勤務のソフトウェア開発者を大切に扱うための5つのヒント');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(54, 'Staff EngineerとSenior Engineerの違いを知る「Staff Engineer」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(55, 'クラウドを扱うエンジニアにとって「Terraform」は必須ツール!? 〜エンジニアが語る技術愛');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(56, '高速で開発者体験も抜群！JavaScriptフレームワークの新星「Svelte」とは何か？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(57, '挑戦する組織にするためにCTOになってからやったこと');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(58, 'サーバーサイドエンジニアとして2021年に使った技術と来年の目標');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(59, 'Ruby 3.1はここに注目！ 新しいJITとは？ デバッガ、エラーメッセージ、そして未来！ リリースマネージャーに聞いた');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(60, '食べログの大規模なエンジニア組織を段階的に改善していく取り組み');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(61, 'Apple、開発者にApple Developer証明書の更新について通達');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(62, 'CTOが選ぶ、エンジニアのみなさんに個人的に読んでほしい本');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(63, 'pingcap/parser (MySQL互換) で SQL を手軽に解析');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(64, '私がデザインエンジニアになるまでのキャリア');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(65, 'Reactの何がエンジニアを夢中にさせるのか');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(66, 'サーバサイド開発にKotlinを全面採用！ ビヘイビア駆動開発（BDD）をマイクロサービスに導入するNewsPicksが求める開発者体験は？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(67, 'Flutterに出会ったことで脳汁プシャーになった話');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(68, 'UIデザインをきちんとエンジニアに伝えるための、イケてる設計資料を定義してみた');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(69, 'デザイナーとエンジニアを巻き込んだワークフローの改善');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(70, '外部サービスの不確実性をハンドリングする設計戦略');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(71, 'エンジニアも見ておきたいGoogle Search Consoleの機能 5選');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(72, 'CircleCI に入社してちょうど2ヶ月がたちました');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(73, 'マークアップエンジニアからフロントエンドエンジニアになった道のりを晒す');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(74, 'エンジニアリングマネージャーとしての開発力向上の取り組みついて');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(75, '初心者向けCSS floatプロパティとは？基本の使い方について解説！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(76, '「技術に興味がないエンジニアほど大手にいくべき。メール転送で食っていけるぞ」→「羨ましい」「リストラされなければ最強」「定年まで逃げ切る」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(77, '「負債のないシステムはない」「過去との対立じゃなく、いまの問題を解きたい」メルカリ基盤刷新に挑むPJOの胸のうち');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(78, '元JavaエンジニアがGoに感じた「表現力の低さ」と「開発生産性」の話');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(79, 'AWS移行のため、大規模で複雑な負荷テストをやった話');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(80, 'Web開発者のみでCapacitor を利用し、3ヶ月でモバイルアプリをリリースした話と、展望');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(81, 'フロントエンドエンジニアがWASM(Rust)でWebアプリを作ってみた');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(82, 'DMM.comのクリエイティブな組織への取り組みとVPoEの役割について');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(83, 'インフラエンジニアの業務で部分的にスクラムを取り入れている話');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(84, '「痛感したのは、映画への敗北感」“体験型エンタメ”『劇場版スタァライト』古川知宏監督が明かす、シネスコ画面の裏側');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(85, '宇良を襲った悲劇　相撲協会は相次ぐ事故をなぜ放置するのか');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(86, '初心者の男性だけどここに書いてあるのは難しくて読めないのばかりだったんだけど？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(87, '「ミステリと言う勿れ」原作第１話の「娘が父親を嫌うのは遺伝子上の理由」が、ドラマ化でカットされ逆に注目集まる／「ポリコレアフロ」の異名は蔑称？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(88, 'Apple Watchで「プリンス・オブ・ペルシャ」Web版がプレイ可能と話題');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(89, 'ゲーム会社の「アイデアの押し売り」への防衛策が注目集める。一方的に送りつけられたゲームのアイデアが行き着く先とは');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(90, 'Mirrativの新境地「ライブゲーミング」が月商1億円のヒットにーー配信者が稼げる国産スマホメタバースは拡大フェーズへ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(91, 'Xbox責任者、PS陣営とともに共通の害悪プレイヤーリスト作りを望む');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(92, 'ソニーが「PS5」不足のため「PS4」の生産終了を撤回したとの報道');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(93, 'リアルロボットアニメとそのプラモデルの黄金時代はたった4年しか続かなかった、という話。');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(94, 'VTuber支援サービス『Vカツ』サービス終了、今後はアバター使用も禁止。いきなり肉体を失い、さまよえる美少女の魂が続出のおそれ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(95, '中高生国際Rubyプログラミングコンテスト2021 in Mitaka 最終審査会参加報告 & ピクシブ賞受賞者インタビュー');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(96, 'DevOpsとは開発チーム自身が運用できるようにすること');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(97, 'ブラウザでTCPを直接送受信できるDirect Sockets APIについて');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(98, 'React の新しい概念「トランジション」で React アプリの応答性を改善する');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(99, 'Rustを使ってスケーラブルなプログラムを書く方法');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(100, 'Access-Control-Allow-Origin に設定する値として\"マシ\"なのはどちらか');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `_sample_comment_text`
--
ALTER TABLE `_sample_comment_text`
  ADD PRIMARY KEY (`sample_comment_text_id`);

--
-- Indexes for table `_sample_thread_title`
--
ALTER TABLE `_sample_thread_title`
  ADD PRIMARY KEY (`sample_thread_title_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `_sample_comment_text`
--
ALTER TABLE `_sample_comment_text`
  MODIFY `sample_comment_text_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';
--
-- AUTO_INCREMENT for table `_sample_thread_title`
--
ALTER TABLE `_sample_thread_title`
  MODIFY `sample_thread_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

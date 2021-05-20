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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='コメントサンプル';

--
-- テーブルのデータのダンプ `_sample_comment_text`
--

INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(1, '確かにＮＨＫが放送すべきアニメじゃないよな。\r\n内容が低俗だからＮＨＫにふさわしくないという話ではない。ＮＨＫなら過去に自局で発注製作した名作アニメが\r\n沢山あるのだから、ラブライブを放映する枠はそういうＮＨＫ過去名作アニメの再放送に当てろということ。\r\nＮＨＫは受信料で経営しているのだから、ラブライブ観たいやつはＮＨＫで観るのではなく、円盤買って観ろってことだ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(2, 'しかも深夜帯ではなく午後の日中にやるらしい。\r\nあんな低俗なオタクアニメぜひ、やめてくれ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(3, '金払ってんだから一緒だろ\r\n受信料払えば良いアニメを放送してくれる\r\nその受信料を払う視聴者の中にラブライバーがいる\r\nだから円盤だけ買えばいいってもんじゃない\r\n円盤を持っていてもさらにその上に野望があるから\r\nしかも売り上げも良いしラブライバーも他のことに出費を削ってもちゃんと金をかけている\r\nなのでNHKの放送は当然\r\nEテレで放送して欲しい深夜アニメがあるなら、円盤だけでなく受信料も払うことだ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(4, 'いつからそうなった！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(5, '作品に罪はないので見るよ\r\n上の論理で言うなら\r\n「中古車でもベンツ」だから');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(6, '何が嫌いかより何が好きかで自分を語れよ！！！！！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(7, 'ルイズコピペとブロリーさんとトランクスさんはとっくにNG済み');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(8, 'これ見てあったかあったかしよっ\r\nhttps://youtu.be/8fjjCg8FySE');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(9, '流石にもう十四メイン回は来ないだろ\r\n来るなら19話からつまらなくなるとはあの監督は言わない\r\nおそ松チョロ松にメイン回が来てもいい頃だろ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(10, 'まだメインの出番少ないキャラもいるから今後に期待してたら\r\n「19話以降はクッソつまんなくなります」とかふざけてんのか監督\r\nメイン回確定してるトッティとかチョロ松とか本当にどうでも良く思ってんのな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(11, 'おそ松は実際笑えないクズ描写あるけど\r\nチョロ松はなカラ松もだけど');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(12, 'そしてメイン回少ないなと思ってたところに\r\n>>4の上三人は笑えないクズモンスター発言\r\n好みじゃないから出番少ないのかとか疑ってしまう');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(13, 'おそ松とチョロ松は兄弟の紹介係って感じだな～\r\nチョロ松はもう前半で説明役として終わった感じを受けたしな\r\nカラ松も救済回はなしか…トトコも最近メインで見てないなぁ\r\n配分がおかしいって思わなかったんだろうか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(14, '１０年前に涼宮ハルヒの踊りをしていた大学生が今では３２歳ぐらいだ。\r\n\r\nまた９年前に「らきすた最高」と叫んでいた当時４５歳の萌えオタクは\r\n今では５４歳の爺さんだ。\r\n\r\nもう涼宮ハルヒやらきすたは宇宙戦艦ヤマト並みの古さが出ている');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(15, '>>18\r\nというか初音ミクというキャラに惚れ込んでミク曲聞いてる人が今の若い子にいるのかって話で\r\n「歌ってみた」のための叩き台以上の価値は既になくなってる\r\nhttps://www.youtube.com/watch?v=3Q328c1lBM8');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(16, '第三世代のエヴァおたくや、第四世代のボカロ萌えおたくは大きな市場になると\n期待された時もあったが、市場として成長せず、すでに衰退になってる。\n\nようは９０年代の第三世代エヴァおたくからして、パフォーマンスとしてのおたくであり、\n趣味にお金を使う気はさらさら無かったという分析もできるはずだ。\n\n９０年代においてすでに今日の第五世代おたくの先駆け的存在はおり、\nそれがいまや若いおたくの多数派になったわけだ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(17, 'あの花は、最初は俺たち世代向けかと思ってすげぇ期待してたら\r\n単なる恋愛ドロドロ話になっていって幻滅を禁じえなかった');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(18, 'ドロドロ苦手なので見なかったけど\r\nまわりの評価が良くて後悔した>とらドラ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(19, 'とらドラって逆恨みしたヒロインが主人公宅にバット持参で強盗殺人未遂で殴りこんだ挙句\r\n「よし、明日から俺が面倒みる」とか訳のわからないはじまり方したやつだっけ？\r\n上記と後半が糞だった記憶は有るが内容は良く覚えてない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(20, '俺は無視して熱く語るけどな\r\nカラオケでも無視してアニソン連発するしｗ\r\n\r\n顔文字に関しては、年代関係なく好き嫌いはあるんじゃね？\r\n俺も好きなタイプじゃないが、;)とか:Dとかlolとかを使うときくらいはある\r\n後最近は、AFKっつっても解らない人多いよねｗ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(21, 'このすばが全10話なのが残念でならない\r\n声優がいい仕事してる');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(22, 'どれに返レスすればいいのかわかってない俺は\r\n一度睡眠をとって出直してきます');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(23, '>>５５\r\n本当ワンパだよなこいつ\r\nワッチョイあるとグリムガル信者は書き込めなくなるだろマジで');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(24, 'ほんまこのアニメ女キャラだけはいいな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(25, 'OPみんなラッシュガード着てるけど、本当は全裸にしたかったんだろな\r\nあまり動きや変化がなくて、今までのでも良かった');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(26, 'ユメが神官か聖騎士に転職したらいいんだけど\r\n弓がないと不利な状況ってのもあるんだよな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(27, 'ランタがいなくなったら、\r\n「ランタうざいよねー」「なー」「うん」「同意」\r\nて共通の話題がなくなっちゃうだろ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(28, '今回作画崩れや手抜きが多かったね、中盤のモグにカブト買ってやろうとか言いながら歩くシーンで\r\nバストアップだけで足は描かず、先行してるハルピとモグはまだ歩いてるように見えたが後ろのユメは\r\n微動だにせずするする移動してて空中浮遊してるみたいだったし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(29, 'MMOではヒーラーがパーティーを管理するのが当たり前だから\r\nhttp://i.imgur.com/l3rIGCL.png');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(30, '今期一番すきかもわからんわ。リアルとファンタジーのバランスがいい。はじめてネトゲーしたときの感覚と似てるわ。\r\n\r\n薬草、ポーションないのかなとも考えるけど、薬草は即時回復ではないから、戦闘で使用するものとはちがうんだろね。\r\nポーションは神官がかなり重要視されている世界であると考えると、ポーションが即時回復であるならかなり高価なものなんだろうし、即時回復でないなら借りにもっていく必要がなさそう？\r\n\r\nという妄想。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(31, '薬草・傷薬に包帯があれば戦闘後のかすり傷の治療に余分なMP使わずに済んで合理的だと思うがなあ\r\n一般人の生活にちょっとした日常薬がないとか考え辛いし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(32, '◆FAQ\r\nQ.原作はWEB版なの？\r\nWEB版は既に削除されました。アニメは書籍を元に作られています。\r\n\r\nQ.1話Aパートでアクアの後に来た天使ってエリス？\r\nただの名もないモブ天使です。\r\n\r\nQ.荒くれ者って原作にいないよね？\r\nアニメオリジナルキャラです。\r\n\r\nQ.原作のどこまでするの？OPにゆんゆんいるけどアニメに出るの？\r\nペース配分的にアニメはおそらく1巻もしくは2巻で終わるはず。\r\nゆんゆんはOPサービスだけで本編登場は6月発売のOVAに出ます。\r\n\r\nQ.10話って聞いたけど分割2期とか決まってる？\r\n10話＋OVAで始まった角川アニメが分割2期決まってる可能性はほぼ無いです。\r\n\r\nQ.アクア様はパンツ履いてないんですか？\r\nA.原作では縞パン履いてます。アニメでは今のところ履いてない可能性を否定できません。\r\n\r\n以上テンプレ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(33, '原作に日本回があってカズマの部屋がなんとかという話があるとこのスレで見た\r\nでもweb版読んだがそんなのなかったぞ\r\n一体どれのことを言っていたんだ\r\nそれとセレナさんのキービジュアルが早く見たいです');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(34, '>>5\r\nいいと思います\r\n書籍口絵のため閲覧注意↓\r\nhttp://i.imgur.com/nhyRlQE.jpg');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(35, 'ピュリフィケーション\r\nhttp://fantasy-academy.bona.jp/dict/term_h/purification.html');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(36, 'このすば(この素晴らしい世界に祝福を!)っていうアニメ見たんだけど\r\nhttp://anond.hatelabo.jp/20160214233846');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(37, 'ダクネスは頼み込めばやらせてくれそう');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(38, '俺TUEEEはもうアホが気に入らない作品を貶すための都合のいい言葉に成り下がってるからな\r\n主人公が普通に活躍するだけで俺TUEEE呼ばわりする奴もいるし\r\nチョン、ネトウヨ、ブサヨ、ゆとり、アスぺみたいなもん');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(39, '主人公な以上はある程度目立つのは仕方なくね？\r\nなにか倒したらＴＵＥＥＥという何でもあり理論は正直アホ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(40, 'なんでもいいがスレチだろ\r\n第一このすばはめぐみんの可愛さを愛でるアニメだろうに\r\nアクア……？　ダクネス……？　知らない子ですね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(41, 'バニルの声は小山力也。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(42, '17話終盤　三日月「凄いな・・・」\r\n18話序盤　三日月「凄いなあいつ・・・」\r\n18話中盤　三日月「凄いな・・・」\r\n18話終盤　三日月「凄いよお前・・・ 」\r\n\r\n↑酷すぎ\r\nまともな脚本ならたとえ言葉は同じでも何かしら状況に差異があって\r\nそれを対比することによって変化なり成長なりを表現するもんだが\r\n\r\n人間ドラマ（笑）に1話まるごと使って主人公が壊れたテープレコーダー状態って・・・');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(43, 'マジ気違いだろあいつ\r\nなんで大澤なん？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(44, '>>1\r\n乙だぜ兄弟');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(45, 'グレイズかっこいいよね。俺の女友達もプラモ買ってたよ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(46, 'だって日常回はあんまり面白く無いんだもん');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(47, 'ガンダムシリーズには珍しく、高価な宇宙艦がMSの一撃で沈まないのはいいな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(48, '次の視聴率どれだけ落ちるか楽しみ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(49, '戦闘になると三日月が好きになれない\r\n非戦闘時はそこまでじゃないんだけどなぁ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(50, 'そりゃなんも描いてないし\r\n伏線張る能力が脚本家にないから\r\n死ぬ直前まで掘り下げができない\r\nアインで十分にわかったことじゃないか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(51, 'ひょいなの？\r\nオレもちょいさぶろ－！かと思ってた\r\nどう聞いてもちょいさぶろうだろ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(52, 'おれのイヤホンはちょいざぶろーだって言ってた');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(53, '>>32\r\n７巻の終わり頃なら。\r\nアニメだと４期だけど。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(54, 'これグレーテルもヒロインなんですよね？！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(55, 'お外は寒いからね\r\n抱き合うのが一番だね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(56, '正直見るからにモブっぽいマナトが死のうがどうしようがなんとも思わない。\r\nどっちかというとあのうるさいアフロが死んだほうがインパクトあった。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(57, '一話でマナト死亡をやってから回想に入った方が良かっただろうな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(58, 'ランタうざいとか要らないとか言われてるけど\r\n仲間をかばって今でのことを詫びるような事言いながら死んだら皆（視聴者、ユーザー）正直泣くと思う');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(59, '皆ウザい言うけど原作読んでもそこまでウザくないと思った\r\n2chのファビョっぽく見えても実はヒートアップして悪化してくわけでもなし、\r\n謝ったり退くことのできる子だし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(60, 'どうせランタうざい、メリイ死ね言ってるやつは主人公に自己投影して見ちゃってるお子様だろ\r\n今のとここの作品に擁護しようのない本物の屑なんてまだ現れてないしな\r\n\r\n僕だけがいない街とか観たら登場人物に文句言いまくってそうだな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(61, '絵を見せたい、音楽を聴かせたい\r\nこれは成功してるこのバックボーンをどうとるかだな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(62, '今回も安定して面白くないなｗ\r\nハクが置き去りにした補給部隊がどうなったかちゃんと描写しろよｗ\r\nカミュにボコられたとか前作見てないとわからんだろｗ\r\nキウルはクオンをあからさまに無視するし脚本は考えて仕事してるの？ｗｗｗ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(63, 'しかしクオンもなかなかの策士だよな\r\n補給隊を分断させるため裏道に誘い込んだのも罠だよ\r\n見事成功させた\r\nヤマトに勝ち目はない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(64, 'でも前作みててもつまんねーよｗ\r\nつか偽りなんて作らなくてよかった\r\nうたわれのツラ汚しだよ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(65, 'アンチは今日も忙しいなぁ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(66, 'アニメでは描写されてないから脳内補完だ、頑張れ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(67, 'ココポだけがムックルに気付かなかったら、\r\n普通に襲撃してきてたんだろうか\r\nというか、「ココポだけが野生の感覚でムックルを感知できる」とか\r\n「ココポだけ崖下り出来る」とか\r\nココポのスペックを知り尽した上での分断策だよなぁ\r\n\r\n仲が良かったムックルがアルルゥに教えたんだろうか\r\nたしかアルルゥ、動物と会話できる設定だったし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(68, '海のソヤンケクル\r\n\r\nアトゥイのお父ちゃん\r\n強烈な親バカだが八柱将の一人\r\n\r\n↓\r\n\r\nhttp://i.imgur.com/GvnvT9J.jpg\r\nhttp://i.imgur.com/FtXThbf.jpg\r\nhttp://i.imgur.com/KysRy04.jpg\r\nhttp://i.imgur.com/BJ5BoH3.jpg\r\nhttp://i.imgur.com/el63AdJ.jpg');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(69, 'そう疑うのが普通だよな。なんか今回色々スカスカしとるわ\r\nココポ暴走で補給部隊と離れるとか、罠と疑って全員相当焦っても良いレベル\r\nあと補給部隊引き返したのはかなり判りづらいわ\r\n\r\nしかし荷車一台分では部隊全員の一食分にも満たないだろうにどうすんねん');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(70, '一番可愛いのはムネチカさんだよ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(71, '今週も荒れるから信者は目とじ耳をふさいで\r\nこのスレには近寄らない方がいいぞｗ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(72, '原作でのあの戦闘シーンにおもいっきり力を入れるために\r\nここ２回は力をセーブしたと信じたい\r\n前作からのファンの人たちには最高のシーンだろうしね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(73, '良いのか悪いのかわからんけど\r\n今年のプリキュアって全然プリキュアっぽくないね\r\nほんとに児童向けになった感じ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(74, 'ドクロクシ―はリンクルストーンエメラルドに魂を封印されているとか?');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(75, '改めて並べてみても、育代さんのデザインや雰囲気だけやっぱ異様に浮いてる気がする。\r\n具体的にどこがどうと聞かれると説明できんが。\r\n現在進行形で薄い本が出続けるプリキュアのサブキャラなんかこの人くらいだしなあ……');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(76, 'ニア「いいえ、あなたはただのカタツムリです」');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(77, '完治はできないが薬で抑え込める感じかね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(78, '2話まで見る限りは、\r\nなつかしの初代の「ガール ミーツ ガール」をやってくれそうな感じがうれしくて期待。\r\n\r\nここ数年は、\r\n最初からもう4～5人のスーパー戦隊体制だったから。\r\n\r\nやっぱり、\r\nふたりの出会い、そして友情をじっくり描いてくれるとうれしい。\r\n\r\n百合描写は薄い本で読めば充分。\r\n本編ではそういうの止めてね。あくまでも「なかよし」で。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(79, 'おらっ補習だこっち来い！ってリコをみっちり特訓したい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(80, 'スイートは、\r\n初代のリメイクをしたから不評だったんではなく、\r\n１クール、ずっとケンカしっぱなしの脚本が不評だったね。\r\n\r\n日曜朝なんだから、\r\nあんまり悲しい方面にハードなのはよくない。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(81, 'あれ大して暴言じゃないと思うんだけど俺少数派？\r\nそれより、せつななんて子最初からいなかったのよとか、\r\nあなたとはプリキュアってだけで友達でもなんでもないのよとかの方が直接キツイと思うけど。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(82, '復活のFの人気から考えて次の映画が公開するまでやりそうだな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(83, 'このままだと漫画にも追いついちゃいそうだな。\r\n追いついたら漫画意味なくないか？\r\nきっと追いついたら「続きはテレビで楽しんでね！」とかでいきなり終わったりするのかもね。復活のFみたいに。\r\nつくづく中途半端な展開だなー。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(84, 'お前ら都合のいい耳を手に入れられて良かったな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(85, '比べる基準ぶっ飛んでんだけど？\r\nお前流に勝手に設定変えて何言ってんだ？\r\n\r\nお前ヤムチャ？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(86, 'ビルスとかゴールデンフリーザとか第六宇宙とかジャコとかモナカとかはまあ良いとして\r\nブルマの姉この後付け設定居る？見てて一番ん？ってなったんだけど');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(87, '>>11\r\n感想も予想もダメとは…\r\nさすが信者の鑑');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(88, 'ゴミアニメは評価できない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(89, '分厚いプロットってのがどのくらいの量か分からんが\r\n試合と超DB探しとビルス超え含めて2クールくらいで終了してほしいわ\r\nその後はヒーローズなりフュージョンなり\r\n鳥山非関与作品続ければいいと思うわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(90, 'これはヤムチャのぶん\r\nぺしっ\r\nこれが餃子のぶん\r\nどかっ\r\nそして、これが・・・オラの怒りだあああああああ\r\nどかーん');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(91, '実際修得してないだろウイス\r\nカイカイ瞬間移動なら一瞬で地球や界王星に行けるのにわざわざ宇宙一の\r\nスピードで移動してるだろ\r\nちなみにヴァドスでさえな当たり前だが悟空やベジータも真似できない技だぜカイカイ瞬間は');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(92, 'ウーブなら\r\n瞬間移動も瞬時に得とく\r\n戦闘力も4ヶ月もトレーニングすればSSGSS以上\r\n1年以上でビルス以上確実だろ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(93, 'あとどっちが潜在能力が高いとかそんな話もしてない\r\nお前はウイスでは習得不可能って言ったからな　それを否定しただけ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(94, 'ブウの技の学習能力には目をみはるものがあるけどそれが強さに直結するかといったら疑問がある\r\n圧倒的な実力差を埋めるのに小手先のテクニックだけで足りるのか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(95, 'マイナーチェンジとは部分的な改良を施す事\r\n今回の場合はデチューンって言うんだ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(96, '大事なこととは思えないのだわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(97, 'ゲームのXYが初代を意識してる\r\nZが発売されなかった場合Ｐジガルデ関連を新作本編クリア後にカロス地方移動で回収\r\nとかかな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(98, '映画のメガポケは色違いか\r\nこの頃にはサトゲコも完全体になってるかな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(99, '今年の映画は30億行くかね\r\n20億キープできれば合格だろ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(100, '今回の漫画はまた絵が下手だな\r\nてしろぎかもん');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(101, '恒例山寺じゃなければいいが\r\n今なら渋くて馴染みあるのは小山力也あたりになるのか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(102, '完全にスパッツ・・・\r\nttps://pbs.twimg.com/media/Ca5lPPoUUAAmsTo.jpg');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(103, 'とりあえず今年の映画はサトシの活躍はもちろんだが、セレナたちを空気にするのはやめてもらいたい\r\nフーパはそのあたりが残念だったからな\r\nただサトシが伝ポケを指示して積極的に戦うのは面白くて新鮮で良かったな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(104, 'おは乙\r\n前スレで出てたバケゆかの見たが本当笑えるわ\r\n野良ならではだな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(105, 'これ最高にすき\r\nhttp://i.imgur.com/sEXM2IC.jpg');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(106, '何事にも笑えることはいいことじゃないか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(107, 'イカ界の良心と言われていたきっとかっともただの変なおじさんになってしまったか…\r\nもうイカ界にまともな奴は残ってないな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(108, '教え子が師を超えることなんて勉学でもスポーツの世界でも普通だろ\r\nスプラでは何故かそういうことよく言われるけど');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(109, 'ねくらに弟子入りして甲子園優勝したリッターがいましたね\r\n実績は完全に師匠超えてますわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(110, 'きっとかっと見てるか？\r\n\r\n俺はお前を認めているからな\r\n笑い声だけ直してくれ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(111, 'バケゆかの動画みつからないんだけどどこいった');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(112, 'あれ…聖人さん２ｃｈ関連のツイ微妙に消してるやんｗ\r\nあの囲いをどうにかしたいんやろうけど無駄だから一生囲われといてくれ\r\nTS消してる放送囲いだけじゃねーぞ聞いてるのは');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(113, 'decoyとかいろはとかが台頭してからおもひでの悪評目立たなかったけど\r\n元々普通にヒールだよな\r\n\r\nまあ強かったらなんでもいいけど');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(114, 'きっとの２ｃｈ関係のツイだれかスクショ張ってくれ\r\n正直話題にする程度ならクラリーもやかわツンデレゆごいち等々みんなやってるぞ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(115, 'もやかわ君バックアップ放送とかはどうでもいいけどこのスレ映すのやめてね\r\nブラウザのタブは全部閉じてからやるんだぞ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(116, 'もやかわはニセコイが好きな時点で察する');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(117, 'でんちゅうが晒した奴らがでんちゅう以上にやばい\r\nガイジ有線VSガイジ無線+無線囲い');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(118, '白目って言うほど気になる？\r\n白目隠すくらいなら口元隠したほうが絶対良かった\r\n生主麻雀の時のあの例のキャプ見ると悲しくなる');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(119, 'どっち隠そうがマジでどうでもいい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(120, '案の定グッダグダだったけどなんだかんだ下馬評どおり勝ったか\r\n次のひかりとかいうクッソ性格悪いｇｍにはなんとしてでも勝ってほしいわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(121, 'SEだったけど使えなくて本社戻って半年くらい何もせず置物になってたよ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(122, 'チック症\r\nあと今更知ったんだがオリックスの安達ももこうと同じ潰瘍性大腸炎だってよ\r\n仲間が増えてよかったな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(123, '屍人☆モンスターは昨日の夜中ﾎﾟｯﾁｬﾏが散々論破してやったのにまだいるのか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(124, 'ヌッ! ・・・ウッ、ハァ、ハァ、ハァ、ハァ、ハァ、 ヌ゛ッ! ハァ、ハァ、ハァー・・・');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(125, 'ダビスタRTAって一日一回？　だかなんだかっていう\r\nリセット&リトライ禁止みたいな文化があるみたいだけどあれ結構独特だよね\r\n再走要求兄貴は窒息しちゃうんじゃないですかね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(126, 'ぶｗとかwとかWとかＷとかｗｗｗとか各種スペースも入れたメガトンコインとか再走とか\r\nその辺突っ込みまくっても大体出ますねぇ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(127, 'FF10…見ないですねぇ…');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(128, 'biimシステムとFaceRigとの組み合わせ一見面白そうだけど\r\nただでさえゲーム画面と下枠と右枠で3箇所見る場所があるのに\r\nさらに視点の移動先が増えて処理が追いつかなさそう');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(129, '凄く好きなゲームじゃないといくら再生数伸びても労力に合わんよなぁ…\r\n何作品も編集する気力あるなら有名作やってお気に入り増やしてからの好きなマイナーゲーってのもあるかもしれんが\r\nbiim兄貴リスペクトタグ自体がある程度視聴者呼ぶ傾向にあるし、マイナーゲーは結局有名兄貴でもあんま伸びんし\r\n本人がやりたいかどうかが一番ってそれいち');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(130, 'ゲームのネタ知名度だけで受けを取ろうとするとエルシャダイRTAみたいな動画が生まれるんだよなあ\r\n悲しいなぁ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(131, 'そういるいる\r\nウォーキング・デッドにはまりたてで狭いゾンビの世界で勝手に感心してるタイプだろ\r\n分かるわわぁ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(132, 'みんなこいつに構わなくていいよ\r\n映画ハマりたてでちっちゃな世界の中で勝手に感心してるタイプだわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(133, 'ここってだから面白いんだよ\r\nいろんな意見を見れるからね\r\nお前のような意見でさえここは否定しないぞ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(134, 'そうなんだよ、だからこそちょっとウォーキング・デッドが人気だからって今まで嫌ってたものを見るというのは\r\nそれを好きだったやつからしたら気に入らないのは当然のことだな\r\nSWを槍玉に挙げたが、彼からしても「おめえら今までそんな興味なかったろ」と思うやつがいてもそれは当然のことだ\r\nワールドカップのときだけにわかサッカーファンになるのもまた同じこと\r\nそれに対し批判的に成る人間が多くいるのは当然のことだ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(135, 'ゲーム実況がボイスロイドの花形\r\nでゲーム実況者は創作者じゃなく消費者、またはアイドル\r\nそこ履き違えてるから捉え方にズレが出る\r\n\r\n新しい物好きなはずのWeb作家連中が今だに介入してこないのはそういう場になってるって分かってるから\r\nモノ作りが好きな人は人脈やキャッチャーさだけで評価される場所を避ける\r\n現状を不満に思うなら居場所間違えてるよ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(136, '姉妹はお互いに育てようと揉み合って頑張ってる\r\nしかしこうかはいまひとつなようだ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(137, '今は有名になったボイロ実況者が元々はその類いでは？\r\nそれに人が寄り付かなかったら此処まで盛り上がって無いだろ\r\n後なぜか絵師やイラストレーターに人気だね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(138, '何もしないよりは何かしたほうがいいのは確か\r\n宣伝広告で界隈が廃れる？じゃあ何もしなかったら逆に界隈は繁栄するのだろうか\r\n全くそうは思わないがね');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(139, 'ここ最近広告システムに異を唱えてる人の気持ちも分かる\r\n自分の好きな題材で出来のいい動画を作るよりも\r\nマイクラやコマンドーネタで媚びを売って有名人に宣伝してもらう方が動画の伸びがいい、\r\nっていうのが現状だもんな\r\n動画投稿者だって何も聖人君子ってわけじゃないんだから\r\n頑張って作った作品が評価されなければモチベも下がるだろうしな\r\n今は馬鹿騒ぎして楽しいかもしれんがずっとこの乗りを続けてたらいずれジャンル全体が衰退する、\r\nっていう危惧も賛成できるわ\r\nジャンルの衰退を防ぎたいならそろそろ何かテコ入れをしなきゃいけない時期に来てるんじゃないかな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(140, '本当に出来のいい人はけっきょく伸びる\r\nそこに差はない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(141, 'トルネードの人の露骨なプッシュと異様な伸び方見てたら気持ち悪さを感じるのはわかる\r\n最近だと茜シャブシャブ世紀末もそう\r\nあの連中に気に入って貰えれば伸びるのねってのがはっきりわかってしまった');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(142, '早見も結局デビューだけご祝儀のパターンだったか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(143, 'アルバムならおおよその地力は分かるからそれで比較すればいい\r\nっていうかコテスレが隔離所になってない？w');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(144, 'みもりんとまあやと唯ちゃん\r\nラジオやニコ生が少ないな\r\nいのりんもレギュラー無くなって寂しい\r\nりえしょんやうえしゃまくらい出て欲しい\r\n\r\n花澤さんはしょこめざ関係で最近また出るようになったな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(145, 'だから1枚しか買わなかったファンが\r\n10枚買うと2ショット写真とかの手法に乗ってくれるってことだろ？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(146, 'そうそうeveryingのスペシャル版の一般申し込みページが出来てるよ\r\nなぜかブロマイド2枚組の方は売らないみたいだけど');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(147, '瀬戸はもう十分機会与えられたので今更火がつくことはない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(148, 'プリキュア高橋悪くなかった\r\n早見の猫もまさか変身すんのか');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(149, '幼女向けは時代はここたまやで\r\n良く分からんシャンプーとリンスまで売れてる');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(150, 'グッズの逆襲タオルいいな\r\nこれ持ってミルキィ以外の色んなライブに行きたいｗｗｗ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(151, 'ミルキィで空売りは余りないと思う\r\n空売りと言われた2014年の年末ライブですら実際買えたし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(152, 'トライセイルの運営はファンにやさしくない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(153, 'ちょらス蕩れ～\r\n可愛いは正義！\r\nなんもくれなくて良いです');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(154, '希望的予想なんだが\r\n来場者にチョコはあると思うわ\r\nＡ賞はそのチョコを手渡しでもらえるっていう特典なのだよ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(155, 'ガンダムで、内田ゆうま君が\r\nよくしゃべってたが、ぶっちゃけあれ、\r\n彼の声に印象に残るか、\r\nみんな教えてくれ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(156, 'Mﾏｽ声優で地味に一番人気伸びてる\r\n\r\n【twpro（ツイプロ）検索数（2015/01/29時点）　　前回より増減】\r\n蒼井翔太　6813　　+77\r\n岡本信彦　4947　　+30\r\n入野自由　2712　　+17\r\n花江夏樹　2670　　+17\r\n江口拓也　2533　　+13\r\n斉藤壮馬　2262　　+47\r\n小野賢章　2098　　+1\r\n石川界人　2066　　+5\r\n増田俊樹　1870　　+13\r\n内山昂輝　1808　　+3\r\n逢坂良太　1676　　+20\r\n島崎信長　1443　　-4\r\n松岡禎丞　1424　　+0\r\n梅原裕一郎　1331　　+13\r\n西山宏太朗　508　　+1\r\n山下大輝　504　　-3\r\n村瀬歩　423　　+3\r\n鈴木裕斗　262　　+2\r\n田丸篤志　232　　+5\r\n内田雄馬　214');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(157, 'ラジオ終わらないならいいけど\r\nどうなんの\r\nマジで');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(158, 'あかねさんの隣国の人の東京ドームライブ行こうかと思ってたから丁度いいかも');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(159, 'きゃにめから参加希望確認メール来たけど、福岡からわざわざお渡し会のために東京、行くべきなのか、、お渡し会って特典渡してそれだけなんですかね？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(160, '津田ちゃんのお渡し会、前から予約してたのとイベントで予約した分で別でメール来たから応募シリアルが2つあるんだけど、両方応募したらどういう扱いになるんだ？\r\n二週できるとは思えないけど・・・');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(161, 'お渡し会はやはりそんな感じですよねー\r\n夜に他の予定取り付けたので、行くことにしました');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(162, 'みかしーへの告白だけ何故ボケに\r\nしかもつまらないという\r\n\r\nうーん無能');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(163, 'Blu-rayしか対象にならないのね…\r\n再生環境なくてDVD予約してたけどこれを期にブルーレイレコーダー買って\r\nBlu-rayの４巻予約するわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(164, 'http://yuruyuri.com/blog/wp-content/uploads/2015/12/20151229_YRYR_CD-400x397.jpg\r\nhttp://www.tohogakuen.ac.jp/yuruyuri/note/images/2016020512220456b4155c9883c.jpg\r\n再現ワロタ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(165, '津田ちゃんのお渡し会の応募ってもうできないですか？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(166, '衣装超可愛い\r\nビタスイと肩を並べる可愛さ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(167, '三森すずこ\r\nhttp://pbs.twimg.com/media/CZehnwiVIAEAiug.jpg\r\nhttp://pbs.twimg.com/media/CZeqiNzUcAEwHpd.jpg\r\nhttp://pbs.twimg.com/media/CZervihUMAAghPy.jpg\r\nhttp://pbs.twimg.com/media/CZer8kjUUAAXfJz.jpg');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(168, '茅野愛衣\r\nhttp://pbs.twimg.com/media/CZfBO12UcAAQ0eA.jpg');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(169, '高橋李依\r\nhttp://i.imgur.com/EJnalB8.jpg');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(170, '電子チケットだけと思ってたわ。\r\nってか、オク高すぎ。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(171, '唯ちゃん後ろから抱きついて耳舐めながらおっぱいずーっと揉んであげたい\r\n唯ちゃんの２０歳のメスおっぱい世界一柔らかそう\r\n　　＿人人人人人人人人人人人人人人人人＿　\r\n　　＞ 　　　　ガイジが来るぞ逃げろ！！　　 　＜　\r\n　　￣^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^Ｙ^￣\r\n　　（ω・｀； )　三. 　 　 　ﾊｯﾀﾂｼｮｳｶﾞｲ ﾊｯﾀﾂｼｮｳｶﾞｲ ﾊｯﾀﾂｼｮｳｶﾞｲ\r\n　 ←─∪‐）ｰ 三.　　　　　　　 ∩ 彡⌒ミ ∩　≡＝\r\n　　／￣ 《 ￣￣￣＼ 三. 　　　ヽ(´・ω・｀) /　　≡＝\r\n　　|　・； Ｕ　　　　　　| 三三　　　ヽ　　　　)　　　　.≡＝\r\n　　| |ι 　　　　　　　.|つ 三　　　　　(⌒ 　　）　　.≡＝\r\n　　Ｕ∧_ ｉ￣￣∨∧_.| 三　　　 　　　＼__）＼_）.≡＝');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(172, 'そういやツイッターで武道館の当落調べてた人いたけど\r\n当選率は75％だったみたいね\r\n会場規模にしては落選率高いかも');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(173, 'HTPTの幕張とかRCパシフィコ2DAYSの実績から武道館の75%当選率は不自然だな。「ゆいかおり武道館開催」の流れ興味持った人が増えたか、まだ用意してないチケが多いか、転売屋の買い占めかのどれかだな');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(174, '唯ちゃんの脱ぎたてパンティ被りながら寝てあげたい\r\nク ロッチ部分が鼻に当たるようにして唯ちゃんの若いメス淫臭ずーっと嗅ぎながら睡眠したい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(175, 'さすが唯ちゃんはお菓子と自分はセットで自撮り\r\nきゃりさんも見習え');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(176, 'きゃりさん自撮り好きじゃないもんな～\r\n昔から唯ちゃんと比べられたせいで自分に自信なさそうだったし…\r\n最近は美人になってはっちゃけてる感じだけど');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(177, '立て直すと言いたい所だけど\r\n現在ゆいかおりスレ乱立してるから次まで我慢かな～');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(178, 'え？ツアーの追加公演で記念すべき初武道館なのに\r\nお前らはダブアンしないの？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(179, 'するしないのじゃなくて有無の話だよ\r\nそんなのに時間取るならその分本編を濃密にしてもらいたいだけ\r\n\r\nコールは当然するが');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(180, '22時までに客を全員外に出さないといけないから\r\n最大で21時くらいまでだと思う\r\nでもそんなに踊ったら二人が倒れるなｗ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(181, '冒涜とかアホやろ。\r\nそれを言っていいのは本人だけや。\r\n\r\n自称代弁者は世界の嫌われ者。');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(182, 'すみれさんと少しでもお近づきになりたきゃ、お前らロシア製戦車の名前と特性を全部暗記しなきゃ無理だぞ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(183, '確かに凸守がヒロインだったこともNo.1人気だったことも知らない');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(184, '活躍してくれるのはいいんだけどキャラがなんかなー\r\nそれこそ凸森みたいなキャラがヒロインならいいのに\r\n正統派よりプラメモの海松さんとかＧＪタマみたいな端役に置かれがちな一癖あるキャラの方がハマってる印象');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(185, 'ファントムワールドに出てるな。\r\nいやまぁ京アニ系はよくでてるけど');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(186, 'すみぺ様に足蹴にされたい\r\nすみぺ様のありがたい唾をかけられたい\r\nすみぺ様に日頃のストレスを発散していただきたい');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(187, 'お前見たら余計ストレスになるだろう');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(188, '水着まだかという人は悪だと言ってたけど、それでも水着はよと言い続ける');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(189, '真礼さんが姉だから内田雄馬は守られてるが普通なら炎上案件だろそれ\r\nまぁシーサイドライブフェス楽しかったけどさ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(190, '人生1度きり。40歳は良い機会だと思う。\r\nファンとしては唐突過ぎたけどやりたいことやらせてあげたい。\r\n\r\n恐らくライブツアーとか出来るのも年齢的にあと数年だろうし');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(191, 'み「やまなこ再開してもらうから」\r\nみ「ゆかりはマイク右手持ちな」\r\nゆ「左手じゃなきゃヤダ！辞めてやる！！」\r\n\r\nこれか！？');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(192, 'スタチャ終了、3クリと統合\r\nスタチャの所属アーティストが猛者揃いの為\r\n相対的に待遇が低下\r\n今に至るといった因果律が見えてくる様ですが\r\n\r\n個人にはメモオフから馴染みの声優さんだけに\r\n1ファンとしてこれからもご活躍期待したい所');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(193, 'やっぱ去年のハイタッチみたいな感じか\r\n何を話したらいいかわからないから逆に気楽だわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(194, '2秒くらいしか無くてワロタ\r\n全く緊張しなくてすんだわ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(195, 'キリステロめちゃくちゃかっこよかった\r\nSTのほうが良かったとか思ってたけどBK参加できて満足');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(196, 'ペットボトルのとこ、ダイイングメッセージかな？とか言っててめっちゃ可愛かった\r\nミニライブはうっちーがペンライトの色指定してくれたから振りやすかったよ');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(197, 'うっちーはファンをファンという総体じゃなくて個々の人格として見てくれてる感じがするんだよね\r\nだから空気読めなかったりタイミング悪い奴には注意したりもするし、1.5ライブの時の「もう一回やろう！」っていう声に反応して本当にMerry Goを二回歌っちゃったりもするし\r\n\r\n今日のお渡し会でも声掛けたら聞こえにくかったみたいで時間ないから流してくれても文句ないのに「え？なに？」みたいな感じで話し聞こうとしてくれて、ほんと優しい人だなと思った');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(198, 'これの詳細分かる人いる？\r\n一方は原田ひとみな\r\nhttp://i.imgur.com/mWcSRzW.gif');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(199, '廃止された低偏差値の科のしかも推薦馬鹿組なのに\r\n詐欺の様に試験突破してきた一般入学の普通科偏差値を持ち出して誉め殺し\r\n宮野に恥かかせないで！');
INSERT INTO `_sample_comment_text` (`sample_comment_text_id`, `comment_text`) VALUES(200, '中継はしないけどテレビカメラは入るだろ');

-- --------------------------------------------------------

--
-- テーブルの構造 `_sample_thread_title`
--

CREATE TABLE `_sample_thread_title` (
  `sample_thread_title_id` int(11) NOT NULL COMMENT 'プライマリ',
  `thread_title` text NOT NULL COMMENT 'スレッドタイトルサンプル'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='スレッドタイトルサンプル';

--
-- テーブルのデータのダンプ `_sample_thread_title`
--

INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(1, '【社会】国民年金の保険料、世帯所得1000万円以上の人の7.8％が過去2年間1度も納付せず…厚労省、高所得者への強制徴収など対策を強化へ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(2, '【政治】丸川環境相が失言「反放射能の人がワーワー騒いだ」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(3, '【社会】３０代女性契約社員、スーパーへの食品売り込みで「枕営業」強要される　厳しいノルマに正常な判断力を奪われ狂っていく人生');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(4, '【政治】甘利氏元秘書「レクサス買って」　民主党が音声データ入手');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(5, '【社会】３０代女性契約社員、スーパーへの食品売り込みで「枕営業」強要される　厳しいノルマに正常な判断力奪われ狂っていく人生');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(6, '【北海道】カップラーメンの麺が伸びていることに腹を立て、小5の息子を殴る　傷害と暴行の容疑で父親(51)逮捕');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(7, '【世論調査】景気の回復「実感していない」７７％　アベノミクスへの懸念が広がる   (読売新聞社)');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(8, '【電波停止】菅直人元首相「自民に都合の悪い放送は停止される、まさに独裁国家だ」　高市総務相の発言を批判');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(9, '【政治】丸川環境相が失言「反放射能の人がワーワー騒いだ」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(10, '【電波停止】菅直人元首相「自民に都合の悪い放送は停止される、まさに独裁国家だ」　高市総務相の発言を批判');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(11, '【経済】日経平均株価は144円26銭高の1万6166円84戦と続伸　前日の急騰に対する反動安後に切り返し　16日前引け');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(12, '【政治】甘利氏が睡眠障害で療養必要との診断書提出');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(13, '【政治】甘利氏、「睡眠障害」で１カ月休養　辞任以降、国会出ず');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(14, '【国会】高市総務相「私への報道見てもメディアは萎縮してない」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(15, '【世論調査】景気の回復「実感していない」７７％　アベノミクスへの懸念が広がる   (読売新聞社)');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(16, '【宝石】404カラットの巨大ダイヤモンド、アンゴラで発見');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(17, '【国内】＜甲状腺がん＞福島の子ども「数十倍」…放射線の影響否定的　[毎日新聞]');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(18, '【テキサス親父】国連女子差別撤廃委員会　日本のｾｯｼｮﾝにﾁﾏﾁｮｺﾞﾘを着た連中がうろついています。被害者ﾋﾞｼﾞﾈｽの為の根回しですね');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(19, '男児＝大荷物　女児＝小荷物　死刑判決受けた河南省「人さらい」組織の信じられない悪事の数々…');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(20, '【ｹﾝﾄ･ｷﾞﾙﾊﾞｰﾄ】菅元首相、鮮やかなブーメラン　菅政権で言及の電波停止を「安倍政権は憲法違反」　「独裁」批判も自身はかつて容認');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(21, '韓国人｢韓国で使われる現代単語はほぼ全て日本人が作ったと言っても過言でない事実｣　国民､自由､平等､人権､民主主義､人民､共和国､経済');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(22, '両津勘吉「真夜中の交通量の少ない道路でも律儀に信号守ってるのは日本人とドイツ人だけ」←マジかよ!');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(23, 'ＭＲＪ、米航空機ﾘｰｽ会社から最大20機受注　合計427機に　ＭＲＪの米試験飛行、最短で9月に　｢Ｘ２｣にめどがついた三菱重工から応援仰ぐ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(24, 'おまえら「ｼﾞｼﾞｲﾊﾞﾊﾞｱは老害だからさっさとくたばれ」マツコDX「おまえらそのジジババのおかげで平和にのうのうと生きていられるんだよ」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(25, '廃棄物処理施設などで発生する廃熱使い水素、燃料電池車に　トヨタと愛知県が実証実験');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(26, '韓国の青年＝白丁たちよ､利益を独占する財閥＝両班を選挙で懲らしめよ　ヘル朝鮮！！　ヘル朝鮮！！　ＦＵＣＫ　ＫＯＲＥＡ！ ｷﾑﾁ野郎！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(27, '安倍晋三は年金返せ と言ってる方々は深呼吸して現在の年金の運用状況確認しましょう。年金の運用益は民主党の頃より30兆円ﾌﾟﾗｽ運用です');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(28, '日本の重力波望遠鏡「KAGRA」の始動前に重力波発見は民主党政権の事業仕分けの犠牲｡無知で傲慢な政治が、この様な結果をもたらしました');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(29, '民主党政権は宮内庁から2000点以上の文化財を韓国に持ち出させた。宮内庁関係者や日本人の学者もあまりの酷さに民主党に抗議したが黙殺');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(30, '');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(31, '');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(32, '【名無】民主は実践したろ口蹄疫隠し→安倍首相、電波停止｢民主党政権で同じ答弁｡野党になったら問題視はおかしい｣→【民主】言論弾圧ﾆﾀﾞ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(33, '愚鈍なる日本国民よ、もう朝鮮の奴隷になりなさい');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(34, 'ZEEBRA「大麻が合法化されたら毎日吸います」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(35, '亡命ウイグル人を取材して＝「中国政府による少数民族の差別と弾圧の実態を世界に伝えてほしい」　不当逮捕に手の爪をはぎ取られる拷問');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(36, '【辛坊治郎】民主党と朝日､毎日新聞は高市停波答弁で言論弾圧と世論誘導する心根が卑しい｡鳩山を宇宙人と呼ぶなと言論弾圧したのは民主党');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(37, '中国共産党の臓器狩りとの１０年の戦い　生きている法輪功学習者から角膜を摘出しそのまま火葬炉に入れた　臓器狩りは江沢民の指示');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(38, '【桜井誠】高速鉄道問題で大揺れのｲﾝﾄﾞﾈｼｱ内部から日本に替えて発注すべきとの声｡冗談ではありません｡地獄の底まで支那と付き合うべき');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(39, '韓国の輸出、２月に入っても急減');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(40, '【清原和博薬逮捕】長渕剛、タニマチ田辺大作(仮)、実業家、そば屋と焼肉店経営者がヤバイ！！？驚きの共通点がこちら・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(41, '【略奪】今井美紀が布袋寅泰の元嫁山下久美子に行った嫌がらせが酷過ぎる・・・（画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(42, '山口智子、唐沢寿明との子供を作らない本当の理由を激白し炎上…不妊治療失敗ではなかった…（画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(43, '【画像】タラちゃん壊れる');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(44, '【画像】上坂すみれさんが声優12人を全員公開処刑ｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(45, '【朗報】「俺の嫁」が3Dになる時代らしい');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(46, '懐かしアニメ、『ムーミン』の新アニメシリーズが製作決定！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(47, '【速報】『ギルティギア イグザード レベレーター』新キャラ「レイヴン」が参戦！超ドMでダメージを受けると強くなる！ディズィーのシルエットも公開！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(48, '【超朗報】『デレステ』にSSR神谷奈緒が実装！　中の人・松井恵理子さんが描いたお祝いイラストが可愛いいいい！・他');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(49, 'この漫画考えた奴天才杉ワロタｗｗｗｗｗｗｗｗｗｗ （※画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(50, 'はしもとかんながマスク着けた結果ｗｗｗｗｗｗｗｗｗ（※画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(51, '【朗報】美人過ぎる女子野球選手・加藤優 （※画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(52, '在日3世の彼の家でセクハラを受けた。彼に「あのお父様に会いたくない」って告げたら・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(53, '浮気した元嫁が「あなたも新しい幸せを掴んでくれると私も嬉しい」と言い、昨日から行方不明になった');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(54, '夫が現地のタイ人女性と不倫して離婚。ある時、会社前で元夫にタイ人嫁と待ち伏せされた');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(55, '在日ロシア大使館公式Twitter自虐ジョークツイートの翌日中の人交代…シベリア送りか');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(56, '大学の奨学金に文句言ってるヤツって頭おかしいんじゃね？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(57, '文科省「１兆円つぎこんだ『もんじゅ』の廃炉費用３０００億円かかるからよろしく！…そもそもナトリウム取り除く技術無いから廃炉できねーけど（核爆）」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(58, '【画像】 清原容疑者のニュースでドリフ爆発コントみたいな髪型の人が映りネット騒然');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(59, '安倍首相「GPIF運用悪化なら年金給付減額あり得る」…衆院予算委');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(60, '「糖質制限ダイエット」第一人者の桐山秀樹氏、心不全で急死　62歳');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(61, '【一種の天才】キャンディを宝石みたいに磨いた人がすごすぎるｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(62, 'TVのダーウィンの種の起源の話しを見ながら、夫が言ったセリフかっけぇぇええええ！ｗｗｗｗｗこれはいつか言ってみたい');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(63, 'このパンダ可愛すぎか！コロコロでモッフモフやんけｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(64, '【AKB】安達祐実に似てる人おるんやけどｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(65, '【衝撃】西野カナ顔変わりすぎワロタｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(66, '桐谷美玲「あと４年で子供欲しい、頑張る」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(67, '晩ご飯に唐揚げ丼とサラダ作ったから見て（※画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(68, 'シェアハウス住んでるけどみんなの朝御飯用のお米全部食べちゃった');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(69, '人生初のメガネ買ったったｗｗｗ（※画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(70, '橋下徹、引退後に暇すぎて1級船舶操縦免許を取得');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(71, 'お前らこの画像見て懐かしくなったら負けなｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(72, '【訃報】糖質制限ダイエットの桐山秀樹氏、心不全で急死　62歳');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(73, 'アディーレ法律事務所が景品表示法違反　「1か月限定」の着手金無料キャンペーンを5年近くも継続 「問題と認識してなかった」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(74, '【噂】XboxOne専用タイトル『フォルツァホライゾン3』『ギアーズ4』『スケイルバウンド』などのPC版が発売！？箱ブランドとは一体…');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(75, '甘利前大臣、睡眠障害で1か月の療養 → ネット民「睡眠障害ごときで休むな」「小学生並みの言い訳」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(76, 'ホリエモン「日本ってさなんで手書きで履歴書書くの？効率悪いしメリットがない」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(77, '【悲報】メルカリ「店舗で試着してメルカリで買え」と倫理観欠如なCMを公開');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(78, 'サンコー、スマホと接続できる「ウェアラブルHDMIモニター」を発売。寝ながら操作が捗りそう');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(79, '【画像あり】４０４カラットの巨大ダイヤ、発見される');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(80, '老人ホーム転落死事故、元職員の男が突き落としていたと自供');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(81, '交番の机の上、留守中に１４００万円　持ち主どこに？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(82, '【動画】UFOキャッチャーの奇跡');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(83, '淫夢厨が馬主になった時に付けそうな馬名');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(84, '人生に疲れた奴、寒い冬に42度以上の風呂に10分以上入るとスーッと意識失い楽になれるぞ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(85, 'オコエとかいうファンタジスタwwwwwwww');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(86, '【朗報】阪神秋山、3回11安打無失点の好投【誤植ネタ】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(87, '【動画あり】オコエ、トリックプレーを試みるも失敗');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(88, 'カップラーメンの麺が伸びていることに腹を立て、小5の息子を殴る　傷害と暴行の容疑で父親(51)逮捕');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(89, 'なっちこと安倍なつみが妊娠');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(90, 'ホリエモン「日本ってさなんで手書きで履歴書書くの？PC使えないんですか？効率悪くね？」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(91, '各アニメ、漫画が及ぼした影響書いてけ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(92, '俺がAmazonプライムで無料で見れるおすすめ映画かいてく');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(93, '【悲報】萌えアニメ 33-4でおそ松さんに完敗だった');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(94, '【岡山の奇跡】桜井日奈子の女優デビューが決定！（画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(95, '川本真琴の父親が取材に「（狩野の）人間性どうかな」と怒り…');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(96, '黒柳徹子はアンドロイド？『徹子の部屋』40周年特番での違和感に不安の声（画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(97, '【画像あり】アニメオタクの一生ｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(98, '今のダンスダンスレボリューションのボス曲の難易度頭おかしすぎてワロタｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(99, '42945938217000536733752億万円のヘッホドホッドドホッヘドッホヘッホドッホドドホッｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(100, '俺、彫りが深い女の子が好きなんだよねー言った結果ｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(101, '【朗報】職場にヤンキー女性いるんだけど良い女すぎるｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(102, '【絶望】ふらつくから病院行ってみたらｗｗｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(103, 'これぞ戦車版十徳ナイフ。地雷撤去や塹壕掘り、障害物の撤去や水中走行まで何でもこなす遠隔操作型車両「テリア」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(104, '1年以上行方不明だった愛猫が帰ってきた！うっかり巨大化してた！（イギリス）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(105, '激しすぎだろ！ニューヨーク名物、ネオンカラーのレインボーベーグルの制作現場');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(106, '【復活】ワイ「あ！ フロントドアや！ フロントドア！」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(107, '【民主党】細野議員、ついに不倫辞職した宮崎氏について言及する！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(108, 'アイドルとかいうアジア特有の気持ち悪い文化');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(109, '何で人を殺しちゃ駄目なの？に対するベストアンサー');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(110, 'ブルース・リーの死因について真相が明らかに…マジかよ殺人事件が隠蔽されてた！？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(111, '【画像】ワイデブ、今日の朝御飯ウインナー丼ｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(112, '【閲覧注意】世界変態番付の有力候補、現るｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(113, 'ほぼ毎日乗ってて過去3回ゴールド免許で更新してるオレって凄い');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(114, '年齢差33歳…インターネット上で恋に落ちた異国の2人の結末や、如何に!!!!');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(115, 'おそ松さんが社会現象で話題だけど、初期のおそ松くんの社会現象のすごさといったら！皇太子殿下まで！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(116, '栄養バランスのいい？嫁の朝食を無視して、コーヒーだけ飲む日々。嫁が離婚届を置いて出てった。正直ホッとした・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(117, '親が決めた結婚話を断って帰宅したら、折檻された！体重が32kgまで落ち、自力で立てなくなった頃・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(118, '夫「軽に乗った家族連れが近所をグルグルしてる。何かを探してるみたいだ」私『え？ま、まさか…(焦』→嫌な予感が的中し・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(119, '低所得高齢者への３万円給付について、外国人にも支給決定。これは安倍ちゃんGJだね');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(120, 'イスラム教徒「日本人のモラルの高さは素晴らしい。歩くコーランだ」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(121, '埼玉の31階建高層マンション15階で火事→消防が連結送水管に送水→地下トランクルーム水没');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(122, '「天井に初めてシーリングファンをつけた…猫がこんな顔になった」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(123, 'インド政府「その辺で排泄するのはやめよう」あまりに不衛生なため銀行に公共トイレを作るよう要求');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(124, '「うちの猫は呼ぶと…少し変わった登場のしかたをする」（動画）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(125, '21世紀の新人最高打率が赤星と言う事実');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(126, 'バロテッリが稀に発揮するスーパープレーはまぐれなのか彼のポテンシャルなのか？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(127, '伊メディア「ミラン本田は超一流の選手ではないし、イケメンというわけでも、プレーが洗練されているわけでもないが、彼よりも信頼性の高い選手は見当たらない」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(128, 'サッカーオランダ代表の歴代ベストイレブンｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(129, 'ガンスリンガーガールってアニメ面白いの？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(130, '期待の「艦これ改」早くもフラゲ組から実機プレイ動画が公開される');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(131, '俺「おっ！化物語好きなんスカ！？」同僚「えっ･･･(ドン引き)」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(132, 'テイラー・スウィフトがグラミー賞で３冠達成！！！！！！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(133, '中国の宅急便追跡がヤバすぎるｗｗｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(134, '明石家さんま、小島よしおを公開説教ｗｗｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(135, '『艦これ改』フラゲプレイ動画がアップされる');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(136, 'メルカリのCMが小売業者を馬鹿にしていると非難轟々');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(137, '『刃牙道』本部対ジャックの結果が衝撃的すぎる');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(138, '【Dimension W】第6話 感想 せっかく懐いてくれたのに');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(139, '【おそ松さん】第19話 感想 意識高い！高すぎるよチョロ松！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(140, '【ハイキュー!! セカンドシーズン】第19話 感想 1年後の大会、化け物だらけになりそう');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(141, '中国「THAADの韓国配備に反対」表明');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(142, 'もんじゅ廃炉、３千億円　原子力機構、１２年に試算');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(143, '朴槿恵大統領、国会で演説「北に屈服した支援をこれ以上しない」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(144, '【名探偵コナン】毛利小五郎が真面目に事件を解決するという奇跡ｗｗｗｗｗ（画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(145, '「ハンター×ハンター」の試験官の強さって実際のところどのくらい？？？？？（画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(146, 'エヴァンゲリオンとかいうなにひとつ理解不能な漫画ｗｗｗｗｗ（画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(147, 'ニート歴一年の俺についに採用通知が→俺「よろしくおねがいします！」店長「あれ……？」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(148, '私「家族の葬式、身内だけでするので参列はご遠慮願います」→何故か会社の上司が会場にやってきた。');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(149, '小学校で「運動会で順位付けするのをやめよう！」みたいな議題が。そこでうちの母が…');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(150, '張本「斎藤佑樹はそもそもプロの素質がなかった」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(151, 'タラちゃん像、破壊される');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(152, 'RPGの斧が不遇武器過ぎるのRPGの斧が不遇武器過ぎるのなんとかしろよなんとかしろよ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(153, '日本びいきの外国人を見るとなんか和む');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(154, '成功者に学ぶ「ルールと習慣」ショブズ同じ服を着る　タモリ・水谷豊・たけしは1日1食');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(155, '『生ぬるい風のわくわく感』←この感覚わかるやついる？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(156, 'お前らのネットワークビジネス（）に勧誘された話をきかせてくれｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(157, '大豆凄すぎワロタｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(158, '「日の丸の生意気な野心」ってなんじゃそりゃｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(159, '【艦これ】海で戦えッ！もしも艦これ改のメーカーが○○だったら・・・？第16回MMD杯本選投稿締切！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(160, '【艦これ】冬イベ終わった提督達の今回の作戦のMVPは？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(161, '【艦これ】連装砲ちゃんや連装砲くんとかの大きいぬいぐるみが欲しい');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(162, '【モンスト】「ガチャ限必須のクソクエ」と酷評！コイツら持ってないと、全く話にならんｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(163, '【モンスト】このゲームを始めて50日経って思ったこと。');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(164, '【呆然】社長「俺の行きつけの店で食ってこい！支払いはいいから」俺『ありがとうございます！』→店に行くと、まさかの結果に・・・・・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(165, '【なるほど】俺『彼女の鼻の角栓が気になるんだが…』美容部員が登場！→回答がこちらです・・・・・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(166, '私『素敵なコート』店員「今だけ１０％オフで、セールにも出ません」購入！→すると、お正月セールでもっと安くなっていて・・・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(167, 'おまえら目玉焼きに何かける？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(168, 'アボカド好きなやつおる？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(169, '腕立て伏せと腹筋ローラー始めたんだけど他になにすればいい？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(170, '【レシピ】シリコンスチーマーのオススメ料理教えて');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(171, '【健康】朝食抜くと脳出血リスク上昇 １３年間の追跡調査');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(172, '【朗報】NMB48 2016新曲を使用したTVCMｷﾀ━━━━━━＼(ﾟ∀ﾟ)／━━━━━━ !!!!!【賃貸・売買のクラスモ】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(173, 'スタジオパークからこんにちは「山本彩「365日の紙飛行機」を弾き語り＆トーク」の感想【NMB48/AKB48さや姉】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(174, '【HKT48vsNGT48さしきた合戦】6回目「家族に聞いた 娘のここがイヤッ！田中美久の父親が登場！」の感想（キャプチャ画像あり）');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(175, '【お前ら急げ】桐谷美玲「30歳までに子供欲しい！あと4年しかないので頑張る」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(176, '【悲報】キムタク、予想外の逆風・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(177, '【衝撃】このイタズラ酷すぎだろ・・・(※画像あり)');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(178, '【朗報】NMB山本彩、写メ会で胸を惜しげもなく披露ｗｗｗｗこれはいいぞｗｗｗｗ(※画像あり)');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(179, '「腕立ふせ100回できる！」← こういう奴よくいるけど、どんな鍛え方してんの？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(180, '渡邊美樹「クールジャパン何を想像しますか？私はワンピースの大ファンです。正解はワタミこそクールジャパンだ」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(181, 'ワンピースの空島編って何気に覇気登場してるんだよなｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(182, 'ドラゴンボールGTの最終回って本当に完璧すぎるよな');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(183, '総額2500万円超“整形サイボーグ美女”ヴァニラ、目標明かす「ロリ顔のフランス人形に近づけたい」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(184, '「炎上ありがとう」女子高生社長の逆切れ態度に女性たちから批判が殺到！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(185, '【奴隷乙】私の式で友人スピーチをするAもプロにメイクして貰うと聞いたBが食いついてきた');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(186, '渡辺直美と手島優が芸人の彼氏にロンハーで告白！誰？と話題に【画像】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(187, '坂本美雨（さかもとみう）旦那の山口博之との結婚式エピソードと愛猫「ネコ吸い」をさんま御殿で公開【画像】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(188, '新子景視（あたらしけいし）プロマジシャンの今後ブレイクしそうなニューカマーをしゃべくりで紹介【画像】');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(189, '客が自然とフォーク並びになってたら店員「お客様はこちらの列へどうぞ〜」→振り分けられた結果、他2つのレジの列はサクサク進んでるのに自分の番だけまだ来ない…orz');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(190, '家電量販店でモバイルルーターの契約取る仕事してた事があるんだけど、その時一緒に店に入ってた上司が、仕事はできるけど人間性が最低の嫌な人だった。');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(191, '村の団地に住んでた子持ちﾏﾏﾝ達が特定の小梨奥に集団託児→それ以外もやりたい放題だったﾏﾏﾝ達、村の時間を持て余した年寄りに念入りにいびられ出て行く羽目になったw');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(192, '軍事的なことや兵器が好きでも155mm榴弾砲とか家の間近で連射されたらマジ切れするよね？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(193, '中国「尖閣諸島は日本に盗まれた」、ミュンヘン安全保障会議で日中が応酬！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(194, '航空自衛隊のU-125A救難捜索機が秋田空港に緊急着陸…車輪格納が表示されず！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(195, '夫と姑が娘に華英（ハナエ）と名付けようとしてる。義実家は代々続く家なので名前に重みが欲しいとのこと・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(196, '妊娠中の嫁が一日中布団に入って家事をしなくなってしまった。甘えないでちょっとは家事頑張ってほしい');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(197, '【修羅場】幼稚園の時に父から虐待を受けていた私は喋れなくなった。小学校では担任人に嫌がらせされて…');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(198, '【危機一髪】屋根の雪が落ちてきそうなところに3歳くらいの女の子がいた。｢ヤバイ！｣と思った瞬間、雪が落下！！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(199, '【最悪】「私はお酒には強い！」と言う友人がいるんだけど、酒癖が悪すぎる。友人「一度痛い目みないとわかんないんだよね～っていろんな人から言われるの」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(200, '【なんでもあり】安倍首相が水を飲む→野党から「水うまそうだな」とヤジが飛ぶ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(201, '糖質制限ダイエットの桐山秀樹さん死去。死因は心不全。元糖尿病患者だが血糖値は正常な状態だった。原因は元々の心臓の疾患か');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(202, '【画像あり】 猫の時計欲しいわ・・・いいのないかしら？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(203, 'うちのオス野良を貼った人！見てくださいー');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(204, '真面目で今まで浮いた話が一切なかった夫が、海外単身赴任中にタイ人女性と不倫。再婚したいから離婚してくれと言われた。');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(205, '「もう～、本当に好きなんだから～」「また～？」と大きな声で嫁が寝言。最近あか抜けた気がするんだ。俺に誰かはっきり言ってくれ、これ浮気してる？？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(206, '夫が不倫してる事が発覚。しかもプリとの間には双子の子がいた。夫は認知したいと言っています、できるなら双子を引き取りたいと....');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(207, '『ラブライブ！』と「キスミント」のコラボCM公開！オリジナルの新規アニメーション！真姫ちゃんかわいすぎいいいいい！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(208, '【超つよそう】映画『ゴーストバスターズ』新作が8月19日に公開決定！　幽霊退治メンバーは全員屈強な女性たち');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(209, '懐かしアニメ、『ムーミン』の新アニメシリーズが製作決定！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(210, '【速報】『ギルティギア イグザード レベレーター』新キャラ「レイヴン」が参戦！超ドMでダメージを受けると強くなる！ディズィーのシルエットも公開！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(211, '【超朗報】『デレステ』にSSR神谷奈緒が実装！　中の人・松井恵理子さんが描いたお祝いイラストが可愛いいいい！・他');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(212, '不倫議員・宮崎謙介氏、党内でのアダ名や不倫相手への口説きメッセージが暴露されるｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(213, '買って失敗した90年代のゲーム機ランキング！ →　おっさんホイホイすぎなんだけどお前らいくつ知ってる？');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(214, '小島秀夫監督が超有名デザイナーに製作依頼！ → やはり一流は一流だった・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(215, '【動画】UFOキャッチャーでとんでもないミラクル発生！おおおおお･･･うわあああああああ！！！ ※閲覧注意');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(216, '『ポケットモンスター』最新作がついに発表か！ 世界最大のゲームショウでお披露目くるぅうううううううう');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(217, '中国人「日本の車は故障率の低さを売りにしているが、中国人は5年程度で買い換えるから無意味」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(218, '寝ながら使えるヘッドマウントディスプレイが2万円の低価格で登場！ダメ人間になる～(^q^)');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(219, 'アニメ『ひぐらしのなく頃に』と2期『ひぐらしのなく頃に解』の全話いっき見BDが6月3日に発売、1枚にまとまって1万円とめちゃ安い！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(220, '『リーグオブレジェンド』 の大会で不正発覚！ → 暴露したチームが出場停止、不正を働いたチームは軽い処罰で非難殺到');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(221, '【酷すぎ】 『うたプリ』オタが妄想トンデモ理論でラバストを強奪する事件が発生！被害者はあまりの酷さに担当を辞める事に・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(222, '人気雑誌が腐女子をボロクソにこき下ろす記事が掲載！ 「おそ松さんにハマる頭が腐った女子の愚かな生態」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(223, '【！？】グーグルマップで『DASH島』が公式表記される！TOKIOすげええええええ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(224, 'アニメ『おそ松さん』で上田燿司さんが”1人17役”をこなし、山寺宏一さん超え！→1人28役をこなした声優さんがいると話題にｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(225, '【炎上】 フリマアプリ「メルカリ」のCMが小売業者をバカにするような内容で批判殺到！ 「作家に中古で買いましたといえるクズが考えたCM」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(226, 'Android版『艦これ』 2月下旬に先行登録開始！PC版のすべての艦娘データを引き継ぎ可能！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(227, '「艦これ」 × 「ローソン」 コラボが本日からスタート！ 各地で早朝からローソンに集う提督たちｗｗｗｗｗｗ');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(228, '開発に2,000万円かけたスマホゲームが資金難とバグでサービス終了 24歳元社長が語る会社倒産後の世界とは・・・');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(229, '『NieR（ニーア）』6周年コンサートが4月16日開催！！最新作『ニーア オートマタ』の新情報も発表！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(230, '清原容疑者、1ヶ月で150回分の覚せい剤を使い切っていた模様、医者によると「死んでもおかしくない量」');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(231, '【悲劇】舞台稽古中に模造刀が腹に刺さり男性が死亡…');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(232, '任天堂『NX』はアンリアルエンジン4対応！？今と違ってサードがどんどん集まってくるぞおおおおお！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(233, '「まじ」「やばい」「なるほど」「たしかに」「おいしい」「うざい」「かわいい」などを使う語彙力がなくて知性に乏しい人間');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(234, '『クロノトリガー』の全81曲を海外アーティストがアレンジしたアルバムが発売！日本からもiTunesで購入可能！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(235, '女性に目を見られながら会話しただけで「こいつ俺の事好きだな」と思ってしまう男性は4割以上');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(236, '林修先生が腐女子の相談に応えるためBL漫画を読破！ 恋愛についての真剣なアドバイスが女オタの心に直撃しまくり！');
INSERT INTO `_sample_thread_title` (`sample_thread_title_id`, `thread_title`) VALUES(237, 'グーグルに対抗して“広告無し”の「検索エンジン」をウィキペディアが開発へ！');

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

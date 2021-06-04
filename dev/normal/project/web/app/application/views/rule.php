<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="help">
	<h1>ルール</h1>
	<p>このページでは、ユーザーの皆様に安全に<em class="site-name"><?php echo SITE_NAME; ?></em>を利用して頂くための、利用上のルールを記述します。
利用上のルールは、必要に応じて随時更新しますので、スレッドやレスを投稿する際に、必ずご確認ください。</p>
	<ul>
		<li>スレッドを作成する者を「スレッドオーナー」と言います。</li>
		<li>レスを投稿する者を「レス投稿者」と言います。</li>
		<li>スレッドを閲覧する者を「ゲスト」と言います。</li>
	</ul>
	<section>
		<h2><span>１</span>共通ルール</h2>
		<p>共通ルールとは、<em class="site-name"><?php echo SITE_NAME; ?></em>内で行われる、あらゆる行為に適用されるルールです。
ユーザーは、<em class="site-name"><?php echo SITE_NAME; ?></em>内で行うあらゆる行為において利用規約に従うものとし、<a href="/term">利用規約の禁止事項</a>に含まれる行為をしてはいけません。
また、<em class="site-name"><?php echo SITE_NAME; ?></em>に投稿されたユーザーコンテンツ（スレッドやレス等）は、コンテンツを投稿したユーザー自身が管理するものとします。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-1-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>禁止行為</h3>
		<div class="toggle" id="toggle-1-1">
			<ol>
				<li>コンテンツをスクリプト等を用いて機械的に投稿する</li>
				<li>同じ内容のコンテンツを連続的に投稿する</li>
				<li>他サイトの記事や、歌詞の転載行為</li>
				<li>待ち合わせ場所の書き込み、出会いを目的とした利用</li>
				<li>他の利用者を脅迫したり、恐怖を与えたり、不快にする行為</li>
				<li>同一人物がTwitterアカウントを大量に作成して<em class="site-name"><?php echo SITE_NAME; ?></em>を利用する</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-1-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>投稿してはいけないコンテンツ</h3>
		<div class="toggle" id="toggle-1-2">
			<ol>
				<li>実在する人物の住所・氏名・電話番号・メールアドレスなどの、個人の特定に直接的、または間接的に結びつく情報</li>
				<li>実在する個人・組織・民族への罵倒や誹謗中傷、または客観的な事実が示されない批判</li>
				<li>犯罪や自殺の助長・賞賛・自慢</li>
				<li>児童ポルノ、過激で猥褻な文字表現、画像、動画へのリンクや埋め込み</li>
				<li>事実に反する内容</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-1-3"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>著作物への批評</h3>
		<div class="toggle" id="toggle-1-3">
			<p>著作物への批評を行う場合は、以下の条件を満たしてください。</p>
			<ol>
				<li>コンテンツを投稿する者が言及する上で、必要な部分のみを引用する。</li>
				<li>引用した部分を明確にする。（カギカッコで囲む等）</li>
				<li>どこから引用したかを明示する。（記事のURLや書籍のタイトル等を記載する）</li>
				<li>引用した部分に関して、必ずコンテンツを投稿者した者が言及、批評する。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>２</span>スレッドオーナがー守るべきルール</h2>
		<h3><button class="toggle-button" type="button" data-target="#toggle-2-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッドオーナーが所有する権限</h3>
		<div class="toggle" id="toggle-2-1">
			<p>スレッドオーナーは、自身が作成したスレッドを運営・管理するための以下の権限を所有します。</p>
			<ol>
				<li>スレッドに投稿されたレスを削除する権限</li>
				<li>スレッドのスパム報告を閲覧・削除する権限</li>
				<li>スレッドに投稿されたレスのスパム報告を閲覧・削除する権限</li>
				<li>スレッドに投稿できるユーザーを制限する権限（NGユーザー）</li>
				<li>スレッドに投稿できる単語を制限する権限（NGワード）</li>
				<li>スレッドを削除する権限</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-2-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッド作成ルール</h3>
		<div class="toggle" id="toggle-2-2">
			<p><em class="site-name"><?php echo SITE_NAME; ?></em>は、全てのユーザーがスレッドオーナーとなり、自分のスレッドを運営できるのが特徴です。
しかし、せっかく作成したスレッドにレスが付かないまま、次々とスレッドを作成していくのは、望ましいことではありません。
従って、次のルールを守るようにしてください。
<strong>スレッドオーナーは、ひとつのスレッドを作成したら、そのスレッドが20レスに満たない場合は、次のスレッドを作成しないようにしましょう</strong>
ただし、数日待ってもレスがつかない場合に、次のスレッドを作成することはやむを得ません。
問題なのは、短時間に、次々とレスのつかないスレッドを作成していくことです。自分が作成したスレッドは一つ一つを大切にしてください。<br><br>
スレッドを作成する際は、以下の事に気をつけてください。</p>
			<ol>
				<li>スレッドのタイトルは、記号の多用は避けるようにして、スレッドの趣旨がわかりやすい簡潔なタイトルを目指ましょう。</li>
				<li>スレッドのカテゴリを選択するときは、作成するスレッドの趣旨に近いカテゴリを選択するようにし、カテゴリルールを遵守しましょう。</li>
				<li>スレッドの本文は、スレッドタイトルと関係ない内容は避けましょう。</li>
				<li>スレッドに登録するタグは、文章を登録してはいけません。固有名詞を登録しましょう。</li>
				<li>すぐに削除したくなるようなスレッドの作成はやめてください。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-2-3"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッド削除の留意点</h3>
		<div class="toggle" id="toggle-2-3">
			<p>スレッドオーナーは、自身が作成したスレッドを削除する権限を持ちます。
これは、スレッドオーナーがスレッドを管理するために必要な権限です。
ただ、スレッドを削除することは、スレッドに関わった全てのレス投稿者の行動を無にすることであります。
濫用すれば、レス投稿者をはじめ、ゲストからも信頼を失い、活発なサイト運営を阻害するものとなりますので、その点はご留意頂きたいと思います。
</p>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-2-4"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レスやスパム報告削除の留意点</h3>
		<div class="toggle" id="toggle-2-4">
			<p>スレッドオーナーは、自身が作成したスレッドに投稿されたレスを削除する権限を持ちます。
これは、スレッドオーナーが円滑にスレッドを運営・管理するために必要な権限です。
しかし、濫用すればレス投稿者からの信頼を失い、活発なスレッドの運営を阻害するものとなりますので、その点はご留意頂きたいと思います。
尚、「共通ルール」に違反しているレスは、削除にご協力して頂けると幸いです。<br><br>スパム報告削除における留意点については、レス削除の場合と同様です。</p>
		</div>
	</section>
	<section>
		<h2><span>３</span>レス投稿者が守るべきルール</h2>
		<h3><button class="toggle-button" type="button" data-target="#toggle-3-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レス投稿者が所有する権限</h3>
		<div class="toggle" id="toggle-3-1">
			<p>レス投稿者は、自身が投稿したレスを削除する権限を所有します。</p>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-3-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レス投稿ルール</h3>
		<div class="toggle" id="toggle-3-2">
			<ol>
				<li>スレッドの趣旨が理解できないうちは、投稿を控えるようにしましょう。</li>
				<li>すぐに削除したくなるようなレスの投稿はやめてください。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-3-3"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レス削除における留意点</h3>
		<div class="toggle" id="toggle-3-3">
			<p>レス投稿者は、自身が投稿したレスを削除する権限を持ちます。
これは、レス投稿者が、自身が投稿したレスを管理するために必要な権限です。
ただ、ひとつレスを削除するということは、スレッドの貴重なレス枠をひとつ無駄にすることになるため、スレッドオーナーをはじめ、他のレス投稿者にとって迷惑な行為です。
濫用すれば、他のユーザーからの信頼を失い、活発なスレッドの運営を阻害するものとなりますので、その点はご留意頂きたいと思います。</p>
		</div>
	</section>
	<section>
		<h2><span>４</span>問題の投稿を見つけた場合（ゲスト用）</h2>
		<p><em class="site-name"><?php echo SITE_NAME; ?></em>は、ユーザー同士のトラブルや、問題のある投稿については、ユーザーの間で解決して頂けるよう、コンテンツ投稿者に削除権限を付与しております。<br>
問題のコンテンツを発見したとき、コンテンツ投稿者に対応してもらえない場合や、ログインできる環境にないゲストのために、<a href="/post/report">問題報告ページ</a>を設けておりますので、こちらからご報告ください。</p>
	</section>
<?php
if (!empty($categories)) {
?>
		<section>
			<h2><span>５</span>カテゴリルール（工事中）</h2>
			<p>スレッドを作成する際は、「共通ルール」に加え、カテゴリルールに沿う必要があります。</p>
<?php
	foreach ($categories as $category) {
?>
			<h3 class="cat-rule-title"><button class="toggle-button" type="button" data-target="#toggle-4-<?php echo $category->category_id; ?>"><i class="fa fa-chevron-down" aria-hidden="true"></i></button><?php echo $category->cat_word; ?><?php echo empty($category->cat_description) ? '<span>（工事中）</span>' : ''; ?></h3>
			<div class="toggle" id="toggle-4-<?php echo $category->category_id; ?>">
				<?php echo empty($category->cat_description) ? '<p>このカテゴリにはまだルールがありません。</p>' : $category->cat_description; ?>
<?php
		foreach ($category->subs as $sub) {
?>
				<h4 class="cat-rule-title"><button class="toggle-button" type="button" data-target="#toggle-4-<?php echo $sub->category_id; ?>"><i class="fa fa-chevron-down" aria-hidden="true"></i></button><?php echo $sub->cat_word; ?><?php echo empty($sub->cat_description) ? '<span>（工事中）</span>' : ''; ?></h4>
				<div class="toggle" id="toggle-4-<?php echo $sub->category_id; ?>">
					<?php echo empty($sub->cat_description) ? '<p>このカテゴリにはまだルールがありません。</p>' : $sub->cat_description; ?>
				</div>
<?php
		}
?>
			</div>
<?php
	}
?>
		</section>
<?php
}
?>
	<div class="rule-footer">
		<p></p>
	</div>
</div>

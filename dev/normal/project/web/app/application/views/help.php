<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="help">
	<h1>使い方</h1>
	<p>このページでは、<em class="site-name"><?php echo SITE_NAME; ?></em>の使い方を説明します。</p>
	<section>
		<h2><span>１</span><em class="site-name"><?php echo SITE_NAME; ?></em>にログインする</h2>
		<p><em class="site-name"><?php echo SITE_NAME; ?></em>にログインするには、Twitterアカウントが必要です。
<em class="site-name"><?php echo SITE_NAME; ?></em>でスレッドを作成したり、レスを投稿するためにはログインが必要ですので、予めご用意してください。
ユーザーがログインの際に、アプリケーション認証画面で入力したメールアドレスやパスワードは、<em class="site-name"><?php echo SITE_NAME; ?></em>に保存されることはありません。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-1-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>ログインの手順</h3>
		<div class="toggle" id="toggle-1-1">
			<p>以下の3通りの方法があります。</p>
			<ol>
				<li>画面右上にあるTwitterアイコン「<i class="fa fa-twitter" aria-hidden="true"></i>」をクリックします</li>
				<li>スレッドページの「ログインしてレスを書き込む」リンクをクリックします。</li>
				<li>トップページの「Twitterアカウントでログイン」リンクをクリックします。</li>
			</ol>
			<p>Twitterの認証画面が表示されますので、TwitterのID及びパスワードを入力して、アプリケーションを承認すると、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが完了します。</p>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-1-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>ログアウトの手順</h3>
		<div class="toggle" id="toggle-1-2">
			<ol>
				<li>ログイン中に表示される、画面右上のあなたのTwitterユーザーアイコンをクリックして、画面右側にドロワを表示します。</li>
				<li>表示されたドロワの中にある「ログアウト」リンクをクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>２</span>スレッドの作成</h2>
		<p><em class="site-name"><?php echo SITE_NAME; ?></em>では、あなたのスレッドを作成したり、必要に応じて自分で削除することができます。
スレッドを作成するには、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが必要です。
「<a href="/rule"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a>」ページの「共通ルール」と「カテゴリルール」を読み、ルールに沿ってスレッドを作成して下さい。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-2-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッド作成の手順</h3>
		<div class="toggle" id="toggle-2-1">
			<ol>
				<li>ログイン中に表示される、画面右上のあなたのTwitterユーザーアイコンをクリックして、画面右側にドロワを表示します。</li>
				<li>表示されたドロワの中にある「新規スレッド」リンクをクリックします。</li>
				<li>新規スレッドの編集画面が表示されますので、一通り入力した上で、「スレッドを作成」ボタンをクリックしてください。</li>
				<li>エラーが表示された場合は、修正してください。</li>
				<li>スレッドの作成に成功すると、スレッドページへ自動的に移動します。</li>
			</ol>
			<p>スレッドを作成した後、次のスレッドを作成できるようになるまで、<?php echo (POST_THREAD_INTERVAL / 60); ?>分ほどお待ち下さい。</p>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-2-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッド削除の手順</h3>
		<div class="toggle" id="toggle-2-2">
			<ol>
				<li>あなたが作成したスレッドエントリ、もしくは、スレッドページのスレッドオーナー本文（#0）の右下にある「 <i class="fa fa-ellipsis-v" aria-hidden="true"></i> 」＞「スレッドを削除」をクリックします。</li>
				<li>確認ダイアログが表示されますので、「削除」ボタンをクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>３</span>レスの投稿</h2>
		<p>レスを投稿するには、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが必要です。
「<a href="/rule"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a>」ページの「共通ルール」と「カテゴリルール」を読み、ルールに沿ってレスを投稿して下さい。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-3-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レス投稿の手順</h3>
		<div class="toggle" id="toggle-3-1">
			<ol>
				<li>スレッドページの「レスを書き込む」フォームに本文を入力します。</li>
				<li>「投稿」ボタンをクリックします。</li>
				<li>エラーが表示された場合は、修正してください。</li>
			</ol>
			<p>レスを投稿した後、次にレスを書き込めるようになるまで、<?php echo POST_COMMENT_INTERVAL; ?>（秒）ほどお待ち下さい。<br>
	また、スレッドのレス数が<?php echo THREAD_COMMENT_MAX; ?>件に達すると、それ以上レスの投稿はできません。</p>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-3-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レス削除の手順</h3>
		<div class="toggle" id="toggle-3-2">
			<ol>
				<li>あなたが投稿したレスエントリの右下にある「 <i class="fa fa-ellipsis-v" aria-hidden="true"></i> 」＞「レスを削除」をクリックします。</li>
				<li>確認ダイアログが表示されますので、「削除」ボタンをクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>４</span>スレッドのブックマーク</h2>
		<p>スレッドのブックマーク機能を利用するには、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが必要です。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-4-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッドブックマーク追加の手順</h3>
		<div class="toggle" id="toggle-4-1">
			<ol>
				<li>スレッドの一覧から「ぶくま！」ボタンをクリックするか、スレッドページのタイトル下にある「ぶくま！」ボタンをクリックします。</li>
				<li>ブックマークが完了すると、あなたの<?php echo empty($_SESSION['user_id']) ? 'ユーザーページ' : '「<a href="/u/' . $user->u_twitter_id . '">ユーザーページ</a>」'; ?>の<?php echo empty($_SESSION['user_id']) ? 'ぶくま！' : '「<a href="/u/' . $user->u_twitter_id . '/bookmark">ぶくま！</a>」'; ?>タブに追加されます。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-4-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッドブックマーク削除の手順</h3>
		<div class="toggle" id="toggle-4-2">
			<ol>
				<li>ブックマークを削除するには、再度「ぶくま！」ボタンをクリックします。（ボタンの色が変わります）</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>５</span>ユーザーのブックマーク</h2>
		<p>ユーザーのブックマークは、ログインしてない状態でも利用可能です。ブラウザのローカルストレージを使用しているため、ブラウザのCookieや履歴の削除と共に消えますのでご注意ください。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-5-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>ユーザーブックマーク追加の手順</h3>
		<div class="toggle" id="toggle-5-1">
			<ol>
				<li>スレッドエントリ、またはレスエントリの左側に表示されている、丸いTwitterユーザーアイコンをクリックします。</li>
				<li>ブックマークが完了すると、画面左側メニューの「USER BOOK MARK」欄にユーザーページへのリンクが追加されます。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-5-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>ユーザーブックマーク削除の手順</h3>
		<div class="toggle" id="toggle-5-2">
			<ol>
				<li>ブックマークを削除するには、「USER BOOK MARK」欄のユーザーページへのリンクの左側にある、「<i class="fa fa-minus" aria-hidden="true"></i>」ボタンをクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>６</span>タグのブックマーク</h2>
		<p>タグのブックマークは、ログインしてない状態でも利用可能です。ブラウザのローカルストレージを使用しているため、ブラウザのCookieや履歴の削除と共に消えますのでご注意ください。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-6-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>タグブックマーク追加の手順</h3>
		<div class="toggle" id="toggle-6-1">
			<ol>
				<li>スレッドページ上部の、カテゴリ・タグバーの中にある、タグ名の右側に表示されている「<i class="fa fa-plus" aria-hidden="true"></i>」ボタンをクリックするか、タグ検索ページ上部の、タグ名の右側にある「<i class="fa fa-plus" aria-hidden="true"></i>」ボタンをクリックします。</li>
				<li>ブックマークが完了すると、画面左側メニューの「TAG BOOK MARK」欄にタグ検索ページへのリンクが追加されます。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-6-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>タグブックマーク削除の手順</h3>
		<div class="toggle" id="toggle-6-2">
			<ol>
				<li>ブックマークを削除するには、「TAG BOOK MARK」欄のタグ検索ページへのリンクの左側にある、「<i class="fa fa-minus" aria-hidden="true"></i>」ボタンをクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>７</span>NGワード</h2>
		<p>NGワード機能を利用するには、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが必要です。
NGワードを設定すると、あなたの作成したスレッドに、NGワードを含むレスが投稿できなくなります。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-7-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>NGワード登録の手順</h3>
		<div class="toggle" id="toggle-7-1">
			<ol>
				<li>ログイン中に表示される、画面右上のあなたのTwitterユーザーアイコンをクリックして、画面右側にドロワを表示します。</li>
				<li>表示されたドロワの中にある「NG＞ワード」リンクをクリックして、NGワード設定ページに移動します。</li>
				<li>NGワード設定ページの、「<i class="fa fa-commenting-o" aria-hidden="true"></i>」の右側のテキストボックスに、NG設定したいワードを入力します。（半角スペースは入力できません）</li>
				<li>テキストボックスの右側にある「<i class="fa fa-plus" aria-hidden="true"></i>」ボタンをクリックします。</li>
				<li>登録が成功すると、テキストボックスの下の一覧に、NGワードが追加されます。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-7-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>NGワード削除の手順</h3>
		<div class="toggle" id="toggle-7-2">
			<ol>
				<li>NGワード設定ページの、NGワード一覧の右側にある、「<i class="fa fa-times" aria-hidden="true"></i>」ボタンをクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>８</span>NGユーザー</h2>
		<p>NGユーザー機能を利用するには、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが必要です。
NGユーザーを設定すると、あなたの作成したスレッドに、NGユーザーがレス投稿できなくなります。
<em class="site-name"><?php echo SITE_NAME; ?></em>にログインしたことのあるユーザーのみ登録できます。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-8-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>NGユーザー登録の手順</h3>
		<div class="toggle" id="toggle-8-1">
			<ol>
				<li>ログイン中に表示される、画面右上のあなたのTwitterユーザーアイコンをクリックして、画面右側にドロワを表示します。</li>
				<li>表示されたドロワの中にある「NG＞ユーザー」リンクをクリックして、NGユーザー設定ページに移動します。</li>
				<li>NGユーザー設定ページの、「@」の右側のテキストボックスに、NG設定したいユーザーのTwitterID（英数とアンダーバーから成る15文字のID）を入力します。</li>
				<li>テキストボックスの右側にある「<i class="fa fa-plus" aria-hidden="true"></i>」ボタンをクリックします。</li>
				<li>登録が成功すると、テキストボックスの下の一覧に、NGユーザーが追加されます。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-8-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>NGユーザー削除の手順</h3>
		<div class="toggle" id="toggle-8-2">
			<ol>
				<li>NGユーザー設定ページの、NGユーザー一覧の右側にある、「<i class="fa fa-times" aria-hidden="true"></i>」ボタンをクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>９</span>スレッドのスパム報告</h2>
		<p>スレッドのスパム報告を利用するには、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが必要です。
「<a href="/rule"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a>」ページの「スパム報告における注意事項」を読み、ルールに沿って投稿して下さい。
あなたが投稿したスパム報告は、あなたと、スレッドオーナーが閲覧できます。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-9-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッドのスパム報告投稿の手順</h3>
		<div class="toggle" id="toggle-9-1">
			<ol>
				<li>スレッドエントリ、もしくは、スレッドページのスレッドオーナー本文（#0）の右下にある「 <i class="fa fa-ellipsis-v" aria-hidden="true"></i> 」＞「スパム報告」をクリックしてスパム報告ページへ移動します。</li>
				<li>スパム報告ページのフォームに問題の内容を記述し、スパムの種類を選択します。</li>
				<li>「投稿」ボタンをクリックします。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-9-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>スレッドのスパム報告削除の手順</h3>
		<div class="toggle" id="toggle-9-2">
			<ol>
				<li>スパム報告ページの、あなたのスパム報告の右下にある「 <i class="fa fa-ellipsis-v" aria-hidden="true"></i> 」＞「スパム報告を削除」をクリックします。</li>
			</ol>
		</div>
	</section>
	<section>
		<h2><span>１０</span>レスのスパム報告</h2>
		<p>レスのスパム報告を利用するには、<em class="site-name"><?php echo SITE_NAME; ?></em>へのログインが必要です。
「<a href="/rule"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a>」ページの「スパム報告における注意事項」を読み、ルールに沿って投稿して下さい。
あなたが投稿したスパム報告は、あなたと、レス投稿者と、スレッドオーナーが閲覧できます。</p>
		<h3><button class="toggle-button" type="button" data-target="#toggle-10-1"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レスのスパム報告投稿の手順</h3>
		<div class="toggle" id="toggle-10-1">
			<ol>
				<li>レスエントリの右下にある「「 <i class="fa fa-ellipsis-v" aria-hidden="true"></i> 」＞「スパム報告」をクリックしてスパム報告ページへ移動します。</li>
				<li>スパム報告ページのフォームに問題の内容を記述し、スパムの種類を選択します。</li>
				<li>「投稿」ボタンをクリックします。</li>
			</ol>
		</div>
		<h3><button class="toggle-button" type="button" data-target="#toggle-10-2"><i class="fa fa-chevron-down" aria-hidden="true"></i></button>レスのスパム報告削除の手順</h3>
		<div class="toggle" id="toggle-10-2">
			<ol>
				<li>スパム報告ページの、あなたのスパム報告の右下にある「 <i class="fa fa-ellipsis-v" aria-hidden="true"></i> 」＞「スパム報告を削除」をクリックします。</li>
			</ol>
		</div>
	</section>
	<div class="help-footer">
		<p></p>
	</div>
</div>

<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Lib_valid {
	/**
	 * プロパティ
	 * @var [type]
	 */
 	private $ci = null;
	private $ng_words_site = array();
	private $ng_words_user = array();
	/**
	 * [__construct description]
	 * @param [type] $user [description]
	 */
	public function __construct($params = null) {
		$this->ci = &get_instance();
		if (!empty($this->ci) && !empty($this->ci->this_model)) {
			$this->ng_words_site = $this->ci->this_model->getNgWordsSite();
			if (!empty($params['user'])) {
				$this->ng_words_user = $this->ci->this_model->getNgWords($params['user']->user_id);
			}
		}
	}
	/**
	 * カテゴリの存在チェック
	 * @param  [type] $category [description]
	 * @param  [type] $err_msgs [description]
	 */
	public function valid_category($category_id, &$err_msgs) {
		$cid = null;
		if (!empty($category_id) && preg_match('/^[0-9]+$/', $category_id)) {
			if (!empty($this->ci) && !empty($this->ci->this_model)) {
				$c = $this->ci->this_model->getCategory($category_id);
				if (!empty($c)) {
					$cid = $c->category_id;
				} else {
					$err_msgs[] = '存在しないカテゴリが指定されています';
				}
			} else {
				$err_msgs[] = 'カテゴリを取得できませんでした';
			}
		} else {
			$err_msgs[] = 'カテゴリの形式が不正です';
		}
		return $cid;
	}
	/**
	 * タイトルをチェック
	 * @param  [type] $title    [description]
	 * @param  [type] $err_msgs [description]
	 */
	public function valid_title($title, &$err_msgs) {
		if (empty($title) || preg_match('/^(\t|\n|\s|　)+$/su', $title)) {
			$err_msgs[] = 'タイトルを入力してください';
		}
		if (mb_strlen($title) > THREAD_TITLE_LENGTH) {
			$err_msgs[] = 'タイトルの文字が多すぎます（最大100文字まで）';
		}
		if (preg_match('/\t|\n/su', $title)) {
			$err_msgs[] = 'タイトルにタブと改行は使用できません';
		}
		// 連続スペース
		if (preg_match('/(\s|　){' . SEQ_SPACE_MAX . ',}/su', $title)) {
			$err_msgs[] = 'タイトルに連続で5回以上のスペースは記述できません。';
		}
		$is_ng = false;
		foreach ($this->ng_words_site as $ng) {
			$pattern = '/' . $ng . '/sui';
			if (preg_match($pattern, $title)) {
				$is_ng = true;
				break;
			}
		}
		foreach ($this->ng_words_user as $ng) {
			if (strpos($title, $ng) !== false) {
				$is_ng = true;
				break;
			}
		}
		if(strpos($title, '\\') !== false) {
			$is_ng = true;
		}
		if ($is_ng == true) {
			$err_msgs[] = 'タイトルに使用できない文字が含まれています';
		}
		return htmlspecialchars($title, ENT_QUOTES);
	}
	/**
	 * 本文をチェック
	 * @param  [type] $body     [description]
	 * @param  [type] $err_msgs [description]
	 */
	public function valid_body($body, &$err_msgs) {
		if (empty($body) || preg_match('/^(\t|\n|\s|　)+$/su', $body)) {
			$err_msgs[] = '本文を入力してください';
		}
		if (mb_strlen($body) > COMMENT_LENGTH) {
			$err_msgs[] = '本文の文字が多すぎます（最大2000文字まで）';
		}
		// 連続改行
		if (preg_match('/((\t|\s|　)*(\n)(\t|\s|　)*){' . SEQ_NEW_LINE_MAX . ',}/su', $body)) {
			$err_msgs[] = '本文に連続で5回以上の改行はできません。';
		}
		$is_ng = false;
		foreach ($this->ng_words_site as $ng) {
			$pattern = '/' . $ng . '/sui';
			if (preg_match($pattern, $body)) {
				$is_ng = true;
				break;
			}
		}
		foreach ($this->ng_words_user as $ng) {
			if (strpos($body, $ng) !== false) {
				$is_ng = true;
				break;
			}
		}
		if(strpos($body, '\\') !== false) {
			$is_ng = true;
		}
		if ($is_ng == true) {
			$err_msgs[] = '本文に使用できない文字が含まれています';
		}
		return htmlspecialchars($body, ENT_QUOTES);
	}
	/**
	 * タグをチェック
	 * @param  [type] $tags    [description]
	 * @param  [type] $err_msg [description]
	 */
	public function valid_tags($tags, &$err_msg) {
		if (empty($tags)) {
			return array();
		}
		// 空・重複を排除
		$tags = array_values(array_unique(array_filter($tags, 'strlen')));
		foreach ($tags as $tag) {
			if (mb_strlen($tag) > TAG_LENGTH) {
				$err_msg[] = '文字数が多すぎるタグがあります。（最大30文字まで）';
				break;
			}
		}
		foreach ($tags as $tag) {
			if (preg_match('/\t|\s|\n|　/su', $tag)) {
				$err_msg[] = 'タグに空白を含めることはできません';
				break;
			}
		}
		foreach ($tags as $tag) {
			if (empty($tag)) {
				$err_msg[] = 'タグは最低1文字は入力してください';
				break;
			}
		}
		foreach ($tags as $key => $tag) {
			// 非表示設定されたタグは排除
			$is_hide = $this->ci->this_model->isHideTag($tags[$key]);
			if ($is_hide == true) {
				$tags[$key] = '';
			}
		}
		// 空・重複を排除
		$tags = array_values(array_unique(array_filter($tags, 'strlen')));
		// チェック
		$is_ng = false;
		foreach ($this->ng_words_site as $ng) {
			$pattern = '/' . $ng . '/sui';
			foreach ($tags as $tag) {
				if (preg_match($pattern, $tag)) {
					$is_ng = true;
					break 2;
				}
			}
		}
		foreach ($tags as $tag) {
			if(strpos($tag, '\\') !== false) {
				$is_ng = true;
				break;
			}
			if(strpos($tag, '.') !== false) {
				$is_ng = true;
				break;
			}
			if(strpos($tag, '-') !== false) {
				$is_ng = true;
				break;
			}
			if(strpos($tag, "'") !== false) {
				$is_ng = true;
				break;
			}
			if(strpos($tag, '"') !== false) {
				$is_ng = true;
				break;
			}
		}
		if ($is_ng == true) {
			$err_msg[] = 'タグに使用できない文字が含まれています';
		}
		return $tags;
	}
}

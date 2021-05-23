<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Lib_base {
	/**
	 * プロパティ
	 * @var [type]
	 */
	protected $ci = null;
	protected $common = null;
	/**
	 * [__construct description]
	 */
	public function __construct() {
		$this->ci = &get_instance();
		// $this->common = new SiteCommon();
		$this->ci->load->database();
		if (!empty($_COOKIE)) {
			$sess_name = $this->ci->config->item('sess_cookie_name');
			$sess_id = empty($_COOKIE[$sess_name]) ? null : $_COOKIE[$sess_name];
			if (!empty($sess_id)) {
				// セッションクッキーが存在する場合はセッション読み込み
				$this->ci->load->library('session');
			}
		}
	}
	/**
	 * 広告を取得
	 * @param  [type] $type [description]
	 * @return [type]       [description]
	 */
	public function get_adv($type) {
		if (empty($type)) {
			return '';
		}
		if (!$this->ci->load->is_loaded('user_agent')) {
			$this->ci->load->library('user_agent');
		}
		$adv = '';
		switch ($type) {
			case 'entry':
				if ($this->ci->agent->is_mobile()) {
					$adv = $this->ci->this_model->getSiteVarious('adv_entry_smart');
				} else {
					$adv = $this->ci->this_model->getSiteVarious('adv_entry_pc');
				}
				break;

			case 'side':
				if ($this->ci->agent->is_mobile()) {
					$adv = $this->ci->this_model->getSiteVarious('adv_side_smart');
				} else {
					$adv = $this->ci->this_model->getSiteVarious('adv_side_pc');
				}
				break;

			case 'ui':
				$adv = $this->ci->this_model->getSiteVarious('adv_side_ui');
				break;
		}
		return $adv;
	}
	/**
	 * 404エラー
	 * @return [type] [description]
	 */
	public function output_404() {
		//-------------------------------------------------------------------------
		// template変数
		//-------------------------------------------------------------------------
		$temp = new stdClass;
		$temp->content = '';
		$temp->s_user = null;
		$temp->head_params = array('c_name' => 'error', 'title' => 'お探しのページは見つかりません', 'nofollow' => true);
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();
		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->ci->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->ci->this_model->getCategories();
		foreach ($temp->categories as $key => $value) {
			$temp->categories[$key]->subs = $this->ci->this_model->getSubCategories($value->category_id);
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$this->ci->output->set_status_header('404');
		$temp->directories[] = array('dir' => '', 'title' => '<i class="fa fa-home" aria-hidden="true"></i>ホーム');
		$temp->directories[] = array('dir' => '/404', 'title' => '404 Not Found.');
		$temp->dir_title = '存在しないページ';
		$site_error_data = array();
		$site_error_data['adv'] = $this->get_adv('side');
		$temp->content = $this->ci->load->view('site_error', $site_error_data, true);
		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------
		$this->output_template($temp, true);
	}
	/**
	 * テンプレートを出力
	 * @return [type] [description]
	 */
	public function output_template($param, $exit = false) {

		//-------------------------------------------------------------------------
		// HTML
		//-------------------------------------------------------------------------

		$html = new stdClass;
		$html->head = '';
		$html->menu_body = '';
		$html->menu_bottom = '';
		$html->main_header = '';
		$html->content = $param->content;
		$html->sub = '';
		$html->footer = '';

		//-------------------------------------------------------------------------
		// View
		//-------------------------------------------------------------------------

		/**
		 * head
		 */

		$head_data = array();
		$head_data['params'] = $param->head_params;
		$html->head = $this->ci->load->view('head', $head_data, true);

		/**
		 * body > header
		 */

		$menu_body_category = array();
		$menu_body_category['type'] = 'entry';
		$menu_body_category['categories'] = $param->categories;
		$menu_body_category['current'] = $param->category;
		$menu_body_category['p_current'] = $param->p_category;
		$menu_body_category['adv'] = $this->get_adv('side');
		$html->menu_body = $this->ci->load->view('category', $menu_body_category, true);

		/**
		 * body > main > header
		 */

		$breadcrumb_data = array();
		$breadcrumb_data['dir_title'] = $param->dir_title;
		$breadcrumb_data['base_url'] = base_url();
		$breadcrumb_data['directories'] = $param->directories;
		$breadcrumb = $this->ci->load->view('breadcrumb', $breadcrumb_data, true);

		$main_menu_data = array();
		$main_menu_data['breadcrumb'] = $breadcrumb;
		$main_menu_data['user'] = empty($param->s_user) ? null : $param->s_user;
		$main_menu = $this->ci->load->view('main_menu', $main_menu_data, true);
		$html->main_header .= $main_menu;

		/**
		 * #sub
		 */

		if (!empty($param->s_user)) {
			$user_info_data = array();
			$user_info_data['user'] = $param->s_user;
			$user_info_data['adv'] = $this->get_adv('ui');
			$html->sub = $this->ci->load->view('user_info', $user_info_data, true);
		}

		//-------------------------------------------------------------------------
		// Draw
		//-------------------------------------------------------------------------

		$template_data = array();
		$template_data['html'] = $html;
		// すぐに描画して終了するか
		if ($exit == true) {
			echo $this->ci->load->view('template', $template_data, true);
			exit();
		} else {
			$this->ci->load->view('template', $template_data);
		}
	}
}

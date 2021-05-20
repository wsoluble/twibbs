/* --------------------------------------------------------------------
 * jQuery
 * --------------------------------------------------------------------*/

$(document).ready(function(){

	var scroll_y = 0;

	update_menu_tags();
	update_menu_users();

	$('main').headroom({
		'offset':50,
		'tolerance':5,
		'classes':{
			'initial':'headroom',
			'pinned':'pinned',
			'unpinned':'unpinned'
		}
	});

	$(window).on('load resize', function() {
		resize_menu_body();
		resize_user_body();
		resize_user_header();
	});

	$(document).on('click', '#menu, #sub, .overlay-text-box', function(e) {
		e.stopPropagation();
	});

	$('.comment .body').each(function () {
		var conv = conv_res_body(twemoji.parse($(this).find('p').html()), false);
		$(this).find('p').html(conv.body);
		if (conv.media != '') {
			$(this).append(conv.media);
		}
	});

	$(document).on('click', '.toggle-button', function(e) {
		var id = $(this).data('target');
		var button = $(this);
		if ($(id).css('display') == 'none') {
			$(id).slideDown(function() {
				$(button).find('i').removeClass('fa-chevron-down');
				$(button).find('i').addClass('fa-chevron-up');
			});
		} else {
			$(id).slideUp(function() {
				$(button).find('i').removeClass('fa-chevron-up');
				$(button).find('i').addClass('fa-chevron-down');
			});
		}
	});

	$('.remove-ng-form span').each(function () {
		$(this).html(twemoji.parse($(this).html()));
	});

	$('.menu-toggle').sidr({
		name: 'menu',
		speed: 300,
		side: 'left',
		displace: false,
		timing: 'ease-out',
		onOpen: function() {
			scroll_y = $(window).scrollTop();
			$('body,html').css({"position":"fixed","top": -(scroll_y) + "px"});
			$(window).on('touchmove.noScroll', function(e) {
				e.preventDefault();
			});
		},
		onClose: function() {
			$('body,html').css({"position":"static","top": "auto"});
			$('html,body').prop({scrollTop:scroll_y});
			$(window).off('.noScroll');
		}
	});

	$('.sub-toggle').sidr({
		name: 'sub',
		speed: 300,
		side: 'right',
		displace: false,
		timing: 'ease-out',
		onOpen: function() {
			scroll_y = $(window).scrollTop();
			$('body,html').css({"position":"fixed","top": -(scroll_y) + "px"});
			$(window).on('touchmove.noScroll', function(e) {
				e.preventDefault();
			});
		},
		onClose: function() {
			$('body,html').css({"position":"static","top": "auto"});
			$('html,body').prop({scrollTop:scroll_y});
			$(window).off('.noScroll');
		}
	});

	$(document).on('click', 'main', function() {
		$.sidr('close', 'menu');
		$.sidr('close', 'sub');
		if ($('#user-nav').css('display') != 'none') {
			$('#user-nav').hide();
			$('.current-dir').find('i:eq(0)').removeClass('fa-chevron-up');
			$('.current-dir').find('i:eq(0)').addClass('fa-chevron-down');
		}
		if ($('#breadcrumb').css('display') != 'none') {
			$('#breadcrumb').hide();
			$('.breadcrumb button').find('i:eq(0)').removeClass('fa-chevron-up');
			$('.breadcrumb button').find('i:eq(0)').addClass('fa-chevron-down');
		}
		$('.extend-ellipsis').hide();
		$('.extend-display').removeClass('selected');
	});

	$(document).on('click', '.thread-about', function() {
		var button = $(this);
		$('.entry-header .body').slideToggle('normal', function() {
			if ($('.entry-header .body').css('display') == 'none') {
				button.find('i').removeClass('fa-chevron-circle-up');
				button.find('i').addClass('fa-chevron-circle-down');
			} else {
				button.find('i').removeClass('fa-chevron-circle-down');
				button.find('i').addClass('fa-chevron-circle-up');
			}
		});
	});

	$(document).on('click', '#menu-body .category .main > li > button', function() {
		var target = $(this).parent().find('.sub');
		$('#menu-body .category .main button i').removeClass('fa-chevron-up');
		$('#menu-body .category .main button i').addClass('fa-chevron-down');
		$('#menu-body .category .main li').removeAttr('selected');
		if ($(target).css('display') == 'none') {
			$('#menu-body .category .sub').slideUp();
			$(target).slideDown();
			$(this).find('i').removeClass('fa-chevron-down');
			$(this).find('i').addClass('fa-chevron-up');
			$(this).parent().attr('selected', '');
		} else {
			$(target).slideUp();
			$(this).find('i').removeClass('fa-chevron-up');
			$(this).find('i').addClass('fa-chevron-down');
			$(this).parent().removeAttr('selected');
		}
	});

	$(document).on('click', '#truncate-menu-tags', function() {
		if (check_ls()) {
			window.localStorage.setItem('menu_tags', JSON.stringify(new Object()));
			update_menu_tags();
		}
	});

	$(document).on('click', '#truncate-menu-users', function() {
		if (check_ls()) {
			window.localStorage.setItem('menu_users', JSON.stringify(new Object()));
			update_menu_users();
		}
	});

	$('#munu-body-tags .input input').keypress(function(e) {
		if(e.which == 13) {
			add_menu_tag($(this).val());
			$(this).val('');
		}
	});

	$(document).on('click', '#munu-body-tags button.add', function() {
		add_menu_tag($('#munu-body-tags .input input').val());
		$('#munu-body-tags .input input').val('');
	});

	$(document).on('click', '.bookmark-tag, #tag-favorite', function(e) {
		add_menu_tag($(this).val());
	});

	$(document).on('click', '#munu-body-tags button.del', function() {
		remove_menu_tag($(this).prev().html());
	});

	$('#munu-body-users .input input').keypress(function(e) {
		if(e.which == 13) {
			add_menu_user($(this).val());
			$(this).val('');
		}
	});

	$(document).on('click', '#munu-body-users button.add', function() {
		add_menu_user($('#munu-body-users .input input').val());
		$('#munu-body-users .input input').val('');
	});

	$(document).on('click', '#user-favorite, .ufav-button', function() {
		add_menu_user($(this).val());
	});

	$(document).on('click', '#munu-body-users button.del', function() {
		remove_menu_user($(this).prev().html());
	});

	$(document).on('click', '.breadcrumb button', function(e) {
		if ($('#breadcrumb').css('display') == 'none') {
			$('#breadcrumb').slideDown();
			$(this).find('i').removeClass('fa-chevron-down');
			$(this).find('i').addClass('fa-chevron-up');
			$('#menu-user').slideUp();
		} else {
			$('#breadcrumb').slideUp();
			$(this).find('i').removeClass('fa-chevron-up');
			$(this).find('i').addClass('fa-chevron-down');
		}
		e.stopPropagation();
	});

	$(document).on('click', '.login', function() {
		location.href = '/login';
	});

	$(document).on('click', '.current-dir', function(e) {
		if ($('#user-nav').css('display') == 'none') {
			$('#user-nav').slideDown();
			$(this).find('i:eq(0)').removeClass('fa-chevron-down');
			$(this).find('i:eq(0)').addClass('fa-chevron-up');
			$('#menu-user').slideUp();
		} else {
			$('#user-nav').slideUp();
			$(this).find('i:eq(0)').removeClass('fa-chevron-up');
			$(this).find('i:eq(0)').addClass('fa-chevron-down');
		}
		e.stopPropagation();
	});

	$(document).on('click', '.media-buttons button', function(e) {
		var medias = $(this).parent().parent();
		var target = $(medias).find('.media-view');
		var selected = $(this).attr('selected');
		$(medias).find('.media-buttons button').removeAttr('selected');
		$(target).empty();
		if (!selected) {
			$(this).attr('selected', '');
			gen_media_content(this, target);
		}
		e.stopPropagation();
	});

	$(document).on('click', '#overlay-close, #overlay, #overlay-cancel', function(e) {
		close_overlay();
		e.stopPropagation();
	});

	$(document).on('input', '#comment-body', function(e) {
		resize_textarea($(this).get(0));
	});

	$(document).on('keydown keyup change', '#comment-body', function(e) {
		var arr = stringToArray($(this).val());
		var left  = BODY_LENGTH - arr.length;
		if (left < 0) {
			var text = arr.slice(0, BODY_LENGTH).join('');
			$(this).val(text);
			left = 0;
		}
		$('#post-count').html(left);
	});

	$(document).on('click', '#post-conv', function() {
		var body = $('#comment-body').val();
		if (body) {
			var conv = conv_res_body(body);
			conv.body = twemoji.parse(conv.body);
			$('#post-preview').fadeOut(function () {
				$('#post-preview').append('<p></p>').html(conv.body);
				if (conv.media != '') {
					$('#post-preview').append(conv.media);
				}
				$('#post-preview').fadeIn();
			});
		} else {
			$('#post-preview').fadeOut(function () {
				$('#post-preview').empty();
			});
		}
	});

	$(document).on('click', '.extend-display', function(e) {
		var target = $(this).data('target');
		$('.extend-ellipsis').hide();
		$('.extend-display').removeClass('selected');
		$('.' + target).fadeIn();
		$(this).addClass('selected');
		e.stopPropagation();
	});

	$(document).on('click', '.comment-remove', function(e) {
		var cid = $(this).data('cid');
		if (!cid) {
			return;
		}
		var text = '本当にレスを削除しますか？<span class="info">削除すると、データが消去されるため元に戻せません。</span>';
		var body = '';
		body += '<button id="overlay-cancel" type="button">やめる</button>';
		body += '<button id="overlay-apply" class="comment-remove-apply" type="button" data-cid="' + cid + '">削除</button>';
		body += '<p id="overlay-error"></p>';
		$('#overlay-body').html(body);
		show_overlay(text, body);
		e.stopPropagation();
	});

	$(document).on('click', '.thread-remove', function(e) {
		var redirect = $(this).data('redirect') ? 1 : 0;
		var tid = $(this).data('tid');
		if (!tid) {
			return;
		}
		var text = '本当にスレッドを削除しますか？<span class="info">削除すると、データが消去されるため元に戻せません。</span>';
		var body = '';
		body += '<button id="overlay-cancel" type="button">やめる</button>';
		body += '<button id="overlay-apply" class="thread-remove-apply" type="button" data-tid="' + tid + '" data-redirect="' + redirect + '">削除</button>';
		body += '<p id="overlay-error"></p>';
		$('#overlay-body').html(body);
		show_overlay(text, body);
		e.stopPropagation();
	});

	$(document).on('click', '.report-remove', function(e) {
		var method = $(this).data('method');
		var tid = $(this).data('tid');
		var uid = $(this).data('uid');
		if (!method || !tid || !uid) {
			return;
		}
		var text = '本当にスパム報告を削除しますか？<span class="info">投稿者本人が削除する場合は、再投稿が可能です。<br>スレ主が削除する場合は、再投稿できません。</span>';
		var body = '';
		body += '<button id="overlay-cancel" type="button">やめる</button>';
		body += '<button id="overlay-apply" class="report-remove-apply" type="button" data-method="' + method + '" data-tid="' + tid + '" data-uid="' + uid + '">削除</button>';
		body += '<p id="overlay-error"></p>';
		$('#overlay-body').html(body);
		show_overlay(text, body);
		e.stopPropagation();
	});

	$(document).on('click', '.comment-remove-apply', function(e) {
		var cid = $(this).data('cid');
		if (!cid) {
			return;
		}
		$('#overlay-icon').html('<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');
		$('#overlay-icon').addClass('spin');
		$(this).prop('disabled', true);
		$.ajax({
			// url: 'http://' + location.hostname + '/ajax/res/remove',
			url: '/ajax/res/remove',
			type: 'POST',
			dataType: 'html',
			context: this,
			data: {
				'target': cid
			},
			success: function(data) {
				$('#overlay-icon').html('<i class="fa fa-info" aria-hidden="true"></i>');
				$('#overlay-icon').removeClass('spin');
				var st = $(data).attr('id');
				switch (st) {
					case 'ajax-error':
						$('#overlay-error').html($(data).html());
						$(this).prop('disabled', false);
						break;

					case 'ajax-successful':
						var comment = $(data).find('.comment-' + cid);
						if (comment) {
							$('.comment-' + cid).fadeOut(function() {
								$('.comment-' + cid).replaceWith(comment);
								$('.comment-' + cid).fadeIn();
							});
							close_overlay();
						}
						break;

					default:
						break;
				}
			},
			error: function(XMLHttpRequest, status, error) {
				console.log(error);
				$('#overlay-icon').html('<i class="fa fa-info" aria-hidden="true"></i>');
				$('#overlay-icon').removeClass('spin');
			},
		});
		e.stopPropagation();
	});

	$(document).on('click', '.thread-remove-apply', function(e) {
		var redirect = $(this).data('redirect') ? 1 : 0;
		var tid = $(this).data('tid');
		if (!tid) {
			return;
		}
		$('#overlay-icon').html('<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');
		$('#overlay-icon').addClass('spin');
		$(this).prop('disabled', true);
		$.ajax({
			// url: 'http://' + location.hostname + '/ajax/thread/remove',
			url: '/ajax/thread/remove',
			type: 'POST',
			dataType: 'html',
			context: this,
			data: {
				'target': tid
			},
			success: function(data) {
				$('#overlay-icon').html('<i class="fa fa-info" aria-hidden="true"></i>');
				$('#overlay-icon').removeClass('spin');
				var st = $(data).attr('id');
				switch (st) {
					case 'ajax-error':
						$('#overlay-error').html($(data).html());
						$(this).prop('disabled', false);
						break;

					case 'ajax-successful':
						if (redirect == 1) {
							// location.href = 'http://' + location.hostname + '/t/' + tid;
							location.href = '/t/' + tid;
							return;
						}
						var thread = $(data).find('.thread-' + tid);
						if (thread) {
							$('.thread-' + tid).fadeOut(function() {
								$('.thread-' + tid).replaceWith(thread);
								$('.thread-' + tid).fadeIn();
							});
							close_overlay();
						}
						break;

					default:
						break;
				}
			},
			error: function(XMLHttpRequest, status, error) {
				console.log(error);
				$('#overlay-icon').html('<i class="fa fa-info" aria-hidden="true"></i>');
				$('#overlay-icon').removeClass('spin');
			},
		});
		e.stopPropagation();
	});

	$(document).on('click', '.report-remove-apply', function(e) {
		var method = $(this).data('method');
		var tid = $(this).data('tid');
		var uid = $(this).data('uid');
		if (!method || !tid || !uid) {
			return;
		}
		$('#overlay-icon').html('<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');
		$('#overlay-icon').addClass('spin');
		$(this).prop('disabled', true);
		$.ajax({
			// url: 'http://' + location.hostname + '/ajax/' + method + '_report/remove',
			url: '/ajax/' + method + '_report/remove',
			type: 'POST',
			dataType: 'html',
			context: this,
			data: {
				'target': tid,
				'user': uid
			},
			success: function(data) {
				$('#overlay-icon').html('<i class="fa fa-info" aria-hidden="true"></i>');
				$('#overlay-icon').removeClass('spin');
				var st = $(data).attr('id');
				switch (st) {
					case 'ajax-error':
						$('#overlay-error').html($(data).html());
						$(this).prop('disabled', false);
						break;

					case 'ajax-successful':
						$('.spmt-' + tid + '-' + uid).slideUp(function() {
							$('.spmt-' + tid + '-' + uid).remove();
						});
						close_overlay();
						return;
						break;

					default:
						break;
				}
			},
			error: function(XMLHttpRequest, status, error) {
				console.log(error);
				$('#overlay-icon').html('<i class="fa fa-info" aria-hidden="true"></i>');
				$('#overlay-icon').removeClass('spin');
			},
		});
		e.stopPropagation();
	});

	$(document).on('click', '#enq-thread-after a', function(e) {
		var parent = '#enq-thread-after';
		var span = '#enq-thread-after p span';
		var img = '#loading-after-img';
		var loading = $(parent).attr('data-loading');
		if (!loading) {
			$(span).empty();
			$(img).show();
			$(parent).attr('data-loading', 1);
			var url = $(this).attr('href');
			$.ajax({
				// url: 'http://' + location.hostname + url,
				url: url,
				type: 'POST',
				dataType: 'html',
				context: this,
				success: function(data) {
					var st = $(data).attr('id');
					if (st == 'ajax-successful') {
						$('#content .thread').removeClass('new');
						var threads = $(data).find('.threads').clone();
						$(threads).find('.thread').addClass('new');
						if (threads) {
							$(parent).remove();
							$('#content .threads').prepend($(threads).html());
							history.pushState(null, null, url);
							$(span).html('新しいスレッドを取得しました。');
							$(span).show();
							setTimeout(function(){
								$(span).fadeOut('slow', function() {
									$(span).empty();
								});
							}, 1000);
						}
					} else {
						$(span).html('これより新しいスレッドはありません。');
						$(span).show();
						setTimeout(function(){
							$(span).fadeOut('slow', function() {
								$(span).empty();
								$(parent).removeAttr('data-loading');
							});
						}, 3000);
					}
					$(img).hide();
				},
				error: function(XMLHttpRequest, status, error) {
					$(span).html('スレッドを取得できませんでした。');
					$(span).show();
					setTimeout(function(){
						$(span).fadeOut('slow', function() {
							$(span).empty();
							$(parent).removeAttr('data-loading');
						});
					}, 3000);
					$(img).hide();
				},
			});
		}
		return false;
	});

	$(document).on('inview', '#enq-thread-before', function(e, isInView) {
		if (isInView) {
			var img = '#loading-before-img';
			var loading = $(this).attr('data-loading');
			if (!loading) {
				$(img).show();
				$(this).attr('data-loading', 1);
				var url = $(this).data('url');
				$.ajax({
					// url: 'http://' + location.hostname + url,
					url: url,
					type: 'POST',
					dataType: 'html',
					context: this,
					success: function(data) {
						var st = $(data).attr('id');
						if (st == 'ajax-successful') {
							$('#content .thread').removeClass('new');
							var threads = $(data).find('.threads').clone();
							$(threads).find('.thread').addClass('new');
							if (threads) {
								$(this).remove();
								$('#content .threads').append($(threads).html());
								history.pushState(null, null, url);
							}
						} else {
							$(this).removeAttr('data-loading');
						}
						$(img).hide();
					},
					error: function(XMLHttpRequest, status, error) {
						console.log(error);
						$(this).removeAttr('data-loading');
						$(img).hide();
					},
				});
			}
		}
		return false;
	});

	$(document).on('click', '#enq-comment-after a', function(e) {
		var parent = '#enq-comment-after';
		var span = '#enq-comment-after p span';
		var img = '#loading-after-img';
		var loading = $(parent).attr('data-loading');
		if (!loading) {
			$(span).empty();
			$(img).show();
			$(parent).attr('data-loading', 1);
			var url = $(this).attr('href');
			$.ajax({
				// url: 'http://' + location.hostname + url,
				url: url,
				type: 'POST',
				dataType: 'html',
				context: this,
				success: function(data) {
					var st = $(data).attr('id');
					var count = $(data).data('count');
					var filled = $(data).data('filled');
					if (st) {
						if (count > 0) {
							$('#current-comment-count').html(count);
						}
						if (filled == 1) {
							$('.post-comment').slideUp(function() {
								$('.post-comment').remove();
							});
						}
					}
					if (st == 'ajax-successful') {
						$('#content .comment').removeClass('new');
						var comments = $(data).find('.comments').clone();
						$(comments).find('.comment').each(function () {
							var conv = conv_res_body(twemoji.parse($(this).find('p').html()), false);
							$(this).find('p').html(conv.body);
							if (conv.media != '') {
								$(this).find('.footer').before(conv.media);
							}
						});
						$(comments).find('.comment').addClass('new');
						if (comments) {
							$(parent).remove();
							$('#content .comments').prepend($(comments).html());
							if (COMMENT_USE_PUSH_STATE == true) {
								history.pushState(null, null, url);
							}
							$(span).html('新しいレスを取得しました。');
							$(span).show();
							setTimeout(function(){
								$(span).fadeOut('slow', function() {
									$(span).empty();
								});
							}, 1000);
						}
					} else {
						$('#content .comment').removeClass('new');
						$(span).html('これより新しいレスはありません。');
						$(span).show();
						setTimeout(function(){
							$(span).fadeOut('slow', function() {
								$(span).empty();
								$(parent).removeAttr('data-loading');
							});
						}, 3000);
					}
					$(img).hide();
				},
				error: function(XMLHttpRequest, status, error) {
					$(span).html('レスを取得できませんでした。');
					$(span).show();
					setTimeout(function(){
						$(span).fadeOut('slow', function() {
							$(span).empty();
							$(parent).removeAttr('data-loading');
						});
					}, 3000);
					$(img).hide();
				},
			});
		}
		return false;
	});

	$(document).on('inview', '#enq-comment-before', function(e, isInView) {
		if (isInView) {
			var img = '#loading-before-img';
			var loading = $(this).attr('data-loading');
			if (!loading) {
				$(img).show();
				$(this).attr('data-loading', 1);
				var url = $(this).data('url');
				$.ajax({
					// url: 'http://' + location.hostname + url,
					url: url,
					type: 'POST',
					dataType: 'html',
					context: this,
					success: function(data) {
						var st = $(data).attr('id');
						var count = $(data).data('count');
						var filled = $(data).data('filled');
						if (st) {
							if (count > 0) {
								$('#current-comment-count').html(count);
							}
							if (filled == 1) {
								$('.post-comment').slideUp(function() {
									$('.post-comment').remove();
								});
							}
						}
						if (st == 'ajax-successful') {
							$('#content .comment').removeClass('new');
							var comments = $(data).find('.comments').clone();
							$(comments).find('.comment').each(function () {
								var conv = conv_res_body(twemoji.parse($(this).find('p').html()), false);
								$(this).find('p').html(conv.body);
								if (conv.media != '') {
									$(this).find('.footer').before(conv.media);
								}
							});
							$(comments).find('.comment').addClass('new');
							if (comments) {
								$(this).remove();
								$('#content .comments').append($(comments).html());
								if (COMMENT_USE_PUSH_STATE == true) {
									history.pushState(null, null, url);
								}
							}
						} else {
							$('#content .comment').removeClass('new');
							$(this).removeAttr('data-loading');
						}
						$(img).hide();
					},
					error: function(XMLHttpRequest, status, error) {
						console.log(error);
						$(this).removeAttr('data-loading');
						$(img).hide();
					},
				});
			}
		}
		return false;
	});

	$(document).on('click', '.bookmark-button', function() {
		var mode = $(this).attr('data-mode');
		switch (mode) {
			case 'add':
			case 'remove':
				break;

			default:
				return false;
				break;
		}
		var thread = $(this).data('id');
		var loading = $(this).attr('data-loading');
		if (!loading) {
			var e_text = $(this).find('.bookmark-text');
			var e_img = $(this).find('.bookmark-loading');
			var e_count = $(this).find('.bookmark-count var');
			e_img.show();
			e_count.hide();
			$(this).attr('data-loading', 1);
			$.ajax({
				// url: 'http://' + location.hostname + '/ajax/thread/bookmark/' + mode,
				url: '/ajax/thread/bookmark/' + mode,
				type: 'POST',
				dataType: 'html',
				context: this,
				data: {
					'thread': thread
				},
				success: function(data) {
					var st = $(data).attr('id');
					switch (st) {
						case 'ajax-error':
							show_overlay($(data).html());
							break;

						case 'ajax-successful':
							var count = Number(e_count.html());
							switch (mode) {
								case 'add':
									count++;
									$(this).attr('data-mode', 'remove');
									e_text.find('i').removeClass('fa-star');
									e_text.find('i').addClass('fa-check');
									break;

								case 'remove':
									count--;
									$(this).attr('data-mode', 'add');
									e_text.find('i').removeClass('fa-check');
									e_text.find('i').addClass('fa-star');
									break;
							}
							e_count.html(count);
							break;
					}
					$(this).removeAttr('data-loading');
					e_img.hide();
					e_count.show();
				},
				error: function(XMLHttpRequest, status, error) {
					console.log(error);
					$(this).removeAttr('data-loading');
					e_img.hide();
					e_count.show();
				},
			});
		}
	});

});

/* --------------------------------------------------------------------
 * Function
 * --------------------------------------------------------------------*/

function check_ls() {
	try {
		if (typeof(window.localStorage != 'undefined')) {
			return true;
		}
	} catch (e) {
		return false;
	}
	return false;
}

function update_menu_tags() {
	if (check_ls()) {
		$('#munu-body-tags ul').fadeOut(function() {
			var tags = JSON.parse(window.localStorage.getItem('menu_tags'));
			var lists = '';
			for (var key in tags) {
				lists += '<li><i class="fa fa-hashtag" aria-hidden="true"></i><a href="/tag/' + encodeURIComponent(tags[key]['word']).replace(/'/g, '%27') + '">' + tags[key]['word'] + '</a><button class="del"><i class="fa fa-minus" aria-hidden="true"></i></button></li>';
			}
			$('#munu-body-tags ul').html(lists);
			$('#munu-body-tags ul').fadeIn();
		});
	}
}

function add_menu_tag(word) {
	if(check_ls()) {
		var e_text = encodeURIComponent(word).replace(/'/g, '%27');
		if (window.localStorage.getItem('menu_tags') == null) {
			window.localStorage.setItem('menu_tags', JSON.stringify(new Object()));
		}
		var tags = JSON.parse(window.localStorage.getItem('menu_tags'));
		if (e_text != '' && tags != null) {
			var match = false;
			for (var key in tags) {
				if (e_text == key) {
					match = true;
				}
			}
			if (!match) {
				var obj = {};
				obj['word'] = word;
				tags[e_text] = obj;
				window.localStorage.setItem('menu_tags', JSON.stringify(tags));
				update_menu_tags();
			} else {
				$('#munu-body-tags .status').show();
				$('#munu-body-tags .status').html('<span class="error">登録済みです</span>');
				setTimeout(function() {
					$('#munu-body-tags .status').fadeOut('slow');
				},800);
			}
		}
		return false;
	}
}

function remove_menu_tag(tag) {
	if(check_ls()) {
		var e_tag = encodeURIComponent(tag).replace(/'/g, '%27');
		var tags = JSON.parse(window.localStorage.getItem('menu_tags'));
		if (tags != null) {
			var match = false;
			for (var key in tags) {
				if (e_tag == key) {
					delete tags[key];
					match = true;
				}
			}
			if (match) {
				window.localStorage.setItem('menu_tags', JSON.stringify(tags));
				update_menu_tags();
			} else {
				$('#munu-body-tags .status').show();
				$('#munu-body-tags .status').html('<span class="error">削除できませんでした</span>');
				setTimeout(function() {
					$('#munu-body-tags .status').fadeOut('slow');
				},800);
			}
		}
		return false;
	}
}

function update_menu_users() {
	if (check_ls()) {
		$('#munu-body-users ul').fadeOut(function() {
			var tags = JSON.parse(window.localStorage.getItem('menu_users'));
			var lists = '';
			for (var key in tags) {
				lists += '<li><i class="fa fa-twitter" aria-hidden="true"></i><a href="/u/' + tags[key]['screen_name'] + '">' + tags[key]['screen_name'] + '</a><button class="del"><i class="fa fa-minus" aria-hidden="true"></i></button></li>';
			}
			$('#munu-body-users ul').html(lists);
			$('#munu-body-users ul').fadeIn();
		});
	}
}

function add_menu_user(screen_name) {
	if(check_ls()) {
		var text = screen_name;
		if (!text.match(/^[0-9a-zA-Z_]{1,15}$/)) {
			$('#munu-body-users .status').show();
			$('#munu-body-users .status').html('<span class="error">有効なIDを指定してください</span>');
			setTimeout(function() {
				$('#munu-body-users .status').fadeOut('slow');
			},800);
			return;
		}
		if (window.localStorage.getItem('menu_users') == null) {
			window.localStorage.setItem('menu_users', JSON.stringify(new Object()));
		}
		var users = JSON.parse(window.localStorage.getItem('menu_users'));
		if (text != '' && users != null) {
			var match = false;
			for (var key in users) {
				if (text == key) {
					match = true;
				}
			}
			if (!match) {
				var obj = {};
				obj['screen_name'] = screen_name;
				users[text] = obj;
				window.localStorage.setItem('menu_users', JSON.stringify(users));
				update_menu_users();
			} else {
				$('#munu-body-users .status').show();
				$('#munu-body-users .status').html('<span class="error">登録済みです</span>');
				setTimeout(function() {
					$('#munu-body-users .status').fadeOut('slow');
				},800);
			}
		}
		return false;
	}
}

function remove_menu_user(user) {
	if(check_ls()) {
		var users = JSON.parse(window.localStorage.getItem('menu_users'));
		if (users != null) {
			var match = false;
			for (var key in users) {
				if (user == key) {
					delete users[key];
					match = true;
				}
			}
			if (match) {
				window.localStorage.setItem('menu_users', JSON.stringify(users));
				update_menu_users();
			} else {
				$('#munu-body-users .status').show();
				$('#munu-body-users .status').html('<span class="error">削除に失敗しました</span>');
				setTimeout(function() {
					$('#munu-body-users .status').fadeOut('slow');
				},800);
			}
		}
		return false;
	}
}

function resize_menu_body() {
	var height = window.innerHeight ? window.innerHeight : $(window).height();
	height = height - $('#logo').outerHeight() - $('#menu-top').outerHeight() - $('#menu-bottom').outerHeight();
	$('#menu-body').outerHeight(height);
}

function resize_user_body() {
	var height = window.innerHeight ? window.innerHeight : $(window).height();
	height = height - $('.user-info-top').outerHeight() - $('.user-info-bottom').outerHeight();
	$('.user-info-body').outerHeight(height);
}

function resize_user_header() {
	if ($('.user-header').is('*')) {
		user_header_outer_width = $('.user-header').innerWidth();
		if ($('.user-header').hasClass('smart') == false) {
			user_header_inner_width = $('.user-header-thumb').outerWidth();
			$('#user-nav li').each(function () {
				user_header_inner_width += $(this).outerWidth();
			});
		}
		if (user_header_outer_width <= user_header_inner_width) {
			if ($('.user-header').hasClass('smart') == false) {
				$('.user-header').addClass('smart');
			}
		}	else {
			if ($('.user-header').hasClass('smart') == true) {
				$('.user-header').removeClass('smart');
			}
		}
	}
}

function conv_res_body(body, escape) {
	var ret = {
		body: '',
		media: ''
	};
	if (escape) {
		body = escape_html(body);
	}
	var medias = [];
	ret.body = body.replace(/((http|https):\/\/[\w?=&.,\/-;#~%-]+(?![\w\s?&.,\/;#~%"=-]*>))/g, function(match) {
		var buf = '';
		var m = null;
		var e = null;
		var d = match.replace(/(http|https):\/\//, '');
		if (m = d.match(/^twitter\.com\/([a-zA-Z0-9_]{1,15})\/status\/([0-9]+)/)) {
			e = {};
			e.type = 'tweet';
			e.site = 'twitter';
			e.id = m[1];
			e.status = m[2];
			buf = '<div class="link link-tweet">' +
							'<em class="' + e.type + ' ' + e.site + '"' + '>' + (medias.length + 1) + '</em>' +
							'<i class="fa fa-twitter" aria-hidden="true"></i>' +
							'<a href="' + match + '" target="_blank" rel="nofollow">' + match + '</a>' +
						'</div>';
		} else if (m = d.match(/^(i\.)?imgur\.com\/([0-9a-zA-Z]+)(\.([0-9a-zA-Z]+))?/)) {
			e = {};
			e.type = 'image';
			e.site = 'imgur';
			e.id = m[2];
			buf = '<div class="link link-imgur">' +
							'<em class="' + e.type + ' ' + e.site + '"' + '>' + (medias.length + 1) + '</em>' +
							'<i class="fa fa-picture-o" aria-hidden="true"></i>' +
							'<a href="' + match + '" target="_blank" rel="nofollow">' + match + '</a>' +
						'</div>';
		} else if (m = d.match(/^(youtu\.be|www\.youtube\.com)\/(watch\?v=)?([^&?]+)/)) {
			e = {};
			e.type = 'video';
			e.site = 'youtube';
			e.id = m[3];
			buf = '<div class="link link-youtube">' +
							'<em class="' + e.type + ' ' + e.site + '"' + '>' + (medias.length + 1) + '</em>' +
							'<i class="fa fa-youtube-play" aria-hidden="true"></i>' +
							'<a href="' + match + '" target="_blank" rel="nofollow">' + match + '</a>' +
						'</div>';
		} else if (m = d.match(/^(nico\.ms|www\.nicovideo\.jp)\/(watch\/)?((sm)?([0-9]+))/)) {
			e = {};
			e.type = 'video';
			e.site = 'niconico';
			e.id = m[3];
			buf = '<div class="link link-nicovideo">' +
							'<em class="' + e.type + ' ' + e.site + '"' + '>' + (medias.length + 1) + '</em>' +
							'<i class="fa fa-youtube-play" aria-hidden="true"></i>' +
							'<a href="' + match + '" target="_blank" rel="nofollow">' + match + '</a>' +
						'</div>';
		} else {
			buf = '<div class="link"><i class="fa fa-external-link" aria-hidden="true"></i><a href="' + match + '" target="_blank" rel="nofollow">' + match + '</a></div>';
		}
		if (e) {
			medias.push(e);
		}
		return buf;
	});
	if (medias.length != 0) {
		ret.media = gen_medias(medias);
	}
	return ret;
}

function gen_medias(medias) {
	var html = '';
	var button = '<div class="media-buttons">';
	var view = '<div class="media-view"></div>';
	for (var key in medias) {
		button += '<button type="button" data-site="' + medias[key].site + '" data-type="' + medias[key].type + '" data-id="' + medias[key].id + '" class="' + medias[key].type + ' ' + medias[key].site + '"';
		switch (medias[key].site) {
			case 'twitter':
				button += ' data-status="' + medias[key].status + '"><em>' + (Number(key) + 1) + '</em><i class="fa fa-twitter" aria-hidden="true"></i>';
				break;

			case 'imgur':
				button += '><em>' + (Number(key) + 1) + '</em><i class="fa fa-picture-o" aria-hidden="true"></i>';
				break;

			case 'youtube':
				button += '><em>' + (Number(key) + 1) + '</em><i class="fa fa-youtube-play" aria-hidden="true"></i>';
				break;

			case 'niconico':
				button += '><em>' + (Number(key) + 1) + '</em><i class="fa fa-youtube-play" aria-hidden="true"></i>';
				break;

			default:
				break;
		}
		button += '</button>';
	}
	button += '</div>';
	html += '<div class="medias">' + button + view + '</div>';
	return html;
}

function gen_media_content(button, target) {
	var html = '';
	var site = $(button).data('site');
	var type = $(button).data('type');
	var id = $(button).data('id');
	switch (site) {
		case 'twitter':
			html = '<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"></p><a href="https://twitter.com/' + id + '/status/' + $(button).data('status') + '"></a></blockquote><script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>';
			break;

		case 'imgur':
			html = '<blockquote class="imgur-embed-pub" lang="ja" data-id="' + id + '"><a href="//imgur.com/' + id + '"></a></blockquote><script async src="//s.imgur.com/min/embed.js" charset="utf-8"></script>';
			break;

		case 'youtube':
			html = '<iframe class="youtube" src="https://www.youtube.com/embed/' + id + '" frameborder="0" allowfullscreen></iframe>';
			break;

		case 'niconico':
			document._write = document.write;
			document.write = function(msg){
					$(target).html(msg);
					document.write = document._write;
			}
			var w = ($(target).width() > 560) ? 560 : $(target).width();
			var h = Math.floor(w * 9 / 16);
			html = '<script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/' + id + '?w=' + w + '&h=' + h + '"></script>';
			break;

		default:
			break;
	}
	$(target).html(html);
}

function escape_html(html) {
	return $('<div>').text(html).html();
}

function stringToArray(str) {
	return str.match(/[\uD800-\uDBFF][\uDC00-\uDFFF]|[^\uD800-\uDFFF]/g) || [];
}

function show_overlay(text, body) {
	$('#overlay-text').html(text);
	$('#overlay-body').html(body);
	$('#overlay').fadeIn().css('display','table');
}

function close_overlay() {
	$('#overlay').fadeOut(function () {
		$('#overlay-text').empty();
		$('#overlay-body').empty();
		$('#overlay-icon').html('<i class="fa fa-info" aria-hidden="true"></i>');
		$('#overlay-icon').removeClass('spin');
	});
}

function resize_textarea(e) {
	if (!e) {
		return;
	}
	var line_height = $(e).css('line-height').split('px')[0];
	var padding = $(e).css('padding-top').split('px')[0];
	var lineHeight = Number(line_height - padding * 2);
	if(e.scrollHeight > e.offsetHeight) {
		$(e).height(e.scrollHeight - padding * 2);
	} else {
		while (true){
			$(e).height($(e).height() - lineHeight);
			if(e.scrollHeight > e.offsetHeight){
				$(e).height(e.scrollHeight - padding * 2);
				break;
			}
		}
	}
}

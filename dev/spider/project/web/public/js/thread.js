var post_interval = null;
var post_interval_count = 0;

$(document).ready(function() {

	$(document).on('click', '#post-submit', function() {
		var html = $(this).html();
		var thread = $('#post-thread-id').val();
		var body = $('#comment-body').val();
		var start = $('#enq-comment-after').data('after');
		if (body == '') {
			$('#post-status').html('<span class="ajax-error">本文が空です</span>');
			$('#post-status').show();
			setTimeout(function() {
				$('#post-status').fadeOut('slow');
			},800);
			return false;
		}
		$(this).html(html + '<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');
		$(this).addClass('spin');
		$(this).prop('disabled', true);
		$.ajax({
			// url: 'http://' + location.hostname + '/ajax/res/add',
			url: '/ajax/res/add',
			type: 'POST',
			dataType: 'html',
			context: this,
			data: {
				'thread': thread,
				'body': body,
				'start': start
			},
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
				switch (st) {
					case 'ajax-error':
						var redirect = $(data).data('redirect') ? 1 : 0;
						if (redirect) {
							var sec = $(data).data('sec') ? Number($(data).data('sec')) : 0;
							var msec = sec ? sec * 1000 : 0;
							setTimeout(function() {
								// location.href = 'http://' + location.hostname + '/t/' + thread;
								location.href = '/t/' + thread;
							}, msec);
							post_interval_count = sec;
						} else {
							post_interval_count = 10;
						}
						$('#post-status').html($(data).html());
						$('#post-status').show();
						setTimeout(function() {
							$('#post-status').fadeOut('slow');
						}, 3000);
						post_interval = setInterval(post_interval_decrement, 1000);
						update_post_interval_count();
						$(this).prop('disabled', true);
						break;

					case 'ajax-successful':
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
							$('#enq-comment-after').remove();
							$('#content .comments').prepend($(comments).html());
						}
						$('#post-preview').fadeOut().empty();
						$('#comment-body').val('');
						post_interval_count = POST_COMMENT_INTERVAL;
						post_interval = setInterval(post_interval_decrement, 1000);
						update_post_interval_count();
						$(this).prop('disabled', true);
						break;

					default:
						break;
				}
				$('#comment-body').trigger('input');
				$(this).html(html);
				$(this).removeClass('spin');
			},
			error: function(XMLHttpRequest, status, error) {
				console.log(error);
			},
		});
	});

});

function post_interval_decrement() {
	post_interval_count--;
	update_post_interval_count();
	if (post_interval_count <= 0) {
		clearInterval(post_interval);
		$('#post-submit-interval').remove();
		$('#post-submit').prop('disabled', false);
	}
}

function update_post_interval_count() {
	if ($('#post-submit-interval').get(0)) {
		$('#post-submit-interval').html(post_interval_count);
	} else {
		$('#post-submit').append('<span id="post-submit-interval">' + post_interval_count + '</span>');
	}
}
